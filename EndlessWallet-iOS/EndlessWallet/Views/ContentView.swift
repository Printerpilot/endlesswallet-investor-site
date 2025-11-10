import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        Group {
            if authViewModel.isAuthenticated {
                if authViewModel.showOnboarding {
                    OnboardingView()
                } else {
                    MainTabView()
                }
            } else {
                LandingView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
