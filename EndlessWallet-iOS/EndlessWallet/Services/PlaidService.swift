import Foundation
import LinkKit

/// Service to handle Plaid bank account linking
class PlaidService: NSObject, ObservableObject {
    @Published var linkToken: String?
    @Published var publicToken: String?
    @Published var accountId: String?

    private let backendURL = "https://your-backend.com/api"

    /// Create a Plaid Link token from your backend
    func createLinkToken() async throws -> String {
        guard let url = URL(string: "\(backendURL)/plaid/create-link-token") else {
            throw PlaidError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw PlaidError.serverError
        }

        let result = try JSONDecoder().decode(LinkTokenResponse.self, from: data)

        await MainActor.run {
            self.linkToken = result.linkToken
        }

        return result.linkToken
    }

    /// Present Plaid Link UI to connect bank account
    func presentPlaidLink(from viewController: UIViewController) async throws {
        guard let linkToken = linkToken else {
            let token = try await createLinkToken()
            self.linkToken = token
        }

        guard let token = linkToken else {
            throw PlaidError.missingToken
        }

        let config = LinkTokenConfiguration(token: token) { [weak self] success in
            self?.handlePlaidSuccess(success)
        } onExit: { exit in
            print("Plaid Link exited: \(exit)")
        }

        let result = Plaid.create(config)
        switch result {
        case .success(let handler):
            handler.open(presentUsing: .custom({ linkViewController in
                viewController.present(linkViewController, animated: true)
            }))
        case .failure(let error):
            throw PlaidError.initializationFailed(error)
        }
    }

    /// Exchange public token for access token on your backend
    func exchangePublicToken(_ publicToken: String) async throws -> String {
        guard let url = URL(string: "\(backendURL)/plaid/exchange-token") else {
            throw PlaidError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters = ["public_token": publicToken]
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw PlaidError.serverError
        }

        let result = try JSONDecoder().decode(ExchangeTokenResponse.self, from: data)
        return result.accessToken
    }

    /// Get bank account balance via your backend
    func getAccountBalance(accessToken: String) async throws -> BankBalance {
        guard let url = URL(string: "\(backendURL)/plaid/balance") else {
            throw PlaidError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters = ["access_token": accessToken]
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw PlaidError.serverError
        }

        return try JSONDecoder().decode(BankBalance.self, from: data)
    }

    // MARK: - Private Methods

    private func handlePlaidSuccess(_ success: LinkSuccess) {
        Task {
            do {
                let accessToken = try await exchangePublicToken(success.publicToken)
                await MainActor.run {
                    self.publicToken = success.publicToken
                    // Save access token securely
                    print("Successfully linked bank account with access token: \(accessToken)")
                }
            } catch {
                print("Error exchanging token: \(error)")
            }
        }
    }
}

// MARK: - Response Models

struct LinkTokenResponse: Codable {
    let linkToken: String

    enum CodingKeys: String, CodingKey {
        case linkToken = "link_token"
    }
}

struct ExchangeTokenResponse: Codable {
    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}

struct BankBalance: Codable {
    let available: Double
    let current: Double
    let currency: String
}

// MARK: - Errors

enum PlaidError: LocalizedError {
    case invalidURL
    case serverError
    case missingToken
    case initializationFailed(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid Plaid URL"
        case .serverError:
            return "Server error occurred"
        case .missingToken:
            return "Missing link token"
        case .initializationFailed(let error):
            return "Failed to initialize Plaid: \(error.localizedDescription)"
        }
    }
}
