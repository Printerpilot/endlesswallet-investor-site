import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var errorMessage: String?

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

                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Create Your Account")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)

                        Text("Sign up with email to get started")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    VStack(spacing: 16) {
                        HStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("First name")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.gray)

                                TextField("Troy", text: $firstName)
                                    .textFieldStyle(.plain)
                                    .padding(16)
                                    .background(Color(red: 0.2, green: 0.255, blue: 0.333).opacity(0.5))
                                    .cornerRadius(8)
                                    .foregroundColor(.white)
                            }

                            VStack(alignment: .leading, spacing: 8) {
                                Text("Last name")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.gray)

                                TextField("Lunn", text: $lastName)
                                    .textFieldStyle(.plain)
                                    .padding(16)
                                    .background(Color(red: 0.2, green: 0.255, blue: 0.333).opacity(0.5))
                                    .cornerRadius(8)
                                    .foregroundColor(.white)
                            }
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)

                            TextField("your@email.com", text: $email)
                                .textFieldStyle(.plain)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                                .padding(16)
                                .background(Color(red: 0.2, green: 0.255, blue: 0.333).opacity(0.5))
                                .cornerRadius(8)
                                .foregroundColor(.white)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)

                            SecureField("••••••••", text: $password)
                                .textFieldStyle(.plain)
                                .padding(16)
                                .background(Color(red: 0.2, green: 0.255, blue: 0.333).opacity(0.5))
                                .cornerRadius(8)
                                .foregroundColor(.white)
                        }

                        if let errorMessage = errorMessage {
                            Text(errorMessage)
                                .font(.system(size: 14))
                                .foregroundColor(.red)
                        }

                        Button {
                            Task {
                                await signUp()
                            }
                        } label: {
                            if isLoading {
                                ProgressView()
                                    .tint(.black)
                            } else {
                                Text("Create Account")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                        }
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color(red: 0, green: 201/255, blue: 87/255))
                        .cornerRadius(8)
                        .disabled(isLoading)
                    }
                }
                .padding(24)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }

    func signUp() async {
        guard !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields"
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            try await authViewModel.signUp(
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password
            )
            dismiss()
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}

#Preview {
    SignUpView()
        .environmentObject(AuthViewModel())
}
