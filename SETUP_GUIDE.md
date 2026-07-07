# Setup & Configuration Guide

## Quick Start (5 Minutes)

### Step 1: Ensure Flutter is Installed
```bash
flutter --version
# Should show Flutter 3.0.0 or higher
```

### Step 2: Install Dependencies
```bash
cd PrinceLifeTrackiungApp
flutter pub get
```

### Step 3: Run the App
```bash
flutter run
```

The app will open in your default device/emulator with a fully functional habit tracker!

---

## Detailed Setup Instructions

### For Windows Development

#### Prerequisites
1. **Flutter SDK**
   - Download from: https://flutter.dev/docs/get-started/install/windows
   - Add to PATH
   - Verify: `flutter --version`

2. **Dart SDK** (usually bundled with Flutter)
   - Verify: `dart --version`

3. **Android Studio or VS Code**
   - Android Studio: https://developer.android.com/studio
   - VS Code: https://code.visualstudio.com

4. **Android Emulator or Device**
   - Physical device with USB debugging enabled, OR
   - Android Emulator from Android Studio

#### Installation Steps
```bash
# 1. Navigate to project
cd PrinceLifeTrackiungApp

# 2. Get dependencies
flutter pub get

# 3. Check setup (optional)
flutter doctor
# Should show no errors for your target platform

# 4. Run app
flutter run

# 5. Select device if prompted
# (Emulator, connected Android device, etc.)
```

---

### For Android Development

#### First-Time Setup
```bash
# Check Flutter setup
flutter doctor

# If issues, run:
flutter doctor --android-licenses
# Agree to all licenses
```

#### Run on Android Emulator
```bash
# List available emulators
emulator -list-avds

# Start emulator
emulator -avd Pixel_5_API_31  # (or your emulator name)

# Wait for emulator to boot, then:
flutter run
```

#### Run on Physical Device
1. Enable **Developer Mode** on Android device:
   - Go to Settings → About Phone
   - Tap "Build Number" 7 times
   - Return to Settings → Developer Options
   - Enable "USB Debugging"

2. Connect device via USB
3. Verify connection:
   ```bash
   flutter devices
   ```
4. Run:
   ```bash
   flutter run
   ```

---

### For Web Development

#### Prerequisites
```bash
# Enable web support
flutter config --enable-web
```

#### Run on Web
```bash
# Run on Chrome (default)
flutter run -d chrome

# Or on other browsers:
flutter run -d edge
flutter run -d firefox
```

#### Build Web Version
```bash
flutter build web
# Output in: build/web/
# Can be deployed to any static host (Firebase, Netlify, etc.)
```

---

### For Desktop (Windows)

#### Prerequisites
- Visual Studio 2019 or later with C++ build tools
- Windows 10 SDK or later

#### Run Desktop Version
```bash
# Enable Windows desktop
flutter config --enable-windows

# Run
flutter run -d windows
```

---

## Project Configuration Details

### pubspec.yaml Breakdown

```yaml
name: prince_life_tracker
description: "Prince's Lifestyle Matrix - comprehensive habit tracker"
version: 1.0.0+1

# Supported Dart/Flutter versions
environment:
  sdk: '>=3.0.0 <4.0.0'

# Dependencies
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0              # State management
  cupertino_icons: ^1.0.2       # iOS icons

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0         # Code quality

# Asset configuration
flutter:
  uses-material-design: true
  assets:
    - assets/prince_profile.png
    - assets/
```

### Adding New Dependencies

To add a package (e.g., `intl` for date formatting):

```bash
# Add to pubspec.yaml
flutter pub add intl

# Or manually edit pubspec.yaml:
dependencies:
  intl: ^0.18.0

# Then run
flutter pub get
```

---

## Customization Guide

### 1. Change User Profile

**File**: `lib/main.dart`

Find the `UserConfig` class:
```dart
class UserConfig {
  static const String fullName = "Ashrafur Rahman Prince";
  static const String nickname = "Prince";
  static const String profileImagePath = 'assets/prince_profile.png';
  static const String workspaceTitle = "Lifestyle Matrix";
}
```

Edit these values to personalize.

### 2. Add Profile Picture

1. Prepare a square PNG/JPG image (recommended 256x256px)
2. Save as `assets/prince_profile.png`
3. Restart the app
4. The image will display in the circular avatar

**Note**: The app has a fallback "P" initial if the image is missing.

### 3. Modify Habit List

**File**: `lib/main.dart`, find `_initializeHabits()` method in `HabitTrackerProvider`

Current habits:
```dart
Habit(
  id: '1',
  name: 'Wake up at 05:00',
  emoji: '⏰',
  completionDays: List.generate(31, (i) => i % 3 == 0),
),
```

To add a new habit, insert before the closing bracket:
```dart
Habit(
  id: '11',
  name: 'Meditation',
  emoji: '🧘',
  completionDays: List.generate(31, (i) => i < 20),
),
```

**Important**: Update the `_initializeHabits()` return statement to generate proper initial data.

### 4. Change Colors

All colors use hex notation: `Color(0xFFRRGGBB)`

**Primary Accent** (Cyan):
- Search: `Color(0xFF00D4FF)`
- Replace with your color

**Background Dark**:
- Search: `Color(0xFF0A0E27)`
- Replace with your color

**Secondary Background**:
- Search: `Color(0xFF15192D)`
- Replace with your color

Example colors:
- Purple: `Color(0xFF9C27B0)`
- Green: `Color(0xFF4CAF50)`
- Orange: `Color(0xFFFF9800)`
- Red: `Color(0xFFF44336)`

### 5. Adjust Tracking Period

**File**: `lib/main.dart`, find `PremiumHeader` widget

Change:
```dart
Text(
  'March 2026 • Tracking Period',
  // Change "March 2026" to your period
),
```

Or make it dynamic:
```dart
final now = DateTime.now();
final monthName = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 
                   'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][now.month - 1];
Text('${monthName} ${now.year} • Tracking Period'),
```

### 6. Modify Sleep Hour Range

**File**: `lib/main.dart`, find `updateSleepHours()` in provider:

Current: `_sleepHours = hours.clamp(0, 24);`

Change max value:
```dart
_sleepHours = hours.clamp(0, 12);  // 0-12 hours max
```

---

## Building for Release

### Android APK
```bash
flutter build apk
# Output: build/app/release/app-release.apk
```

### Android App Bundle (Google Play)
```bash
flutter build appbundle
# Output: build/app/release/app-release.aab
```

### iOS (macOS required)
```bash
flutter build ios
```

### Web Production Build
```bash
flutter build web
# Deploy the build/web/ folder
```

---

## Testing & Validation

### Run Tests
```bash
flutter test
```

### Check Code Quality
```bash
flutter analyze
```

### Performance Profiling
```bash
flutter run --profile
```

---

## Environment Variables (Optional)

Create a `.env` file for app configuration:

```env
APP_NAME=Prince's Lifestyle Matrix
USER_FULL_NAME=Ashrafur Rahman Prince
USER_NICKNAME=Prince
TRACKING_PERIOD=March 2026
```

Then load in code using a package like `flutter_dotenv`.

---

## Troubleshooting

### Error: "pubspec.yaml not found"
**Solution**: Ensure you're in the project root directory
```bash
cd PrinceLifeTrackiungApp
```

### Error: "Provider not found"
**Solution**: Install provider package
```bash
flutter pub add provider
flutter pub get
```

### Error: "Asset not found - prince_profile.png"
**Solution**: Asset is optional. App shows fallback initial "P". To add it:
1. Create/obtain `prince_profile.png`
2. Place in `assets/` folder
3. Restart app

### App Crashes on Startup
**Solution**: Run `flutter clean` and restart
```bash
flutter clean
flutter pub get
flutter run
```

### Slow Performance
**Solution**: Run in release mode
```bash
flutter run --release
```

### Emulator Not Detected
**Solution**: Restart adb
```bash
adb kill-server
adb start-server
flutter devices
```

---

## Version Management

### Update Flutter & Dart
```bash
# Update to latest stable
flutter upgrade

# Check for package updates
flutter pub upgrade

# Check specifically which packages need updating
flutter pub outdated
```

### Update Individual Packages
```bash
flutter pub add provider --upgrade
```

---

## Performance Optimization

The app is already optimized with:
- ✅ Provider for efficient state management
- ✅ Const constructors where possible
- ✅ SingleChildScrollView and ListView for scrolling
- ✅ Minimal rebuild cycles

For further optimization:
- Use `RepaintBoundary` for expensive widgets
- Profile with `flutter run --profile`
- Use `const` more aggressively
- Consider lazy loading for large datasets

---

## Next Steps

1. **Test the app** in various scenarios
2. **Customize** user details and colors
3. **Add your profile image** for personalization
4. **Explore** the code comments for deeper understanding
5. **Extend** with additional features using Provider pattern

---

## Support & Documentation

- **Flutter Docs**: https://flutter.dev/docs
- **Provider Package**: https://pub.dev/packages/provider
- **Dart Language**: https://dart.dev/guides
- **Material Design**: https://material.io/design

---

**Happy Tracking! 🎯**
