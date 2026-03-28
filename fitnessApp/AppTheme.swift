import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

enum AppTheme {
    static let background = Color(hex: 0x0E0E0E)
    static let surface = Color(hex: 0x1A1A1A)
    static let surfaceLow = Color(hex: 0x131313)
    static let surfaceHigh = Color(hex: 0x20201F)
    static let surfaceHighest = Color(hex: 0x262626)
    static let surfaceGlass = Color.white.opacity(0.05)
    static let primary = Color(hex: 0xF3FFCA)
    static let primaryDim = Color(hex: 0xCAFD00)
    static let secondary = Color(hex: 0xA68CFF)
    static let secondaryDim = Color(hex: 0x7E51FF)
    static let tertiary = Color(hex: 0xFCF9F8)
    static let error = Color(hex: 0xFF7351)
    static let textPrimary = Color.white
    static let textSecondary = Color(hex: 0xADAAAA)
    static let border = Color.white.opacity(0.06)
    static let shadow = Color.black.opacity(0.35)

    static let pagePadding: CGFloat = 20
    static let sectionSpacing: CGFloat = 26
    static let cardRadius: CGFloat = 28
    static let pillRadius: CGFloat = 18

    static let primaryGradient = LinearGradient(
        colors: [primary, primaryDim],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let secondaryGradient = LinearGradient(
        colors: [secondary, secondaryDim],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let glowGradient = RadialGradient(
        colors: [secondaryDim.opacity(0.28), .clear],
        center: .center,
        startRadius: 10,
        endRadius: 260
    )

    static let warmGlowGradient = RadialGradient(
        colors: [primaryDim.opacity(0.16), .clear],
        center: .center,
        startRadius: 4,
        endRadius: 220
    )
}

enum AppTypography {
    static func headline(_ size: CGFloat, weight: Font.Weight = .bold, relativeTo style: Font.TextStyle = .title2) -> Font {
        preferredFont(
            families: ["Space Grotesk"],
            size: size,
            relativeTo: style,
            fallback: .system(size: size, weight: weight, design: .rounded)
        )
        .weight(weight)
    }

    static func body(_ size: CGFloat, weight: Font.Weight = .regular, relativeTo style: Font.TextStyle = .body) -> Font {
        preferredFont(
            families: ["Manrope"],
            size: size,
            relativeTo: style,
            fallback: .system(size: size, weight: weight, design: .default)
        )
        .weight(weight)
    }

    static func label(_ size: CGFloat, weight: Font.Weight = .semibold, relativeTo style: Font.TextStyle = .caption) -> Font {
        preferredFont(
            families: ["Manrope"],
            size: size,
            relativeTo: style,
            fallback: .system(size: size, weight: weight, design: .default)
        )
        .weight(weight)
    }

    private static func preferredFont(
        families: [String],
        size: CGFloat,
        relativeTo style: Font.TextStyle,
        fallback: Font
    ) -> Font {
#if canImport(UIKit)
        for family in families {
            if let matchedFamily = UIFont.familyNames.first(where: { $0.localizedCaseInsensitiveContains(family) }) {
                let fontNames = UIFont.fontNames(forFamilyName: matchedFamily)
                if let fontName = fontNames.first {
                    return .custom(fontName, size: size, relativeTo: style)
                }
            }
        }
#endif
        return fallback
    }
}

extension Color {
    init(hex: UInt, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: opacity
        )
    }
}

extension View {
    func appCardStyle(
        fill: AnyShapeStyle = AnyShapeStyle(AppTheme.surfaceLow),
        strokeOpacity: Double = 0.04
    ) -> some View {
        background(
            RoundedRectangle(cornerRadius: AppTheme.cardRadius, style: .continuous)
                .fill(fill)
        )
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.cardRadius, style: .continuous)
                .stroke(Color.white.opacity(strokeOpacity), lineWidth: 1)
        )
        .shadow(color: AppTheme.shadow.opacity(0.25), radius: 24, x: 0, y: 18)
    }
}
