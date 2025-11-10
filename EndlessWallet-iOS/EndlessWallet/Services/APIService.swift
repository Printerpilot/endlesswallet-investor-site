import Foundation
import Alamofire

/// Main API service for communicating with Endless Wallet backend
class APIService: ObservableObject {
    static let shared = APIService()

    // IMPORTANT: Replace with your actual backend URL
    private let baseURL = "https://your-backend.com/api"

    private let session: Session

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 300

        self.session = Session(configuration: configuration)
    }

    // MARK: - Authentication

    func signIn(email: String, password: String) async throws -> AuthResponse {
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]

        return try await request(
            endpoint: "/auth/login",
            method: .post,
            parameters: parameters
        )
    }

    func signUp(
        firstName: String,
        lastName: String,
        email: String,
        password: String
    ) async throws -> AuthResponse {
        let parameters: [String: String] = [
            "first_name": firstName,
            "last_name": lastName,
            "email": email,
            "password": password
        ]

        return try await request(
            endpoint: "/auth/register",
            method: .post,
            parameters: parameters
        )
    }

    // MARK: - Petitions

    func fetchPetitions(filter: String? = nil) async throws -> [LoanPetition] {
        var endpoint = "/petitions"
        if let filter = filter {
            endpoint += "?filter=\(filter)"
        }

        let response: PetitionsResponse = try await request(
            endpoint: endpoint,
            method: .get
        )
        return response.petitions
    }

    func createPetition(petition: CreatePetitionRequest) async throws -> LoanPetition {
        return try await request(
            endpoint: "/petitions",
            method: .post,
            parameters: petition
        )
    }

    func fundPetition(petitionId: String, amount: Double) async throws -> FundingResponse {
        let parameters: [String: Any] = [
            "petition_id": petitionId,
            "amount": amount
        ]

        return try await request(
            endpoint: "/petitions/fund",
            method: .post,
            parameters: parameters
        )
    }

    // MARK: - Tradeable Notes

    func fetchTradeableNotes() async throws -> [TradeableNote] {
        let response: NotesResponse = try await request(
            endpoint: "/notes/marketplace",
            method: .get
        )
        return response.notes
    }

    func purchaseNote(noteId: String, offerPrice: Double) async throws -> PurchaseResponse {
        let parameters: [String: Any] = [
            "note_id": noteId,
            "offer_price": offerPrice
        ]

        return try await request(
            endpoint: "/notes/purchase",
            method: .post,
            parameters: parameters
        )
    }

    func listNote(
        noteId: String,
        askingPrice: Double,
        listingType: ListingType
    ) async throws -> ListingResponse {
        let parameters: [String: Any] = [
            "note_id": noteId,
            "asking_price": askingPrice,
            "listing_type": listingType.rawValue
        ]

        return try await request(
            endpoint: "/notes/list",
            method: .post,
            parameters: parameters
        )
    }

    // MARK: - User Profile

    func fetchUserProfile() async throws -> User {
        return try await request(
            endpoint: "/user/profile",
            method: .get
        )
    }

    func updateProfile(updates: [String: Any]) async throws -> User {
        return try await request(
            endpoint: "/user/profile",
            method: .put,
            parameters: updates
        )
    }

    // MARK: - Credit Lines

    func extendCreditLine(
        recipientId: String,
        amount: Double,
        interestRate: Double
    ) async throws -> CreditLineResponse {
        let parameters: [String: Any] = [
            "recipient_id": recipientId,
            "amount": amount,
            "interest_rate": interestRate
        ]

        return try await request(
            endpoint: "/credit/extend",
            method: .post,
            parameters: parameters
        )
    }

    // MARK: - Private Request Handler

    private func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        headers: HTTPHeaders? = nil
    ) async throws -> T {
        let url = baseURL + endpoint

        return try await withCheckedThrowingContinuation { continuation in
            session.request(
                url,
                method: method,
                parameters: parameters,
                encoding: encoding,
                headers: headers
            )
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

// MARK: - Request/Response Models

struct AuthResponse: Codable {
    let user: User
    let token: String
}

struct PetitionsResponse: Codable {
    let petitions: [LoanPetition]
}

struct NotesResponse: Codable {
    let notes: [TradeableNote]
}

struct CreatePetitionRequest: Codable {
    let amount: Double
    let currency: String
    let apr: Double
    let termMonths: Int
    let purpose: String
    let description: String
    let repaymentSchedule: String
    let isTradeableNote: Bool
    let useConsumerCredit: Bool
    let hasCosigner: Bool
    let isSecured: Bool
    let collateralTypes: [String]?
    let governingLaw: String
    let additionalTerms: String?
}

struct FundingResponse: Codable {
    let success: Bool
    let transactionId: String
}

struct PurchaseResponse: Codable {
    let success: Bool
    let transactionId: String
    let note: TradeableNote
}

struct ListingResponse: Codable {
    let success: Bool
    let listingId: String
}

struct CreditLineResponse: Codable {
    let success: Bool
    let creditLineId: String
}
