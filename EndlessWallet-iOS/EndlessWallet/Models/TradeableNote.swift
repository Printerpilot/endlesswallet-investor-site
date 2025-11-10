import Foundation

struct TradeableNote: Codable, Identifiable {
    let id: String
    let borrower: User
    let originalAmount: Double
    let remainingBalance: Double
    let apr: Double
    let termRemainingMonths: Int
    let totalTermMonths: Int
    let askingPrice: Double
    let purpose: String
    let paymentsOnTime: Int
    let totalPayments: Int
    let listingType: ListingType
    let coreScore: Int
    let isVerified: Bool
    let listedAt: Date

    var discountPercentage: Double {
        guard remainingBalance > 0 else { return 0 }
        return ((remainingBalance - askingPrice) / remainingBalance) * 100
    }

    var yieldToMaturity: Double {
        guard askingPrice > 0, termRemainingMonths > 0 else { return 0 }
        let yearsRemaining = Double(termRemainingMonths) / 12.0
        return ((remainingBalance - askingPrice) / askingPrice * 100) / yearsRemaining
    }

    var progressPercentage: Double {
        let paidMonths = Double(totalTermMonths - termRemainingMonths)
        return (paidMonths / Double(totalTermMonths)) * 100
    }
}

enum ListingType: String, Codable {
    case partial = "Partial"
    case fullNote = "Full Note"
    case split = "Split (50%)"
}

extension TradeableNote {
    static let mockNotes: [TradeableNote] = [
        TradeableNote(
            id: "1",
            borrower: User.mock,
            originalAmount: 5000,
            remainingBalance: 2800,
            apr: 7.5,
            termRemainingMonths: 7,
            totalTermMonths: 12,
            askingPrice: 2650,
            purpose: "Small Business Inventory",
            paymentsOnTime: 5,
            totalPayments: 5,
            listingType: .partial,
            coreScore: 720,
            isVerified: true,
            listedAt: Date().addingTimeInterval(-86400)
        ),
        TradeableNote(
            id: "2",
            borrower: User.mock,
            originalAmount: 10000,
            remainingBalance: 10000,
            apr: 8.0,
            termRemainingMonths: 24,
            totalTermMonths: 24,
            askingPrice: 9200,
            purpose: "Home Renovation",
            paymentsOnTime: 0,
            totalPayments: 0,
            listingType: .fullNote,
            coreScore: 690,
            isVerified: true,
            listedAt: Date().addingTimeInterval(-43200)
        )
    ]
}
