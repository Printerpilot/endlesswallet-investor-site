import SwiftUI
import Charts

struct DashboardView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var user: User {
        authViewModel.currentUser ?? User.mock
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

                ScrollView {
                    VStack(spacing: 24) {
                        // Welcome Header
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Welcome back,")
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray)
                                Text(user.name)
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            Spacer()

                            // CORE Score Badge
                            HStack(spacing: 8) {
                                Circle()
                                    .fill(Color(red: 0, green: 201/255, blue: 87/255))
                                    .frame(width: 8, height: 8)

                                Text("CORE: \(user.coreScore)")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color(red: 0, green: 201/255, blue: 87/255))
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color(red: 0, green: 201/255, blue: 87/255).opacity(0.2))
                            .cornerRadius(20)
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 20)

                        // Net Worth Card
                        VStack(spacing: 20) {
                            Text("Net Worth Breakdown")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            // Net Worth Total
                            VStack(spacing: 8) {
                                Text("Net Worth")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)

                                Text("$\(Int(user.netWorth / 2), format: .number)")
                                    .font(.system(size: 36, weight: .bold))
                                    .foregroundColor(.white)
                            }

                            // Asset Breakdown
                            VStack(spacing: 16) {
                                AssetRow(
                                    name: "Cash",
                                    amount: user.checkingBalance,
                                    percentage: 40,
                                    color: Color(red: 0, green: 201/255, blue: 87/255)
                                )
                                AssetRow(
                                    name: "Loans Receivable",
                                    amount: user.loansReceivable,
                                    percentage: 10,
                                    color: Color(red: 1, green: 107/255, blue: 157/255)
                                )
                                AssetRow(
                                    name: "Stocks",
                                    amount: user.stocks,
                                    percentage: 15,
                                    color: Color(red: 251/255, green: 146/255, blue: 60/255)
                                )
                                AssetRow(
                                    name: "Real Assets",
                                    amount: user.realAssets,
                                    percentage: 20,
                                    color: Color(red: 167/255, green: 139/255, blue: 250/255)
                                )
                                AssetRow(
                                    name: "Bonds",
                                    amount: user.bonds,
                                    percentage: 8,
                                    color: Color(red: 251/255, green: 191/255, blue: 36/255)
                                )
                                AssetRow(
                                    name: "Crypto",
                                    amount: user.crypto,
                                    percentage: 6,
                                    color: Color(red: 6/255, green: 182/255, blue: 212/255)
                                )
                            }

                            // Debt
                            HStack {
                                Text("Your Debt (liabilities)")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(Color(red: 1, green: 107/255, blue: 107/255))

                                Spacer()

                                Text("-$\(Int(user.totalDebt), format: .number)")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Color(red: 1, green: 107/255, blue: 107/255))
                            }
                            .padding(16)
                            .background(Color(red: 239/255, green: 68/255, blue: 68/255).opacity(0.1))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(red: 239/255, green: 68/255, blue: 68/255).opacity(0.3), lineWidth: 1)
                            )
                        }
                        .padding(20)
                        .background(Color(red: 0.118, green: 0.161, blue: 0.227).opacity(0.3))
                        .cornerRadius(12)
                        .padding(.horizontal, 24)

                        // Leverage and Borrowing Capacity
                        HStack(spacing: 16) {
                            // Leverage Card
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Leverage")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.gray)

                                VStack(spacing: 12) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        HStack {
                                            Text("Debt to Assets")
                                                .font(.system(size: 12))
                                                .foregroundColor(.gray)
                                            Spacer()
                                            Text("\(Int(user.debtToAssets))%")
                                                .font(.system(size: 14, weight: .bold))
                                                .foregroundColor(Color(red: 0, green: 201/255, blue: 87/255))
                                        }
                                        ProgressView(value: user.debtToAssets / 100)
                                            .tint(Color(red: 0, green: 201/255, blue: 87/255))
                                    }

                                    VStack(alignment: .leading, spacing: 8) {
                                        HStack {
                                            Text("Debt to Income")
                                                .font(.system(size: 12))
                                                .foregroundColor(.gray)
                                            Spacer()
                                            Text("\(Int(user.debtToIncome))%")
                                                .font(.system(size: 14, weight: .bold))
                                                .foregroundColor(Color(red: 0, green: 201/255, blue: 87/255))
                                        }
                                        ProgressView(value: user.debtToIncome / 100)
                                            .tint(Color(red: 0, green: 201/255, blue: 87/255))
                                    }
                                }
                            }
                            .padding(16)
                            .background(Color(red: 0.118, green: 0.161, blue: 0.227).opacity(0.3))
                            .cornerRadius(12)

                            // Borrowing Capacity Card
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Borrowing Capacity")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.gray)

                                Text("$\(Int(user.borrowingCapacity), format: .number)")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(Color(red: 0, green: 201/255, blue: 87/255))

                                Text("Available at 6.5% APR")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)

                                Spacer()

                                Button {
                                    // Navigate to borrow
                                } label: {
                                    Text("Create Petition")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 10)
                                        .background(Color(red: 0, green: 201/255, blue: 87/255))
                                        .cornerRadius(6)
                                }
                            }
                            .padding(16)
                            .background(Color(red: 0.118, green: 0.161, blue: 0.227).opacity(0.3))
                            .cornerRadius(12)
                        }
                        .padding(.horizontal, 24)

                        Spacer(minLength: 32)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct AssetRow: View {
    let name: String
    let amount: Double
    let percentage: Int
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(name)
                    .font(.system(size: 14))
                    .foregroundColor(.white)

                Spacer()

                Text("$\(Int(amount), format: .number)")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)

                Text("\(percentage)%")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(color)
                    .cornerRadius(12)
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color(red: 0.2, green: 0.255, blue: 0.333).opacity(0.5))
                        .cornerRadius(4)

                    Rectangle()
                        .fill(color)
                        .frame(width: geometry.size.width * CGFloat(percentage) / 100)
                        .cornerRadius(4)
                }
            }
            .frame(height: 8)
        }
    }
}

#Preview {
    DashboardView()
        .environmentObject(AuthViewModel())
}
