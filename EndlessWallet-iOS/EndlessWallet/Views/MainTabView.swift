import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "chart.bar.fill")
                }
                .tag(0)

            BorrowView()
                .tabItem {
                    Label("Borrow", systemImage: "dollarsign.circle.fill")
                }
                .tag(1)

            LendView()
                .tabItem {
                    Label("Lend", systemImage: "magnifyingglass")
                }
                .tag(2)

            MarketView()
                .tabItem {
                    Label("Market", systemImage: "chart.line.uptrend.xyaxis")
                }
                .tag(3)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(4)
        }
        .tint(Color(red: 0, green: 201/255, blue: 87/255))
    }
}

#Preview {
    MainTabView()
        .environmentObject(AuthViewModel())
}
