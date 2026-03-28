import SwiftUI

struct ContentView: View {
    @State private var selectedTab: AppTab = .home
    @State private var transitionToken = UUID()

    var body: some View {
        ZStack {
            AppBackground()

            Group {
                switch selectedTab {
                case .home:
                    HomeDashboardView()
                case .workouts:
                    WorkoutsView()
                case .insights:
                    InsightsView()
                case .profile:
                    ProfileView()
                }
            }
            .id(transitionToken)
            .transition(.opacity.combined(with: .scale(scale: 0.98)))
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            PersonalTabBar(selectedTab: $selectedTab)
                .padding(.horizontal, 18)
                .padding(.bottom, 10)
        }
        .onChange(of: selectedTab) {
            withAnimation(.spring(response: 0.45, dampingFraction: 0.88)) {
                transitionToken = UUID()
            }
        }
    }
}
