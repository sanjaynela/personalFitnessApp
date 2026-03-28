import SwiftUI

enum AppTab: String, CaseIterable, Identifiable {
    case home
    case workouts
    case insights
    case profile

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: "Home"
        case .workouts: "Workouts"
        case .insights: "Insights"
        case .profile: "Profile"
        }
    }

    var icon: String {
        switch self {
        case .home: "house"
        case .workouts: "dumbbell"
        case .insights: "chart.line.uptrend.xyaxis"
        case .profile: "person.crop.circle"
        }
    }

    var activeIcon: String {
        switch self {
        case .home: "house.fill"
        case .workouts: "dumbbell.fill"
        case .insights: "chart.line.uptrend.xyaxis"
        case .profile: "person.crop.circle.fill"
        }
    }
}

struct ActivityRing: Identifiable {
    let id = UUID()
    let title: String
    let progress: Double
    let width: CGFloat
    let gradient: AngularGradient
}

struct HeartRateBar: Identifiable {
    let id = UUID()
    let value: CGFloat
    let highlighted: Bool
}

struct FitnessStatCard: Identifiable {
    let id = UUID()
    let symbol: String
    let iconColor: Color
    let value: String
    let label: String
}

struct WorkoutSession: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let symbol: String
    let symbolColor: Color
    let calories: Int
    let durationMinutes: Int
}

struct WorkoutCategory: Identifiable {
    let id = UUID()
    let title: String
    let detail: String
    let tint: Color
}

struct InsightCard: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let detail: String
    let accent: Color
    let symbol: String
}

struct RecoveryPoint: Identifiable {
    let id = UUID()
    let day: String
    let score: Double
}

struct Achievement: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let symbol: String
    let tint: Color
}

struct ProfileSetting: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let symbol: String
}

enum MockData {
    static let activityRings: [ActivityRing] = [
        ActivityRing(
            title: "Move",
            progress: 0.84,
            width: 128,
            gradient: AngularGradient(colors: [AppTheme.primary, AppTheme.primaryDim], center: .center)
        ),
        ActivityRing(
            title: "Exercise",
            progress: 0.68,
            width: 96,
            gradient: AngularGradient(colors: [AppTheme.secondary, AppTheme.secondaryDim], center: .center)
        ),
        ActivityRing(
            title: "Stand",
            progress: 0.75,
            width: 64,
            gradient: AngularGradient(colors: [AppTheme.tertiary.opacity(0.96), AppTheme.tertiary.opacity(0.65)], center: .center)
        )
    ]

    static let summaryCards: [FitnessStatCard] = [
        FitnessStatCard(symbol: "figure.walk", iconColor: AppTheme.primary, value: "12,482", label: "Steps"),
        FitnessStatCard(symbol: "flame.fill", iconColor: AppTheme.secondary, value: "1,840", label: "Kcal Burned")
    ]

    static let heartRateBars: [HeartRateBar] = [
        .init(value: 0.40, highlighted: false),
        .init(value: 0.55, highlighted: false),
        .init(value: 0.35, highlighted: false),
        .init(value: 0.65, highlighted: false),
        .init(value: 0.84, highlighted: false),
        .init(value: 0.95, highlighted: true),
        .init(value: 0.60, highlighted: false),
        .init(value: 0.45, highlighted: false),
        .init(value: 0.50, highlighted: false),
        .init(value: 0.75, highlighted: false),
        .init(value: 0.42, highlighted: false),
        .init(value: 0.30, highlighted: false),
        .init(value: 0.55, highlighted: false),
        .init(value: 0.90, highlighted: false),
        .init(value: 0.65, highlighted: false)
    ]

    static let homeWorkouts: [WorkoutSession] = [
        WorkoutSession(
            title: "Morning Strength",
            subtitle: "45 mins • Upper Body Focus",
            symbol: "dumbbell.fill",
            symbolColor: AppTheme.primaryDim,
            calories: 340,
            durationMinutes: 45
        ),
        WorkoutSession(
            title: "Interval Sprint",
            subtitle: "30 mins • Cardio High Intensity",
            symbol: "figure.run",
            symbolColor: AppTheme.secondary,
            calories: 412,
            durationMinutes: 30
        )
    ]

    static let workoutCategories: [WorkoutCategory] = [
        WorkoutCategory(title: "Strength", detail: "14 sessions", tint: AppTheme.primary),
        WorkoutCategory(title: "Cardio", detail: "8 sessions", tint: AppTheme.secondary),
        WorkoutCategory(title: "Recovery", detail: "5 sessions", tint: AppTheme.tertiary),
        WorkoutCategory(title: "Mobility", detail: "4 sessions", tint: AppTheme.error)
    ]

    static let workoutSessions: [WorkoutSession] = [
        WorkoutSession(
            title: "Power Circuit",
            subtitle: "52 mins • Full Body Split",
            symbol: "bolt.heart.fill",
            symbolColor: AppTheme.primary,
            calories: 486,
            durationMinutes: 52
        ),
        WorkoutSession(
            title: "Tempo Run",
            subtitle: "38 mins • Outdoor Pace",
            symbol: "figure.run.circle.fill",
            symbolColor: AppTheme.secondary,
            calories: 402,
            durationMinutes: 38
        ),
        WorkoutSession(
            title: "Night Stretch",
            subtitle: "18 mins • Recovery Flow",
            symbol: "figure.cooldown",
            symbolColor: AppTheme.tertiary,
            calories: 96,
            durationMinutes: 18
        )
    ]

    static let insightCards: [InsightCard] = [
        InsightCard(title: "Readiness", value: "87%", detail: "Recovered from yesterday's intensity", accent: AppTheme.primary, symbol: "bolt.fill"),
        InsightCard(title: "Weekly Load", value: "5.8h", detail: "Up 12% from last week", accent: AppTheme.secondary, symbol: "chart.bar.fill"),
        InsightCard(title: "Sleep Debt", value: "18m", detail: "On track for full recovery", accent: AppTheme.tertiary, symbol: "moon.zzz.fill"),
        InsightCard(title: "Hydration", value: "2.8L", detail: "0.4L left to goal", accent: AppTheme.error, symbol: "drop.fill")
    ]

    static let recoveryTrend: [RecoveryPoint] = [
        .init(day: "Mon", score: 0.72),
        .init(day: "Tue", score: 0.68),
        .init(day: "Wed", score: 0.81),
        .init(day: "Thu", score: 0.75),
        .init(day: "Fri", score: 0.88),
        .init(day: "Sat", score: 0.83),
        .init(day: "Sun", score: 0.91)
    ]

    static let achievements: [Achievement] = [
        Achievement(title: "11 Day Streak", subtitle: "Closed all rings", symbol: "flame.fill", tint: AppTheme.error),
        Achievement(title: "Peak VO2", subtitle: "Top 9% this month", symbol: "waveform.path.ecg", tint: AppTheme.secondary),
        Achievement(title: "Strength PR", subtitle: "Deadlift +20 lbs", symbol: "trophy.fill", tint: AppTheme.primary)
    ]

    static let profileSettings: [ProfileSetting] = [
        ProfileSetting(title: "Goals", subtitle: "Move, recovery, and strength targets", symbol: "target"),
        ProfileSetting(title: "Notifications", subtitle: "Daily reminders and workout prompts", symbol: "bell.badge.fill"),
        ProfileSetting(title: "Privacy", subtitle: "Manage health data visibility", symbol: "lock.shield.fill")
    ]
}

enum MetricFormatter {
    static func durationLabel(minutes: Int) -> String {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60

        if hours == 0 {
            return "\(minutes)m"
        }

        if remainingMinutes == 0 {
            return "\(hours)h"
        }

        return "\(hours)h \(remainingMinutes)m"
    }

    static func percentText(_ value: Double) -> String {
        "\(Int((value * 100).rounded()))%"
    }
}
