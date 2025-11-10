import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    let steps = [
        OnboardingStep(
            title: "Welcome to Endless Wallet",
            description: "Complete these steps to start lending and borrowing.",
            icon: "hand.wave.fill"
        ),
        OnboardingStep(
            title: "Verify your identity",
            description: "We'll check a government ID (driver license or passport).",
            icon: "checkmark.shield.fill"
        ),
        OnboardingStep(
            title: "Connect your bank",
            description: "Securely link a checking account for deposits and repayments.",
            icon: "creditcard.fill"
        ),
        OnboardingStep(
            title: "Watch intro video",
            description: "90-second walkthrough of petitions, offers, and reputation.",
            icon: "play.circle.fill"
        )
    ]

    var currentStep: OnboardingStep {
        steps[authViewModel.onboardingStep - 1]
    }

    var body: some View {
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
                HStack {
                    Text("Onboarding")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)

                    Spacer()

                    Text("Step \(authViewModel.onboardingStep) of \(steps.count)")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)

                ScrollView {
                    VStack(spacing: 32) {
                        // Icon
                        Image(systemName: currentStep.icon)
                            .font(.system(size: 64))
                            .foregroundColor(Color(red: 0, green: 201/255, blue: 87/255))
                            .padding(.top, 40)

                        // Title and Description
                        VStack(spacing: 16) {
                            Text(currentStep.title)
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)

                            Text(currentStep.description)
                                .font(.system(size: 18))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 24)
                        }

                        // Progress Indicator
                        HStack(spacing: 8) {
                            ForEach(1...steps.count, id: \.self) { index in
                                Capsule()
                                    .fill(index <= authViewModel.onboardingStep ?
                                          Color(red: 0, green: 201/255, blue: 87/255) :
                                            Color.gray.opacity(0.3))
                                    .frame(height: 4)
                            }
                        }
                        .padding(.horizontal, 24)

                        Spacer(minLength: 40)

                        // Action Button
                        Button {
                            authViewModel.completeOnboardingStep()
                        } label: {
                            Text(buttonText)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color(red: 0, green: 201/255, blue: 87/255))
                                .cornerRadius(8)
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
    }

    var buttonText: String {
        switch authViewModel.onboardingStep {
        case 1: return "Get Started"
        case 2: return "Start Verification"
        case 3: return "Link Bank"
        case 4: return "Go to Dashboard"
        default: return "Continue"
        }
    }
}

struct OnboardingStep {
    let title: String
    let description: String
    let icon: String
}

#Preview {
    OnboardingView()
        .environmentObject(AuthViewModel())
}
