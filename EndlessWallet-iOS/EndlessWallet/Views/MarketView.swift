import SwiftUI

struct MarketView: View {
    @State private var notes = TradeableNote.mockNotes

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.09, green: 0.145, blue: 0.329),
                        Color(red: 0.059, green: 0.09, blue: 0.165)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 0) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Note Marketplace")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)

                        Text("Buy and sell tradeable loan notes from verified lenders")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 20)

                    // Notes List
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(notes) { note in
                                NoteCard(note: note)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct NoteCard: View {
    let note: TradeableNote

    var body: some View {
        VStack(spacing: 16) {
            // Header
            HStack(spacing: 12) {
                // Avatar
                Circle()
                    .fill(Color(red: 59/255, green: 130/255, blue: 246/255))
                    .frame(width: 48, height: 48)
                    .overlay(
                        Text(String(note.borrower.name.prefix(1)))
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    )

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 6) {
                        Text(note.borrower.name)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)

                        if note.isVerified {
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 14))
                                .foregroundColor(Color(red: 0, green: 201/255, blue: 87/255))
                        }
                    }

                    Text("CORE Score: \(note.coreScore)")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Text("Asking Price")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)

                    Text("$\(Int(note.askingPrice), format: .number)")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(red: 0, green: 201/255, blue: 87/255))

                    if note.discountPercentage > 0 {
                        Text("\(note.discountPercentage, format: .number.precision(.fractionLength(1)))% discount")
                            .font(.system(size: 11))
                            .foregroundColor(Color(red: 251/255, green: 191/255, blue: 36/255))
                    }
                }
            }

            // Purpose & Type
            HStack {
                Text(note.purpose)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)

                Spacer()

                Text(note.listingType.rawValue)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(Color(red: 96/255, green: 165/255, blue: 250/255))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color(red: 59/255, green: 130/255, blue: 246/255).opacity(0.2))
                    .cornerRadius(4)
            }

            // Details Grid
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                DetailItem(label: "Original Amount", value: "$\(Int(note.originalAmount), format: .number)")
                DetailItem(label: "Remaining Balance", value: "$\(Int(note.remainingBalance), format: .number)")
                DetailItem(label: "APR", value: "\(note.apr, format: .number.precision(.fractionLength(1)))%")
                DetailItem(label: "Term Remaining", value: "\(note.termRemainingMonths)/\(note.totalTermMonths) months")
                DetailItem(label: "Payment History", value: "\(note.paymentsOnTime)/\(note.totalPayments)", valueColor: Color(red: 0, green: 201/255, blue: 87/255))
                DetailItem(label: "Yield to Maturity", value: "\(note.yieldToMaturity, format: .number.precision(.fractionLength(1)))%")
            }

            // Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color(red: 0.2, green: 0.255, blue: 0.333).opacity(0.5))
                        .cornerRadius(4)

                    Rectangle()
                        .fill(LinearGradient(
                            colors: [
                                Color(red: 0, green: 201/255, blue: 87/255),
                                Color(red: 0, green: 168/255, blue: 68/255)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .frame(width: geometry.size.width * (note.progressPercentage / 100))
                        .cornerRadius(4)
                }
            }
            .frame(height: 8)

            // Actions
            HStack(spacing: 12) {
                Button {
                    // Purchase note
                } label: {
                    Text("Purchase Note")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color(red: 0, green: 201/255, blue: 87/255))
                        .cornerRadius(6)
                }

                Button {
                    // Send counteroffer
                } label: {
                    Text("Send Counteroffer")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color(red: 0, green: 201/255, blue: 87/255), lineWidth: 1)
                        )
                }
            }
        }
        .padding(20)
        .background(Color(red: 0.118, green: 0.161, blue: 0.227).opacity(0.5))
        .cornerRadius(12)
    }
}

struct DetailItem: View {
    let label: String
    let value: String
    var valueColor: Color = .white

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.gray)
            Text(value)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(valueColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    MarketView()
}
