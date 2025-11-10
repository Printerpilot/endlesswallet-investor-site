import SwiftUI

struct LandingView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showSignIn = false
    @State private var showSignUp = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
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
                    VStack(alignment: .leading, spacing: 32) {
                        // Hero Section
                        VStack(alignment: .leading, spacing: 24) {
                            Text("Borrow and lend with\ncomprehensive contracts")
                                .font(.system(size: 42, weight: .bold))
                                .foregroundColor(.white)

                            Text("Peer-to-peer lending with flexibility and transparency.\nConnect your social accounts, verify your identity, and get access to lending opportunities in minutes.")
                                .font(.system(size: 18))
                                .foregroundColor(.gray)
                                .lineSpacing(4)

                            HStack(spacing: 12) {
                                Button {
                                    showSignUp = true
                                } label: {
                                    Text("Get Started")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 16)
                                        .background(Color(red: 0, green: 201/255, blue: 87/255))
                                        .cornerRadius(8)
                                }

                                Button {
                                    showSignIn = true
                                } label: {
                                    Text("Sign In")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 16)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color(red: 0, green: 201/255, blue: 87/255), lineWidth: 1)
                                        )
                                }
                            }
                        }
                        .padding(.top, 32)

                        // Feature Cards
                        VStack(spacing: 16) {
                            FeatureCard(
                                icon: "shield.checkered",
                                title: "Secure & Verified",
                                description: "KYC verified users with comprehensive contracts"
                            )

                            FeatureCard(
                                icon: "globe",
                                title: "Social Trust",
                                description: "Build reputation through successful loans"
                            )

                            FeatureCard(
                                icon: "chart.bar",
                                title: "Transparent",
                                description: "Clear terms and flexible negotiations"
                            )

                            FeatureCard(
                                icon: "chart.line.uptrend.xyaxis",
                                title: "CORE Score",
                                description: "Credit & Obligation Rating Evaluation - holistic creditworthiness beyond FICO"
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
                }
            }
            .sheet(isPresented: $showSignIn) {
                SignInView()
            }
            .sheet(isPresented: $showSignUp) {
                SignUpView()
            }
        }
    }
}

struct FeatureCard: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 28))
                .foregroundColor(Color(red: 0, green: 201/255, blue: 87/255))
                .frame(width: 50)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)

                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(red: 0.118, green: 0.161, blue: 0.227).opacity(0.4))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(red: 0.2, green: 0.255, blue: 0.333).opacity(0.5), lineWidth: 1)
        )
    }
}

#Preview {
    LandingView()
        .environmentObject(AuthViewModel())
}
