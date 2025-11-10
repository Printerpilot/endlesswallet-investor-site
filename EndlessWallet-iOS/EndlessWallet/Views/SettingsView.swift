import SwiftUI

struct SettingsView: View {
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
                        // Header
                        Text("Settings")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 24)
                            .padding(.top, 20)

                        // Profile Card
                        VStack(spacing: 20) {
                            Text("Profile Information")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            VStack(alignment: .leading, spacing: 8) {
                                Text("Display Name")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.gray)

                                Text(user.name)
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(12)
                                    .background(Color(red: 0.2, green: 0.255, blue: 0.333).opacity(0.5))
                                    .cornerRadius(8)
                            }

                            VStack(alignment: .leading, spacing: 8) {
                                Text("Email")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.gray)

                                Text(user.email)
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(12)
                                    .background(Color(red: 0.2, green: 0.255, blue: 0.333).opacity(0.5))
                                    .cornerRadius(8)
                            }

                            Divider()
                                .background(Color.gray.opacity(0.3))

                            VStack(alignment: .leading, spacing: 12) {
                                Text("KYC Verification Status")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)

                                HStack(spacing: 8) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(Color(red: 0, green: 201/255, blue: 87/255))
                                    Text("Identity Verified")
                                        .font(.system(size: 14))
                                        .foregroundColor(.white)
                                }
                                .padding(12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(red: 0, green: 201/255, blue: 87/255).opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(red: 0, green: 201/255, blue: 87/255).opacity(0.3), lineWidth: 1)
                                )
                                .cornerRadius(8)
                            }
                        }
                        .padding(20)
                        .background(Color(red: 0.118, green: 0.161, blue: 0.227).opacity(0.3))
                        .cornerRadius(12)
                        .padding(.horizontal, 24)

                        // Banking Section
                        VStack(spacing: 20) {
                            Text("Connected Accounts")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Chase Checking ****1234")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.white)

                                    Text("Primary Account")
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                }

                                Spacer()

                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("$\(Int(user.checkingBalance), format: .number)")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(Color(red: 0, green: 201/255, blue: 87/255))

                                    Text("Available")
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(16)
                            .background(Color(red: 0.2, green: 0.255, blue: 0.333).opacity(0.3))
                            .cornerRadius(8)

                            Button {
                                // Add bank account
                            } label: {
                                Text("+ Add Bank Account")
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
                        .padding(20)
                        .background(Color(red: 0.118, green: 0.161, blue: 0.227).opacity(0.3))
                        .cornerRadius(12)
                        .padding(.horizontal, 24)

                        // Account Actions
                        VStack(spacing: 12) {
                            Button {
                                // Change password
                            } label: {
                                Text("Change Password")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                            }

                            Button {
                                authViewModel.signOut()
                            } label: {
                                Text("Sign Out")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(Color.red.opacity(0.8))
                                    .cornerRadius(6)
                            }
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

#Preview {
    SettingsView()
        .environmentObject(AuthViewModel())
}
