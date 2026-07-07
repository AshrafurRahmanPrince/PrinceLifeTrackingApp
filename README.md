# Prince's Lifestyle Matrix - Flutter Habit Tracker

A premium, comprehensive habit tracking dashboard built with Flutter. This app is designed as a deeply personalized workspace for **Ashrafur Rahman Prince**, featuring real-time habit tracking, performance analytics, and wellness monitoring.

## 🎯 Features

### Core Features
- **Personalized Dashboard**: Custom-branded workspace with user profile integration
- **Master Habit Grid**: Track 10 core habits across a 31-day month with instant real-time updates
- **Real-time Analytics**: Automatic calculation of completion rates, progress metrics, and trend analysis
- **Daily Performance Chart**: Horizontal bar chart visualization showing daily habit completion rates
- **Comprehensive Analysis Table**: Detailed breakdown of each habit with progress indicators

### Wellness Integration
- **Mood Tracker**: Daily mood logging with 5-level emoji selector (😢 😐 🙂 😀 🤩)
- **Sleep Logger**: Quick increment/decrement controls for logging sleep hours
- **Overall Statistics**: Circular progress indicator showing overall completion percentage
- **Numeric Breakdown**: Clear display of Goal, Completed, and Remaining habit checks

### Design & UX
- **Dark Mode Premium UI**: Sleek, professional dashboard aesthetic
- **Responsive Layout**: Optimized for tablets, desktops, and wider screens
- **Smooth Animations**: Real-time updates with instant visual feedback
- **Clean Typography**: Bold, modern fonts with professional hierarchy
- **Interactive Elements**: Intuitive checkbox interactions and controls

## 📦 Project Structure

```
PrinceLifeTrackiungApp/
├── lib/
│   └── main.dart                 # Complete single-file app implementation
├── assets/
│   └── prince_profile.png        # User profile image (placeholder)
├── pubspec.yaml                  # Flutter project configuration
├── analysis_options.yaml         # Dart linting configuration
├── .gitignore                    # Git ignore file
└── README.md                     # This file
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.0.0 or higher
- Dart 3.0.0 or higher
- A compatible IDE (VS Code, Android Studio, or similar)

### Installation

1. **Clone or navigate to the project directory**:
   ```bash
   cd PrinceLifeTrackiungApp
   ```

2. **Get Flutter dependencies**:
   ```bash
   flutter pub get
   ```

3. **Add a profile image asset** (optional but recommended):
   - Create a profile image file named `prince_profile.png`
   - Place it in the `assets/` folder
   - The app will use a fallback initial "P" if the image is unavailable

4. **Run the app**:
   ```bash
   flutter run
   ```

### Alternative: Run on specific devices
- **Mobile Emulator**: `flutter run`
- **Android Device**: `flutter run -d <device_id>`
- **Web**: `flutter run -d chrome`
- **Desktop (Windows)**: `flutter run -d windows`

## 🏗️ Architecture & State Management

### State Management
The app uses **Provider** for efficient state management with the `HabitTrackerProvider` class, which handles:
- Habit completion state management
- Real-time recalculation of all statistics
- Mood and sleep logging
- Automatic UI updates when data changes

### Key Classes

#### `UserConfig`
```dart
// Global user configuration
static const String fullName = "Ashrafur Rahman Prince";
static const String nickname = "Prince";
```

#### `Habit` Model
```dart
class Habit {
  final String id;
  final String name;
  final String emoji;
  final List<bool> completionDays;  // 31 days
  // ... properties and methods
}
```

#### `HabitTrackerProvider` (ChangeNotifier)
Manages all application state with methods:
- `toggleHabitDay(habitId, dayIndex)` - Toggle habit completion
- `setMood(moodIndex)` - Update mood (0-4)
- `updateSleepHours(hours)` - Log sleep hours
- Various getters for analytics and statistics

### Data Structure
- **10 Core Habits** tracked across 31 days
- Each habit stores completion state as a `List<bool>`
- Automatic calculation of completion percentages and metrics
- Real-time UI updates via Provider pattern

## 📊 Component Breakdown

### 1. Premium Header
- User profile avatar with fallback
- Full name and nickname display
- Workspace title ("Prince's Lifestyle Matrix")
- Current tracking period ("March 2026")

### 2. Top Statistics Section
- **Left Panel**: Circular progress indicator (overall completion %)
- **Right Panel**: Numeric breakdown (Goal, Completed, Remaining)

### 3. Daily Performance Chart
- Horizontal scrollable bar chart
- Day-by-day completion rates
- Visual fill height based on percentage
- Dynamic updates as habits are toggled

### 4. Master Habit Grid (Core Feature)
- **Sticky Left Column**: Habit names with emojis
- **Scrollable Calendar Matrix**: 31-day grid with custom checkboxes
- **Day Headers**: Day abbreviation and number
- **Real-time Updates**: Instant stat recalculation on toggle

### 5. Habit Analysis Table
- Tabular breakdown of all 10 habits
- Columns: Habit, Goal (31), Actual (completed), Left, Progress %
- Mini progress bars with visual indicators
- Color-coded text (cyan for completed, red for remaining)

### 6. Wellness Tracker
- **Mood Selector**: 5 emoji-based mood tracker
- **Sleep Logger**: Hours with +/- increment buttons
- Real-time updates to model

## 🎨 Visual Theme

### Color Palette
- **Background**: Deep Charcoal (`#0A0E27`)
- **Secondary Background**: `#15192D`
- **Primary Accent**: Bright Cyan (`#00D4FF`)
- **Grid Borders**: `#2A3150`
- **Text Primary**: Off-White (`#E0E3F0`)
- **Text Secondary**: Muted Grey (`#B0B5C8`)
- **Accent Text**: Cyan (`#00D4FF`)
- **Warning/Remaining**: Red (`#FF6B6B`)

### Typography
- **Font Family**: Roboto (Flutter default)
- **Headers**: Bold (weight: 700-900), sizes: 16-40px
- **Body**: Regular (weight: 500-600), sizes: 11-13px
- **Numbers**: Bold (weight: 700-800), sizes: 12-32px

## 🔧 Customization Guide

### Change User Details
Edit `UserConfig` class in `main.dart`:
```dart
class UserConfig {
  static const String fullName = "Your Full Name";
  static const String nickname = "Your Nickname";
  static const String profileImagePath = 'assets/your_image.png';
}
```

### Modify Habit List
Edit `_initializeHabits()` in `HabitTrackerProvider`:
```dart
Habit(
  id: '11',
  name: 'Your New Habit',
  emoji: '🎯',
  completionDays: List.generate(31, (i) => i % 2 == 0),
),
```

### Adjust Color Scheme
Search for color constants (`Color(0xFF...)`) and replace with your preferred colors throughout `main.dart`.

### Customize Tracking Period
Change "March 2026" in the `PremiumHeader` widget or make it dynamic by adding a date parameter to the provider.

## 📱 Responsive Design

The app is built with responsive widgets:
- **Flexible Layouts**: `Expanded`, `Flexible`, and `Row`/`Column` combinations
- **Horizontal Scrolling**: Scrollable calendar grid for 31-day month
- **Adaptive Containers**: Proper padding and spacing
- **Scalable Typography**: Readable on all screen sizes
- **Touch-friendly**: Adequate tap targets (min 48x48 for checkboxes)

## 🧪 Testing the App

### Test Habit Toggling
1. Click any checkbox in the habit grid
2. Observe instant updates in:
   - Daily Performance Chart
   - Overall Stats Ring
   - Analysis Table
   - Numeric Breakdown

### Test Mood Tracking
1. Click any mood emoji in the Wellness Tracker
2. Observe the selection highlight change

### Test Sleep Logger
1. Use +/- buttons to adjust sleep hours
2. Verify hours update (0-24 range)

## 📝 Dependencies

- **Flutter SDK**: >=3.0.0
- **provider**: ^6.0.0 (State management)
- **cupertino_icons**: ^1.0.2 (Icon assets)

All dependencies are specified in `pubspec.yaml`. Run `flutter pub get` to install them.

## 🐛 Troubleshooting

### Profile Image Not Loading
- **Issue**: Circular avatar shows "P" instead of image
- **Solution**: Ensure `assets/prince_profile.png` exists and is properly referenced in `pubspec.yaml`

### App Not Compiling
- **Issue**: Dependency errors
- **Solution**: Run `flutter clean` and `flutter pub get`

### Performance Issues
- **Issue**: Slow rendering on older devices
- **Solution**: Reduce animation complexity or use `RepaintBoundary` widgets for optimization

### Layout Overflow
- **Issue**: Grid extends beyond screen
- **Solution**: App is fully scrollable; ensure horizontal scroll on calendar grid works

## 📄 License

This project is proprietary and customized for Ashrafur Rahman Prince. Personal use only.

## ✨ Future Enhancement Ideas

- Cloud sync with Firebase
- Habit streak counter and badges
- Weekly/monthly performance reports
- Dark/Light theme toggle
- Custom habit creation UI
- Export data to CSV/PDF
- Push notifications for reminders
- Social sharing features
- Habit categories and tags
- Advanced analytics with trend charts

## 👤 Author

**Ashrafur Rahman Prince** - Custom Flutter Development

---

**Created**: 2026
**Last Updated**: March 2026
**Status**: Production Ready

For questions or support, refer to the inline code documentation in `main.dart`.
