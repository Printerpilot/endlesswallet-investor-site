import SwiftUI
import StripePaymentSheet

@main
struct EndlessWalletApp: App {
    @StateObject private var authViewModel = AuthViewModel()

    init() {
        // Configure Stripe
        // IMPORTANT: Replace with your Stripe publishable key
        // StripeAPI.defaultPublishableKey = "pk_test_YOUR_KEY_HERE"
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}

class AuthViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var isAuthenticated: Bool = false
    @Published var onboardingStep: Int = 1
    @Published var showOnboarding: Bool = false

    func signIn(email: String, password: String) async throws {
        // TODO: Implement real authentication
        // For now, use mock data
        try await Task.sleep(nanoseconds: 1_000_000_000)
        await MainActor.run {
            self.currentUser = User.mock
            self.isAuthenticated = true
            self.showOnboarding = false
        }
    }

    func signUp(firstName: String, lastName: String, email: String, password: String) async throws {
        // TODO: Implement real sign up
        try await Task.sleep(nanoseconds: 1_000_000_000)
        await MainActor.run {
            var user = User.mock
            self.currentUser = user
            self.isAuthenticated = true
            self.showOnboarding = true
        }
    }

    func signOut() {
        self.currentUser = nil
        self.isAuthenticated = false
        self.showOnboarding = false
        self.onboardingStep = 1
    }

    func completeOnboardingStep() {
        if onboardingStep < 4 {
            onboardingStep += 1
        } else {
            showOnboarding = false
        }
    }
}
