import SwiftUI

struct AppBackground: View {
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                AppTheme.background
                    .ignoresSafeArea()

                AppTheme.glowGradient
                    .frame(width: 480, height: 480)
                    .offset(x: proxy.size.width * 0.25, y: -proxy.size.height * 0.22)
                    .blur(radius: 12)

                AppTheme.warmGlowGradient
                    .frame(width: 420, height: 420)
                    .offset(x: -proxy.size.width * 0.28, y: proxy.size.height * 0.28)
                    .blur(radius: 18)
            }
        }
        .ignoresSafeArea()
    }
}

struct ScreenContainer<Content: View>: View {
    let accessibilityID: String
    let content: (CGFloat) -> Content

    init(accessibilityID: String, @ViewBuilder content: @escaping (CGFloat) -> Content) {
        self.accessibilityID = accessibilityID
        self.content = content
    }

    var body: some View {
        GeometryReader { proxy in
            let contentWidth = max(0, proxy.size.width - (AppTheme.pagePadding * 2))

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppTheme.sectionSpacing) {
                    content(contentWidth)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, AppTheme.pagePadding)
                .padding(.top, 14)
                .padding(.bottom, 150)
            }
            .frame(width: proxy.size.width)
            .scrollBounceBehavior(.basedOnSize)
        }
        .accessibilityIdentifier(accessibilityID)
    }
}

struct DashboardCard<Content: View>: View {
    var padding: CGFloat = 20
    var fill: AnyShapeStyle = AnyShapeStyle(AppTheme.surfaceLow)
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            content
        }
        .padding(padding)
        .frame(maxWidth: .infinity, alignment: .leading)
        .appCardStyle(fill: fill)
    }
}

struct SectionHeader: View {
    let title: String
    let subtitle: String?
    var trailing: String?

    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(AppTypography.headline(24, weight: .bold, relativeTo: .title2))
                    .foregroundStyle(AppTheme.textPrimary)

                if let subtitle {
                    Text(subtitle)
                        .font(AppTypography.body(14, weight: .medium, relativeTo: .subheadline))
                        .foregroundStyle(AppTheme.textSecondary)
                }
            }

            Spacer()

            if let trailing {
                Text(trailing)
                    .font(AppTypography.label(12, weight: .bold, relativeTo: .caption))
                    .foregroundStyle(AppTheme.primary)
                    .textCase(.uppercase)
                    .tracking(1.4)
            }
        }
    }
}

struct AvatarBadge: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [AppTheme.secondaryDim, AppTheme.primaryDim],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            Circle()
                .stroke(AppTheme.primary.opacity(0.35), lineWidth: 1)

            Text("SN")
                .font(AppTypography.label(16, weight: .bold, relativeTo: .headline))
                .foregroundStyle(Color.black.opacity(0.82))
        }
        .frame(width: 42, height: 42)
        .shadow(color: AppTheme.secondaryDim.opacity(0.35), radius: 12, x: 0, y: 10)
    }
}

struct ActivityRingsView: View {
    let rings: [ActivityRing]
    var diameter: CGFloat = 154
    @State private var animateRings = false

    var body: some View {
        let scale = diameter / 154

        ZStack {
            ForEach(Array(rings.enumerated()), id: \.element.id) { index, ring in
                Circle()
                    .stroke(AppTheme.surfaceHighest, lineWidth: 12)
                    .frame(width: ring.width * scale, height: ring.width * scale)

                Circle()
                    .trim(from: 0, to: animateRings ? ring.progress : 0.04)
                    .stroke(
                        ring.gradient,
                        style: StrokeStyle(lineWidth: 12, lineCap: .round)
                    )
                    .frame(width: ring.width * scale, height: ring.width * scale)
                    .rotationEffect(.degrees(-90))
                    .shadow(
                        color: index == 0 ? AppTheme.primary.opacity(0.22) : AppTheme.secondary.opacity(0.22),
                        radius: 14,
                        x: 0,
                        y: 10
                    )
                    .animation(
                        .spring(response: 0.9, dampingFraction: 0.82).delay(Double(index) * 0.08),
                        value: animateRings
                    )
            }

            Circle()
                .fill(
                    LinearGradient(
                        colors: [AppTheme.surfaceHigh, AppTheme.background],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 54 * scale, height: 54 * scale)

            Image(systemName: "bolt.fill")
                .font(.system(size: 24 * scale, weight: .bold))
                .foregroundStyle(AppTheme.primary)
        }
        .frame(width: diameter, height: diameter)
        .onAppear {
            animateRings = true
        }
    }
}

struct MetricMiniCard: View {
    let card: FitnessStatCard

    var body: some View {
        DashboardCard(padding: 18, fill: AnyShapeStyle(AppTheme.surface)) {
            Image(systemName: card.symbol)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(card.iconColor)

            Spacer(minLength: 0)

            VStack(alignment: .leading, spacing: 4) {
                Text(card.value)
                    .font(AppTypography.headline(28, weight: .bold, relativeTo: .title))
                    .foregroundStyle(AppTheme.textPrimary)

                Text(card.label)
                    .font(AppTypography.label(11, weight: .bold, relativeTo: .caption))
                    .foregroundStyle(AppTheme.textSecondary)
                    .tracking(1.3)
                    .textCase(.uppercase)
            }
        }
        .frame(height: 168)
    }
}

struct HeartRateChartCard: View {
    let bars: [HeartRateBar]

    var body: some View {
        DashboardCard(padding: 20) {
            HStack(alignment: .bottom, spacing: 14) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Heart Rate")
                        .font(AppTypography.headline(22, weight: .bold))
                        .foregroundStyle(AppTheme.textPrimary)

                    Text("Last 24 hours")
                        .font(AppTypography.body(14, weight: .medium))
                        .foregroundStyle(AppTheme.textSecondary)
                }

                Spacer()

                HStack(alignment: .firstTextBaseline, spacing: 3) {
                    Text("72")
                        .font(AppTypography.headline(36, weight: .bold, relativeTo: .largeTitle))
                        .foregroundStyle(AppTheme.error)

                    Text("BPM")
                        .font(AppTypography.label(12, weight: .bold))
                        .foregroundStyle(AppTheme.textSecondary)
                }
            }

            HStack(alignment: .bottom, spacing: 4) {
                ForEach(bars) { bar in
                    Capsule(style: .continuous)
                        .fill(bar.highlighted ? AnyShapeStyle(AppTheme.error) : AnyShapeStyle(AppTheme.surfaceHighest))
                        .overlay {
                            if bar.highlighted {
                                Capsule(style: .continuous)
                                    .fill(AppTheme.error.opacity(0.35))
                                    .blur(radius: 14)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: max(28, 120 * bar.value))
                }
            }
            .frame(height: 138, alignment: .bottom)
        }
    }
}

struct SleepAnalysisCard: View {
    var body: some View {
        DashboardCard(padding: 24, fill: AnyShapeStyle(.ultraThinMaterial)) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 14) {
                    HStack(spacing: 8) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(AppTheme.secondary)

                        Text("Sleep Analysis")
                            .font(AppTypography.label(11, weight: .bold))
                            .foregroundStyle(AppTheme.textSecondary)
                            .tracking(1.5)
                            .textCase(.uppercase)
                    }

                    Text("7h 42m")
                        .font(AppTypography.headline(42, weight: .bold, relativeTo: .largeTitle))
                        .foregroundStyle(AppTheme.textPrimary)

                    HStack(spacing: 10) {
                        Text("Deep: 2h 15m")
                            .font(AppTypography.label(12, weight: .bold))
                            .foregroundStyle(AppTheme.secondary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                Capsule(style: .continuous)
                                    .fill(AppTheme.secondaryDim.opacity(0.18))
                            )

                        Text("Score 88")
                            .font(AppTypography.body(13, weight: .semibold))
                            .foregroundStyle(AppTheme.textSecondary)
                    }
                }

                Spacer()

                ZStack {
                    Circle()
                        .stroke(AppTheme.secondary.opacity(0.24), lineWidth: 1.5)
                        .frame(width: 62, height: 62)

                    Image(systemName: "moon.stars.fill")
                        .font(.system(size: 26, weight: .medium))
                        .foregroundStyle(AppTheme.secondary)
                }
            }
        }
        .overlay(alignment: .topLeading) {
            Circle()
                .fill(AppTheme.secondary.opacity(0.12))
                .frame(width: 140, height: 140)
                .blur(radius: 22)
                .offset(x: -18, y: -24)
        }
    }
}

struct WorkoutRowCard: View {
    let workout: WorkoutSession

    var body: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(AppTheme.surfaceHighest)
                .frame(width: 54, height: 54)
                .overlay {
                    Image(systemName: workout.symbol)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(workout.symbolColor)
                }

            VStack(alignment: .leading, spacing: 4) {
                Text(workout.title)
                    .font(AppTypography.headline(18, weight: .bold, relativeTo: .headline))
                    .foregroundStyle(AppTheme.textPrimary)

                Text(workout.subtitle)
                    .font(AppTypography.body(14, weight: .medium))
                    .foregroundStyle(AppTheme.textSecondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("\(workout.calories)")
                    .font(AppTypography.headline(18, weight: .bold))
                    .foregroundStyle(AppTheme.primary)

                Text("Kcal")
                    .font(AppTypography.label(10, weight: .bold))
                    .foregroundStyle(AppTheme.textSecondary)
                    .tracking(1.2)
                    .textCase(.uppercase)
            }
        }
        .padding(18)
        .appCardStyle(fill: AnyShapeStyle(AppTheme.surfaceLow))
    }
}

struct PersonalTabBar: View {
    @Binding var selectedTab: AppTab

    var body: some View {
        HStack(spacing: 12) {
            ForEach(AppTab.allCases) { tab in
                Button {
                    withAnimation(.spring(response: 0.42, dampingFraction: 0.82)) {
                        selectedTab = tab
                    }
                } label: {
                    ZStack {
                        if selectedTab == tab {
                            Circle()
                                .fill(AppTheme.primaryDim)
                                .frame(width: 54, height: 54)
                                .shadow(color: AppTheme.primaryDim.opacity(0.3), radius: 18, x: 0, y: 10)
                        }

                        Image(systemName: selectedTab == tab ? tab.activeIcon : tab.icon)
                            .font(.system(size: 21, weight: selectedTab == tab ? .bold : .semibold))
                            .foregroundStyle(selectedTab == tab ? Color.black : AppTheme.textSecondary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 54)
                    }
                }
                .buttonStyle(.plain)
                .accessibilityIdentifier("tab.\(tab.rawValue)")
            }
        }
        .padding(.horizontal, 18)
        .padding(.top, 14)
        .padding(.bottom, 18)
        .background(
            RoundedRectangle(cornerRadius: 34, style: .continuous)
                .fill(AppTheme.surface.opacity(0.92))
                .overlay(
                    RoundedRectangle(cornerRadius: 34, style: .continuous)
                        .stroke(AppTheme.border, lineWidth: 1)
                )
                .shadow(color: AppTheme.shadow.opacity(0.55), radius: 24, x: 0, y: 16)
        )
    }
}

struct RecoveryChart: View {
    let points: [RecoveryPoint]

    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            ForEach(points) { point in
                VStack(spacing: 10) {
                    Capsule(style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [AppTheme.secondary, AppTheme.secondaryDim],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: 18, height: max(28, point.score * 128))

                    Text(point.day)
                        .font(AppTypography.label(11, weight: .bold))
                        .foregroundStyle(AppTheme.textSecondary)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}
