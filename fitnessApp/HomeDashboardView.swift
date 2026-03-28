import SwiftUI

struct HomeDashboardView: View {
    var body: some View {
        ScreenContainer(accessibilityID: "screen.home") { contentWidth in
            topBar
            activitySummary(contentWidth: contentWidth)
            HeartRateChartCard(bars: MockData.heartRateBars)
            SleepAnalysisCard()
            recentWorkouts
        }
    }

    private var topBar: some View {
        HStack {
            HStack(spacing: 12) {
                AvatarBadge()

                Text("Today")
                    .font(AppTypography.headline(32, weight: .bold, relativeTo: .largeTitle))
                    .foregroundStyle(AppTheme.primaryDim)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }

            Spacer()

            Button(action: {}) {
                Image(systemName: "calendar")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(AppTheme.primaryDim)
                    .frame(width: 46, height: 46)
                    .background(
                        Circle()
                            .fill(AppTheme.surface.opacity(0.72))
                    )
            }
            .buttonStyle(.plain)
        }
    }

    private func activitySummary(contentWidth: CGFloat) -> some View {
        let ringSize = min(154, max(118, contentWidth * 0.38))

        return VStack(spacing: 14) {
            DashboardCard(padding: 24) {
                ViewThatFits(in: .horizontal) {
                    HStack(alignment: .center, spacing: 18) {
                        summaryCopy
                        Spacer(minLength: 0)
                        ActivityRingsView(rings: MockData.activityRings, diameter: ringSize)
                    }

                    VStack(alignment: .leading, spacing: 24) {
                        summaryCopy

                        HStack {
                            Spacer()
                            ActivityRingsView(rings: MockData.activityRings, diameter: ringSize)
                            Spacer()
                        }
                    }
                }
            }

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                ForEach(MockData.summaryCards) { card in
                    MetricMiniCard(card: card)
                }
            }
        }
    }

    private var summaryCopy: some View {
        VStack(alignment: .leading, spacing: 18) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Activity Rings")
                    .font(AppTypography.label(12, weight: .bold))
                    .foregroundStyle(AppTheme.textSecondary)
                    .tracking(2)
                    .textCase(.uppercase)

                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("84")
                        .font(AppTypography.headline(50, weight: .bold, relativeTo: .largeTitle))
                        .foregroundStyle(AppTheme.primary)
                        .minimumScaleFactor(0.75)

                    Text("%")
                        .font(AppTypography.body(18, weight: .medium))
                        .foregroundStyle(AppTheme.textSecondary)
                }

                Text("Daily Goal")
                    .font(AppTypography.body(15, weight: .medium))
                    .foregroundStyle(AppTheme.textSecondary)
            }

            ViewThatFits(in: .horizontal) {
                HStack(spacing: 12) {
                    metricPill(title: "Move", color: AppTheme.primary)
                    metricPill(title: "Exercise", color: AppTheme.secondary)
                    metricPill(title: "Stand", color: AppTheme.tertiary)
                }

                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 12) {
                        metricPill(title: "Move", color: AppTheme.primary)
                        metricPill(title: "Exercise", color: AppTheme.secondary)
                    }
                    metricPill(title: "Stand", color: AppTheme.tertiary)
                }
            }
        }
    }

    private func metricPill(title: String, color: Color) -> some View {
        Text(title)
            .font(AppTypography.label(11, weight: .bold))
            .foregroundStyle(color)
            .lineLimit(1)
            .minimumScaleFactor(0.8)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                Capsule(style: .continuous)
                    .fill(color.opacity(0.1))
            )
    }

    private var recentWorkouts: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionHeader(title: "Recent Workouts", subtitle: nil, trailing: "View All")

            VStack(spacing: 14) {
                ForEach(MockData.homeWorkouts) { workout in
                    WorkoutRowCard(workout: workout)
                }
            }
        }
    }
}
