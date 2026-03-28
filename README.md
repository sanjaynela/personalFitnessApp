# personalFitnessApp

`personalFitnessApp` is a native SwiftUI iOS mock fitness dashboard built from a Stitch-inspired concept. The app focuses on strong visual hierarchy, bold dark styling, and a responsive layout that adapts across compact and larger iPhone screen sizes.

## Overview

The app ships as a 4-tab experience:

- `Home`
  - Daily dashboard with activity rings, stats, heart rate, sleep summary, and recent workouts
- `Workouts`
  - Featured session, focus areas, and recent training history
- `Insights`
  - Recovery, readiness, and weekly trend summaries
- `Profile`
  - Athlete summary, highlights, and preference rows

All content is powered by static mock data for a design-first v1. There is no backend, auth flow, persistence layer, or HealthKit integration in this version.

## Design Direction

The visual system is built around:

- High-contrast dark surfaces
- Lime and violet accent gradients
- Rounded glassy cards and layered shadows
- Bold display typography for headlines
- Custom bottom navigation instead of default `TabView`
- Responsive card layouts for narrow and wide phone widths

The implementation intentionally avoids hard-coding the screens to one device size. Wider hero sections collapse into stacked layouts when the available width gets tight, and the main screen container locks content to the viewport width so it does not drift or clip off-screen.

## Tech Stack

- SwiftUI
- Native Xcode project
- `Testing` for lightweight unit assertions
- `XCTest` for UI smoke coverage

## Project Structure

Key files:

- `fitnessApp/ContentView.swift`
  - Root app shell and tab switching
- `fitnessApp/AppTheme.swift`
  - Color palette, typography helpers, spacing, and card styling
- `fitnessApp/MockData.swift`
  - Tabs, models, mock data, and simple format helpers
- `fitnessApp/Components.swift`
  - Shared UI building blocks and the responsive screen container
- `fitnessApp/HomeDashboardView.swift`
- `fitnessApp/WorkoutsView.swift`
- `fitnessApp/InsightsView.swift`
- `fitnessApp/ProfileView.swift`

Tests:

- `fitnessAppTests/fitnessAppTests.swift`
- `fitnessAppUITests/fitnessAppUITests.swift`

## Running The App

Open the project in Xcode:

```bash
open fitnessApp.xcodeproj
```

Or build from the command line with the full Xcode toolchain:

```bash
'/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild' \
  -project fitnessApp.xcodeproj \
  -scheme fitnessApp \
  -destination 'generic/platform=iOS Simulator' \
  -derivedDataPath /tmp/personalFitnessAppDerivedData \
  ARCHS=arm64 ONLY_ACTIVE_ARCH=YES \
  build
```

## Test Commands

Build the test targets:

```bash
'/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild' \
  -project fitnessApp.xcodeproj \
  -scheme fitnessApp \
  -destination 'generic/platform=iOS Simulator' \
  -derivedDataPath /tmp/personalFitnessAppDerivedData \
  ARCHS=arm64 ONLY_ACTIVE_ARCH=YES \
  build-for-testing
```

Run tests from Xcode or a simulator-enabled terminal session:

```bash
'/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild' \
  -project fitnessApp.xcodeproj \
  -scheme fitnessApp \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  -derivedDataPath /tmp/personalFitnessAppDerivedData \
  ARCHS=arm64 ONLY_ACTIVE_ARCH=YES \
  test
```

## Responsive Layout Notes

The app includes a few deliberate layout safeguards:

- A width-aware `ScreenContainer` keeps scroll content aligned to the visible viewport.
- Large hero cards use adaptive horizontal-or-vertical layouts with `ViewThatFits`.
- Pills and large headings are constrained with `lineLimit` and `minimumScaleFactor`.
- Extra bottom spacing is reserved so the floating tab bar does not cover scroll content.

These changes were added specifically to prevent clipping on narrower devices and to keep the same screens usable across the iPhone size range.

## Bundle And Product Info

- Product name: `personalFitnessApp`
- Bundle identifier: `com.sanjaynela.personalFitnessApp`
- Remote repository: `https://github.com/sanjaynela/personalFitnessApp.git`

## Current Scope

Included:

- Polished static mock experience
- Themed multi-screen SwiftUI UI
- Responsive phone layout adjustments
- Basic unit and UI smoke coverage

Not included:

- Live fitness data
- HealthKit
- Authentication
- Sync or persistence
- Production analytics or backend APIs
