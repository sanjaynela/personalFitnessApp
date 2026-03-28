import Testing
@testable import personalFitnessApp

struct fitnessAppTests {

    @Test func tabsAreStable() async throws {
        #expect(AppTab.allCases.count == 4)
        #expect(AppTab.allCases.map(\.title) == ["Home", "Workouts", "Insights", "Profile"])
    }

    @Test func metricFormattingMatchesDashboardLanguage() async throws {
        #expect(MetricFormatter.durationLabel(minutes: 52) == "52m")
        #expect(MetricFormatter.durationLabel(minutes: 135) == "2h 15m")
        #expect(MetricFormatter.percentText(0.84) == "84%")
    }

    @Test func mockDataSupportsFullFeatureShell() async throws {
        #expect(MockData.homeWorkouts.count == 2)
        #expect(MockData.workoutSessions.count >= 3)
        #expect(MockData.insightCards.count == 4)
    }
}
