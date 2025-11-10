import Foundation

struct LoanPetition: Codable, Identifiable {
    let id: String
    let borrower: User
    let amount: Double
    let currency: Currency
    let apr: Double
    let termMonths: Int
    let purpose: String
    let description: String
    let fundedPercentage: Double
    let createdAt: Date
    let coreScore: Int
    let isVerified: Bool
    let repaymentSchedule: RepaymentSchedule
    let isTradeableNote: Bool
    let useConsumerCredit: Bool
    let hasCosigner: Bool
    let cosigner: User?
    let isSecured: Bool
    let collateralTypes: [CollateralType]?
    let governingLaw: String
    let additionalTerms: String?

    var monthlyPayment: Double {
        guard termMonths > 0, apr > 0 else { return 0 }
        let rate = apr / 100 / 12
        let months = Double(termMonths)
        let factor = pow(1 + rate, months)
        return amount * (rate * factor) / (factor - 1)
    }

    var totalInterest: Double {
        (monthlyPayment * Double(termMonths)) - amount
    }
}

enum Currency: String, Codable, CaseIterable {
    case usd = "USD"
    case eur = "EUR"
    case gbp = "GBP"
    case jpy = "JPY"
    case cad = "CAD"
    case aud = "AUD"
    case usdc = "USDC"
    case usdt = "USDT"
    case btc = "BTC"
    case eth = "ETH"

    var symbol: String {
        switch self {
        case .usd: return "$"
        case .eur: return "€"
        case .gbp: return "£"
        case .jpy: return "¥"
        case .cad: return "C$"
        case .aud: return "A$"
        case .usdc, .usdt: return "$"
        case .btc: return "₿"
        case .eth: return "Ξ"
        }
    }

    var isFiat: Bool {
        switch self {
        case .usd, .eur, .gbp, .jpy, .cad, .aud:
            return true
        default:
            return false
        }
    }
}

enum RepaymentSchedule: String, Codable, CaseIterable {
    case monthly = "Monthly"
    case quarterly = "Quarterly"
    case balloon = "Balloon"
}

enum CollateralType: String, Codable, CaseIterable {
    case vehicle = "Vehicle (VIN)"
    case cash = "Cash/Stablecoin Deposit"
    case realEstate = "Real Estate"
    case securities = "Securities (stocks/bonds)"
    case accountsReceivable = "Accounts Receivable"
    case nft = "NFT / Digital Asset"
    case personalGuarantee = "Personal Guarantee"
    case other = "Other"
}

extension LoanPetition {
    static let mockPetitions: [LoanPetition] = [
        LoanPetition(
            id: "1",
            borrower: User.mock,
            amount: 5000,
            currency: .usd,
            apr: 7.5,
            termMonths: 12,
            purpose: "Small Business Inventory",
            description: "Growing my online boutique business. Need inventory for the holiday season.",
            fundedPercentage: 45,
            createdAt: Date().addingTimeInterval(-172800),
            coreScore: 720,
            isVerified: true,
            repaymentSchedule: .monthly,
            isTradeableNote: true,
            useConsumerCredit: true,
            hasCosigner: false,
            cosigner: nil,
            isSecured: true,
            collateralTypes: [.vehicle],
            governingLaw: "California, USA",
            additionalTerms: nil
        ),
        LoanPetition(
            id: "2",
            borrower: User.mock,
            amount: 3000,
            currency: .usd,
            apr: 6.0,
            termMonths: 6,
            purpose: "Medical Emergency",
            description: "Unexpected medical expenses not covered by insurance.",
            fundedPercentage: 78,
            createdAt: Date().addingTimeInterval(-18000),
            coreScore: 680,
            isVerified: true,
            repaymentSchedule: .monthly,
            isTradeableNote: false,
            useConsumerCredit: true,
            hasCosigner: false,
            cosigner: nil,
            isSecured: false,
            collateralTypes: nil,
            governingLaw: "New York, USA",
            additionalTerms: nil
        )
    ]
}
