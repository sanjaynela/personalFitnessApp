import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScreenContainer(accessibilityID: "screen.profile") { _ in
            profileHero
            achievements
            settings
        }
    }

    private var profileHero: some View {
        DashboardCard(padding: 24) {
            HStack(alignment: .center, spacing: 18) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [AppTheme.secondaryDim, AppTheme.primaryDim],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 92, height: 92)

                    Text("SN")
                        .font(AppTypography.headline(28, weight: .bold))
                        .foregroundStyle(Color.black.opacity(0.78))
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text("Sanjay")
                        .font(AppTypography.headline(30, weight: .bold, relativeTo: .title))
                        .foregroundStyle(AppTheme.textPrimary)

                    Text("Strength-forward hybrid athlete")
                        .font(AppTypography.body(15, weight: .medium))
                        .foregroundStyle(AppTheme.textSecondary)

                    Text("11 day streak")
                        .font(AppTypography.label(12, weight: .bold))
                        .foregroundStyle(AppTheme.primary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            Capsule(style: .continuous)
                                .fill(AppTheme.primary.opacity(0.12))
                        )
                }
            }

            HStack(spacing: 14) {
                statColumn(title: "Move", value: "840")
                statColumn(title: "Sleep", value: "7.7h")
                statColumn(title: "PRs", value: "6")
            }
        }
    }

    private func statColumn(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(value)
                .font(AppTypography.headline(24, weight: .bold))
                .foregroundStyle(AppTheme.textPrimary)

            Text(title)
                .font(AppTypography.label(11, weight: .bold))
                .foregroundStyle(AppTheme.textSecondary)
                .tracking(1.2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(AppTheme.surface)
        )
    }

    private var achievements: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionHeader(title: "Highlights", subtitle: "Momentum across this month", trailing: nil)

            VStack(spacing: 14) {
                ForEach(MockData.achievements) { achievement in
                    HStack(spacing: 16) {
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(achievement.tint.opacity(0.14))
                            .frame(width: 56, height: 56)
                            .overlay {
                                Image(systemName: achievement.symbol)
                                    .font(.system(size: 22, weight: .semibold))
                                    .foregroundStyle(achievement.tint)
                            }

                        VStack(alignment: .leading, spacing: 4) {
                            Text(achievement.title)
                                .font(AppTypography.headline(19, weight: .bold))
                                .foregroundStyle(AppTheme.textPrimary)

                            Text(achievement.subtitle)
                                .font(AppTypography.body(14, weight: .medium))
                                .foregroundStyle(AppTheme.textSecondary)
                        }

                        Spacer()
                    }
                    .padding(18)
                    .appCardStyle(fill: AnyShapeStyle(AppTheme.surfaceLow))
                }
            }
        }
    }

    private var settings: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionHeader(title: "Preferences", subtitle: "Keep the app tuned to your habits", trailing: nil)

            VStack(spacing: 12) {
                ForEach(MockData.profileSettings) { setting in
                    HStack(spacing: 16) {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(AppTheme.surface)
                            .frame(width: 46, height: 46)
                            .overlay {
                                Image(systemName: setting.symbol)
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundStyle(AppTheme.primary)
                            }

                        VStack(alignment: .leading, spacing: 4) {
                            Text(setting.title)
                                .font(AppTypography.headline(18, weight: .bold))
                                .foregroundStyle(AppTheme.textPrimary)

                            Text(setting.subtitle)
                                .font(AppTypography.body(13, weight: .medium))
                                .foregroundStyle(AppTheme.textSecondary)
                        }

                        Spacer()

                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(AppTheme.textSecondary)
                    }
                    .padding(16)
                    .appCardStyle(fill: AnyShapeStyle(AppTheme.surfaceLow))
                }
            }
        }
    }
}
