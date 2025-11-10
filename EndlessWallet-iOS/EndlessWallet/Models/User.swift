import Foundation

struct User: Codable, Identifiable {
    let id: String
    let name: String
    let email: String
    let coreScore: Int // Credit & Obligation Rating Evaluation (300-850)
    let ficoScore: Int?
    let netWorth: Double
    let checkingBalance: Double
    let loansReceivable: Double
    let realAssets: Double
    let stocks: Double
    let bonds: Double
    let crypto: Double
    let debtToAssets: Double
    let debtToIncome: Double
    let borrowingCapacity: Double
    let kycVerified: Bool
    let bankConnected: Bool

    var totalDebt: Double {
        netWorth * (debtToAssets / 100)
    }

    var availableToLend: Double {
        checkingBalance * 0.5
    }
}

extension User {
    static let mock = User(
        id: UUID().uuidString,
        name: "Troy",
        email: "troy@endlesswallet.io",
        coreScore: 720,
        ficoScore: 720,
        netWorth: 95000,
        checkingBalance: 24000,
        loansReceivable: 6000,
        realAssets: 12350,
        stocks: 32300,
        bonds: 5000,
        crypto: 3500,
        debtToAssets: 15.0,
        debtToIncome: 16.0,
        borrowingCapacity: 13400,
        kycVerified: true,
        bankConnected: true
    )
}
