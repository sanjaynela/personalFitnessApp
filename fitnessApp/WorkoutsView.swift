import SwiftUI

struct WorkoutsView: View {
    var body: some View {
        ScreenContainer(accessibilityID: "screen.workouts") { _ in
            header
            featuredCard
            categories
            sessions
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Workouts")
                .font(AppTypography.headline(34, weight: .bold, relativeTo: .largeTitle))
                .foregroundStyle(AppTheme.textPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.72)

            Text("Build strength, keep momentum, and recover on schedule.")
                .font(AppTypography.body(15, weight: .medium))
                .foregroundStyle(AppTheme.textSecondary)
        }
    }

    private var featuredCard: some View {
        DashboardCard(padding: 24) {
            Text("Featured Session")
                .font(AppTypography.label(11, weight: .bold))
                .foregroundStyle(AppTheme.textSecondary)
                .tracking(1.5)
                .textCase(.uppercase)

            ViewThatFits(in: .horizontal) {
                HStack(alignment: .top, spacing: 18) {
                    featuredCopy
                    Spacer()
                    featuredIcon
                }

                VStack(alignment: .leading, spacing: 18) {
                    featuredCopy
                    HStack {
                        Spacer()
                        featuredIcon
                        Spacer()
                    }
                }
            }
        }
    }

    private func workoutChip(value: String, label: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(value)
                .font(AppTypography.headline(18, weight: .bold))
                .foregroundStyle(AppTheme.primary)

            Text(label)
                .font(AppTypography.label(10, weight: .bold))
                .foregroundStyle(AppTheme.textSecondary)
                .tracking(1.1)
                .textCase(.uppercase)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(AppTheme.surface)
        )
    }

    private var featuredCopy: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Power Circuit")
                .font(AppTypography.headline(30, weight: .bold, relativeTo: .title))
                .foregroundStyle(AppTheme.textPrimary)
                .fixedSize(horizontal: false, vertical: true)

            Text("Explosive full-body round with push, pull, and sprint finishers.")
                .font(AppTypography.body(15, weight: .medium))
                .foregroundStyle(AppTheme.textSecondary)
                .fixedSize(horizontal: false, vertical: true)

            ViewThatFits(in: .horizontal) {
                HStack(spacing: 12) {
                    workoutChip(value: "52m", label: "Duration")
                    workoutChip(value: "486", label: "Kcal")
                    workoutChip(value: "High", label: "Load")
                }

                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 12) {
                        workoutChip(value: "52m", label: "Duration")
                        workoutChip(value: "486", label: "Kcal")
                    }
                    workoutChip(value: "High", label: "Load")
                }
            }
        }
    }

    private var featuredIcon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(AppTheme.secondaryGradient)
                .frame(width: 106, height: 126)
            Image(systemName: "bolt.heart.fill")
                .font(.system(size: 42, weight: .bold))
                .foregroundStyle(Color.black.opacity(0.78))
        }
    }

    private var categories: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionHeader(title: "Focus Areas", subtitle: "Train with balance all week", trailing: nil)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(MockData.workoutCategories) { category in
                        VStack(alignment: .leading, spacing: 12) {
                            Circle()
                                .fill(category.tint.opacity(0.16))
                                .frame(width: 42, height: 42)
                                .overlay {
                                    Circle()
                                        .fill(category.tint)
                                        .frame(width: 16, height: 16)
                                }

                            Text(category.title)
                                .font(AppTypography.headline(18, weight: .bold))
                                .foregroundStyle(AppTheme.textPrimary)

                            Text(category.detail)
                                .font(AppTypography.body(13, weight: .medium))
                                .foregroundStyle(AppTheme.textSecondary)
                        }
                        .padding(18)
                        .frame(width: 142, alignment: .leading)
                        .appCardStyle(fill: AnyShapeStyle(AppTheme.surfaceLow))
                    }
                }
            }
        }
    }

    private var sessions: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionHeader(title: "Recent Sessions", subtitle: "Your latest effort and recovery mix", trailing: nil)

            VStack(spacing: 14) {
                ForEach(MockData.workoutSessions) { workout in
                    WorkoutRowCard(workout: workout)
                }
            }
        }
    }
}
