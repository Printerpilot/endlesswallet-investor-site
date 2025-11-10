import Foundation
import StripePaymentSheet

/// Service to handle Stripe payment processing
class StripePaymentService: ObservableObject {
    @Published var paymentSheet: PaymentSheet?
    @Published var paymentResult: PaymentSheetResult?

    // IMPORTANT: Replace with your actual backend endpoint
    private let backendURL = "https://your-backend.com/api"

    /// Initialize payment for funding a loan
    func initiateLoanPayment(amount: Double, currency: Currency, loanId: String) async throws {
        // Create payment intent on your backend
        let paymentIntentClientSecret = try await createPaymentIntent(
            amount: amount,
            currency: currency.rawValue,
            loanId: loanId
        )

        // Configure PaymentSheet
        var configuration = PaymentSheet.Configuration()
        configuration.merchantDisplayName = "Endless Wallet"
        configuration.allowsDelayedPaymentMethods = true

        // Create payment sheet
        await MainActor.run {
            self.paymentSheet = PaymentSheet(
                paymentIntentClientSecret: paymentIntentClientSecret,
                configuration: configuration
            )
        }
    }

    /// Create ACH transfer for loan repayment
    func initiateACHTransfer(
        amount: Double,
        recipientBankToken: String,
        loanId: String
    ) async throws -> String {
        // Call your backend to initiate ACH transfer via Stripe
        // This is a placeholder - implement your actual backend call
        let parameters: [String: Any] = [
            "amount": amount,
            "bank_token": recipientBankToken,
            "loan_id": loanId
        ]

        let transferId = try await callBackend(
            endpoint: "/transfers/create",
            parameters: parameters
        )

        return transferId
    }

    /// Process payment for purchasing a tradeable note
    func purchaseNote(noteId: String, amount: Double) async throws {
        let paymentIntentClientSecret = try await createPaymentIntent(
            amount: amount,
            currency: "USD",
            metadata: ["note_id": noteId]
        )

        var configuration = PaymentSheet.Configuration()
        configuration.merchantDisplayName = "Endless Wallet"

        await MainActor.run {
            self.paymentSheet = PaymentSheet(
                paymentIntentClientSecret: paymentIntentClientSecret,
                configuration: configuration
            )
        }
    }

    // MARK: - Private Helper Methods

    private func createPaymentIntent(
        amount: Double,
        currency: String,
        loanId: String? = nil,
        metadata: [String: String]? = nil
    ) async throws -> String {
        // Convert amount to cents
        let amountInCents = Int(amount * 100)

        var parameters: [String: Any] = [
            "amount": amountInCents,
            "currency": currency.lowercased()
        ]

        if let loanId = loanId {
            parameters["loan_id"] = loanId
        }

        if let metadata = metadata {
            parameters["metadata"] = metadata
        }

        // Call your backend to create payment intent
        let clientSecret: String = try await callBackend(
            endpoint: "/payments/create-intent",
            parameters: parameters
        )

        return clientSecret
    }

    private func callBackend<T: Decodable>(
        endpoint: String,
        parameters: [String: Any]
    ) async throws -> T {
        guard let url = URL(string: backendURL + endpoint) else {
            throw PaymentError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw PaymentError.serverError
        }

        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}

enum PaymentError: LocalizedError {
    case invalidURL
    case serverError
    case paymentFailed

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid payment URL"
        case .serverError:
            return "Server error occurred"
        case .paymentFailed:
            return "Payment failed"
        }
    }
}
