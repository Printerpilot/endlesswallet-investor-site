import SwiftUI

struct LendView: View {
    @State private var searchText = ""
    @State private var selectedFilter: PetitionFilter = .all
    @State private var petitions = LoanPetition.mockPetitions

    var filteredPetitions: [LoanPetition] {
        var filtered = petitions

        if !searchText.isEmpty {
            filtered = filtered.filter { petition in
                petition.borrower.name.localizedCaseInsensitiveContains(searchText) ||
                petition.purpose.localizedCaseInsensitiveContains(searchText)
            }
        }

        switch selectedFilter {
        case .all:
            break
        case .verified:
            filtered = filtered.filter { $0.isVerified }
        case .highCore:
            filtered = filtered.filter { $0.coreScore >= 700 }
        case .lowRate:
            filtered = filtered.filter { $0.apr <= 7.0 }
        }

        return filtered
    }

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
                    VStack(spacing: 16) {
                        Text("Browse Loan Petitions")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        // Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)

                            TextField("Search by borrower, purpose, or amount...", text: $searchText)
                                .textFieldStyle(.plain)
                                .foregroundColor(.white)
                        }
                        .padding(12)
                        .background(Color(red: 0.118, green: 0.161, blue: 0.227).opacity(0.5))
                        .cornerRadius(8)

                        // Filter Buttons
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(PetitionFilter.allCases, id: \.self) { filter in
                                    Button {
                                        withAnimation {
                                            selectedFilter = filter
                                        }
                                    } label: {
                                        Text(filter.rawValue)
                                            .font(.system(size: 14, weight: selectedFilter == filter ? .semibold : .medium))
                                            .foregroundColor(selectedFilter == filter ? .black : .white)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 8)
                                            .background(selectedFilter == filter ?
                                                       Color(red: 0, green: 201/255, blue: 87/255) :
                                                        Color(red: 0.2, green: 0.255, blue: 0.333).opacity(0.5))
                                            .cornerRadius(20)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 20)

                    // Petitions List
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(filteredPetitions) { petition in
                                PetitionCard(petition: petition)
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

enum PetitionFilter: String, CaseIterable {
    case all = "All"
    case verified = "Verified"
    case highCore = "High CORE"
    case lowRate = "Low Rate"
}

struct PetitionCard: View {
    let petition: LoanPetition

    var body: some View {
        VStack(spacing: 16) {
            // Header
            HStack(spacing: 12) {
                // Avatar
                Circle()
                    .fill(Color(red: 236/255, green: 72/255, blue: 153/255))
                    .frame(width: 48, height: 48)
                    .overlay(
                        Text(String(petition.borrower.name.prefix(1)))
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    )

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 6) {
                        Text(petition.borrower.name)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)

                        if petition.isVerified {
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 14))
                                .foregroundColor(Color(red: 0, green: 201/255, blue: 87/255))
                        }
                    }

                    Text(petition.createdAt.formatted(.relative(presentation: .named)))
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Text(petition.currency.symbol + "\(Int(petition.amount), format: .number)")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)

                    Text("\(petition.apr, format: .number.precision(.fractionLength(1)))% APR")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }

            // Purpose & Description
            VStack(alignment: .leading, spacing: 8) {
                Text(petition.purpose)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)

                Text(petition.description)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // Details
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Term")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Text("\(petition.termMonths) months")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("Score")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Text("\(petition.coreScore)")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Text("Funded")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Text("\(Int(petition.fundedPercentage))%")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(red: 0, green: 201/255, blue: 87/255))
                }
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
                        .frame(width: geometry.size.width * (petition.fundedPercentage / 100))
                        .cornerRadius(4)
                }
            }
            .frame(height: 8)

            // Actions
            HStack(spacing: 12) {
                Button {
                    // Fund loan
                } label: {
                    Text("Fund Loan")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color(red: 0, green: 201/255, blue: 87/255))
                        .cornerRadius(6)
                }

                Button {
                    // Make counteroffer
                } label: {
                    Text("Make Counteroffer")
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

#Preview {
    LendView()
}
