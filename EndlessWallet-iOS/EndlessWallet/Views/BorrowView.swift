import SwiftUI

struct BorrowView: View {
    @State private var amount: String = "15000"
    @State private var selectedCurrency: Currency = .usd
    @State private var termMonths: String = "24"
    @State private var apr: String = "12"
    @State private var repaymentSchedule: RepaymentSchedule = .monthly
    @State private var isTradeableNote = true
    @State private var useConsumerCredit = true
    @State private var hasCosigner = false
    @State private var isSecured = true
    @State private var selectedCollateral: Set<CollateralType> = [.vehicle]
    @State private var governingLaw = "California, USA"
    @State private var additionalTerms = ""

    var monthlyPayment: Double {
        guard let amt = Double(amount),
              let aprValue = Double(apr),
              let term = Int(termMonths),
              term > 0, aprValue > 0 else {
            return 0
        }
        let rate = aprValue / 100 / 12
        let months = Double(term)
        let factor = pow(1 + rate, months)
        return amt * (rate * factor) / (factor - 1)
    }

    var totalInterest: Double {
        guard let term = Int(termMonths) else { return 0 }
        return (monthlyPayment * Double(term)) - (Double(amount) ?? 0)
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
                        // Header
                        Text("Create Loan Petition")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 24)
                            .padding(.top, 20)

                        // Loan Details Card
                        VStack(spacing: 20) {
                            Text("Loan Details")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            HStack(spacing: 12) {
                                FormField(label: "Amount", text: $amount)
                                    .keyboardType(.decimalPad)

                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Currency")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.gray)

                                    Picker("Currency", selection: $selectedCurrency) {
                                        ForEach(Currency.allCases, id: \.self) { currency in
                                            Text(currency.rawValue).tag(currency)
                                        }
                                    }
                                    .pickerStyle(.menu)
                                    .tint(.white)
                                    .padding(12)
                                    .background(Color(red: 0.2, green: 0.255, blue: 0.333).opacity(0.5))
                                    .cornerRadius(8)
                                }
                            }

                            HStack(spacing: 12) {
                                FormField(label: "Term (months)", text: $termMonths)
                                    .keyboardType(.numberPad)

                                FormField(label: "APR (%)", text: $apr)
                                    .keyboardType(.decimalPad)
                            }

                            VStack(alignment: .leading, spacing: 8) {
                                Text("Repayment")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.gray)

                                Picker("Repayment", selection: $repaymentSchedule) {
                                    ForEach(RepaymentSchedule.allCases, id: \.self) { schedule in
                                        Text(schedule.rawValue).tag(schedule)
                                    }
                                }
                                .pickerStyle(.segmented)
                            }

                            Divider()
                                .background(Color.gray.opacity(0.3))

                            // Options
                            ToggleOption(
                                label: "Tradeable Note",
                                description: "If Yes, this note may be listed/transferred subject to platform rules.",
                                isOn: $isTradeableNote
                            )

                            ToggleOption(
                                label: "Use Consumer Credit",
                                description: "If Yes, verified FICO scores will be shown to lenders.",
                                isOn: $useConsumerCredit
                            )

                            ToggleOption(
                                label: "Cosigner",
                                description: nil,
                                isOn: $hasCosigner
                            )

                            ToggleOption(
                                label: "Secured Loan",
                                description: "Requires agreement to repossession/collections API terms.",
                                isOn: $isSecured
                            )

                            if isSecured {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Collateral (select all that apply)")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.white)

                                    ForEach(CollateralType.allCases, id: \.self) { type in
                                        Toggle(isOn: Binding(
                                            get: { selectedCollateral.contains(type) },
                                            set: { isSelected in
                                                if isSelected {
                                                    selectedCollateral.insert(type)
                                                } else {
                                                    selectedCollateral.remove(type)
                                                }
                                            }
                                        )) {
                                            Text(type.rawValue)
                                                .font(.system(size: 14))
                                                .foregroundColor(.white)
                                        }
                                        .tint(Color(red: 0, green: 201/255, blue: 87/255))
                                    }
                                }
                            }

                            FormField(label: "Governing Law / Venue", text: $governingLaw)

                            VStack(alignment: .leading, spacing: 8) {
                                Text("Additional Terms")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.gray)

                                TextEditor(text: $additionalTerms)
                                    .frame(height: 100)
                                    .padding(8)
                                    .background(Color(red: 0.2, green: 0.255, blue: 0.333).opacity(0.5))
                                    .cornerRadius(8)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(20)
                        .background(Color(red: 0.118, green: 0.161, blue: 0.227).opacity(0.3))
                        .cornerRadius(12)
                        .padding(.horizontal, 24)

                        // Payment Preview Card
                        if monthlyPayment > 0 {
                            VStack(spacing: 16) {
                                Text("Repayment Schedule Preview")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                HStack(spacing: 20) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Estimated Payment")
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                        Text("\(selectedCurrency.symbol)\(monthlyPayment, format: .number.precision(.fractionLength(2)))")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(Color(red: 0, green: 201/255, blue: 87/255))
                                    }

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Total Interest (est)")
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                        Text("\(selectedCurrency.symbol)\(totalInterest, format: .number.precision(.fractionLength(2)))")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(Color(red: 96/255, green: 165/255, blue: 250/255))
                                    }
                                }
                            }
                            .padding(20)
                            .background(Color(red: 0.118, green: 0.161, blue: 0.227).opacity(0.3))
                            .cornerRadius(12)
                            .padding(.horizontal, 24)
                        }

                        // Create Button
                        Button {
                            // Create petition
                        } label: {
                            Text("Create Loan Petition")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color(red: 0, green: 201/255, blue: 87/255))
                                .cornerRadius(8)
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 32)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct FormField: View {
    let label: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.gray)

            TextField("", text: $text)
                .textFieldStyle(.plain)
                .padding(12)
                .background(Color(red: 0.2, green: 0.255, blue: 0.333).opacity(0.5))
                .cornerRadius(8)
                .foregroundColor(.white)
        }
    }
}

struct ToggleOption: View {
    let label: String
    let description: String?
    @Binding var isOn: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(label)
                    .font(.system(size: 14))
                    .foregroundColor(.white)

                Spacer()

                Toggle("", isOn: $isOn)
                    .labelsHidden()
                    .tint(Color(red: 0, green: 201/255, blue: 87/255))
            }

            if let description = description {
                Text(description)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    BorrowView()
}
