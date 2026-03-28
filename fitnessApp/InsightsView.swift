import SwiftUI

struct InsightsView: View {
    var body: some View {
        ScreenContainer(accessibilityID: "screen.insights") { _ in
            header
            insightGrid
            recoverySection
            readinessCard
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Insights")
                .font(AppTypography.headline(34, weight: .bold, relativeTo: .largeTitle))
                .foregroundStyle(AppTheme.textPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.72)

            Text("Zoom out on training load, recovery, and consistency trends.")
                .font(AppTypography.body(15, weight: .medium))
                .foregroundStyle(AppTheme.textSecondary)
        }
    }

    private var insightGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
            ForEach(MockData.insightCards) { card in
                DashboardCard(padding: 18, fill: AnyShapeStyle(AppTheme.surfaceLow)) {
                    HStack {
                        Image(systemName: card.symbol)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(card.accent)

                        Spacer()
                    }

                    Text(card.value)
                        .font(AppTypography.headline(28, weight: .bold))
                        .foregroundStyle(AppTheme.textPrimary)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(card.title)
                            .font(AppTypography.headline(18, weight: .bold))
                            .foregroundStyle(AppTheme.textPrimary)

                        Text(card.detail)
                            .font(AppTypography.body(13, weight: .medium))
                            .foregroundStyle(AppTheme.textSecondary)
                    }
                }
                .frame(height: 176)
            }
        }
    }

    private var recoverySection: some View {
        DashboardCard(padding: 22) {
            SectionHeader(title: "Recovery Trend", subtitle: "Last 7 days", trailing: "91% Sun")
            RecoveryChart(points: MockData.recoveryTrend)
        }
    }

    private var readinessCard: some View {
        DashboardCard(padding: 22, fill: AnyShapeStyle(AppTheme.surfaceHigh)) {
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Training Readiness")
                        .font(AppTypography.headline(24, weight: .bold))
                        .foregroundStyle(AppTheme.textPrimary)

                    Text("High readiness today. Prioritize compound lifts or threshold intervals.")
                        .font(AppTypography.body(14, weight: .medium))
                        .foregroundStyle(AppTheme.textSecondary)

                    HStack(spacing: 10) {
                        readinessPill("Sleep +14%", tint: AppTheme.primary)
                        readinessPill("HRV Stable", tint: AppTheme.secondary)
                    }
                }

                Spacer()

                ZStack {
                    Circle()
                        .stroke(AppTheme.surfaceHighest, lineWidth: 10)
                        .frame(width: 88, height: 88)

                    Circle()
                        .trim(from: 0, to: 0.87)
                        .stroke(AppTheme.primaryGradient, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .frame(width: 88, height: 88)
                        .rotationEffect(.degrees(-90))

                    Text("87")
                        .font(AppTypography.headline(26, weight: .bold))
                        .foregroundStyle(AppTheme.primary)
                }
            }
        }
    }

    private func readinessPill(_ title: String, tint: Color) -> some View {
        Text(title)
            .font(AppTypography.label(11, weight: .bold))
            .foregroundStyle(tint)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                Capsule(style: .continuous)
                    .fill(tint.opacity(0.12))
            )
    }
}
