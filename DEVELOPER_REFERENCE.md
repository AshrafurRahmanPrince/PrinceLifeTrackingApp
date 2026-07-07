# Developer Quick Reference

## Quick Commands

```bash
# Get dependencies
flutter pub get

# Run app
flutter run

# Run in release mode (faster)
flutter run --release

# Run on specific device
flutter run -d chrome          # Web
flutter run -d windows         # Desktop
flutter run -d android         # Android

# Check project health
flutter doctor

# Clean project
flutter clean

# Analyze code quality
flutter analyze

# Run tests
flutter test

# Format code
dart format lib/

# Upgrade Flutter
flutter upgrade
```

---

## Common Code Patterns

### Access Provider State
```dart
// In Consumer widget
Consumer<HabitTrackerProvider>(
  builder: (context, provider, _) {
    return Text('${provider.overallCompletionPercentage.toStringAsFixed(0)}%');
  },
)

// Direct access (avoid in build methods)
final provider = context.read<HabitTrackerProvider>();

// Watch for changes
final provider = context.watch<HabitTrackerProvider>();
```

### Toggle a Habit
```dart
// Inside onTap or button handler
context.read<HabitTrackerProvider>().toggleHabitDay(habitId, dayIndex);
```

### Access a Single Habit
```dart
final provider = context.watch<HabitTrackerProvider>();
final habit = provider.habits.firstWhere((h) => h.id == '1');
```

### Styled Container
```dart
Container(
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: const Color(0xFF15192D),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: const Color(0xFF2A3150),
      width: 1,
    ),
  ),
  child: Text('Content'),
)
```

### Styled Text
```dart
// Heading
Text(
  'Section Title',
  style: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  ),
)

// Muted text
Text(
  'Secondary info',
  style: const TextStyle(
    fontSize: 12,
    color: Color(0xFF7A7F8F),
  ),
)
```

---

## Widget Structure Reference

### Consumer Pattern
```dart
Consumer<HabitTrackerProvider>(
  builder: (context, provider, child) {
    return Column(
      children: [
        Text('${provider.totalCompletedChecks}'),
        child,
      ],
    );
  },
  child: const Text('Unchanging text'), // Optional optimization
)
```

### Scrollable Row
```dart
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: List.generate(31, (i) => 
      Container(width: 50, height: 100)
    ),
  ),
)
```

### Responsive Split Layout
```dart
Row(
  children: [
    Expanded(flex: 1, child: Container(...)),
    const SizedBox(width: 20),
    Expanded(flex: 1, child: Container(...)),
  ],
)
```

### Data Table
```dart
Column(
  children: [
    // Header
    Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: const [
          Expanded(flex: 2, child: Text('Column 1')),
          Expanded(flex: 1, child: Text('Column 2')),
        ],
      ),
    ),
    // Rows
    ...items.map((item) => Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(item.name)),
          Expanded(flex: 1, child: Text(item.value)),
        ],
      ),
    )),
  ],
)
```

---

## Color Constants Quick Reference

```dart
const Color kBgDark = Color(0xFF0A0E27);        // Main bg
const Color kBgSecondary = Color(0xFF15192D);   // Cards
const Color kBorder = Color(0xFF2A3150);        // Borders
const Color kAccent = Color(0xFF00D4FF);        // Cyan accent
const Color kTextPrimary = Color(0xFFE0E3F0);   // Main text
const Color kTextSecondary = Color(0xFFB0B5C8); // Secondary text
const Color kTextMuted = Color(0xFF7A7F8F);     // Muted text
const Color kWarning = Color(0xFFFF6B6B);       // Red warning
```

**Using colors**:
```dart
color: const Color(0xFF00D4FF),  // Direct
color: kAccent,                  // Via constant (if defined)
```

---

## Common Statistics Getters

```dart
// In HabitTrackerProvider

// Total completed checks across all habits
int get totalCompletedChecks => 
    _habits.fold(0, (sum, habit) => sum + habit.completedCount);

// Overall percentage
double get overallCompletionPercentage => 
    (totalCompletedChecks / totalPossibleChecks) * 100;

// Specific day completion
int getDayCompletionCount(int dayIndex) => 
    _habits.where((habit) => habit.completionDays[dayIndex]).length;

double getDayCompletionPercentage(int dayIndex) => 
    (getDayCompletionCount(dayIndex) / _habits.length) * 100;
```

---

## Habit Model Quick Reference

```dart
Habit habit = provider.habits[0];

// Properties
habit.id                    // "1"
habit.name                  // "Wake up at 05:00"
habit.emoji                 // "⏰"
habit.completionDays        // [true, false, true, ...]

// Computed values
habit.completedCount        // 15
habit.remainingCount        // 16
habit.progressPercentage    // 48.39
```

---

## State Management Cheat Sheet

### Update Habit
```dart
// Toggle day 5 (index 4) for habit "1"
provider.toggleHabitDay('1', 4);
```

### Update Mood
```dart
// 0=😢, 1=😐, 2=🙂, 3=😀, 4=🤩
provider.setMood(3);
```

### Update Sleep
```dart
provider.updateSleepHours(8);
// Automatically clamped to 0-24
```

### Read Current Values
```dart
int hours = provider.sleepHours;
int mood = provider.currentMood;
double percentage = provider.overallCompletionPercentage;
```

---

## Testing Common Scenarios

### Test Habit Toggle
```dart
testWidgets('Toggle habit completion', (tester) async {
  await tester.pumpWidget(const PrinceLifeTrackerApp());
  
  // Find and tap checkbox
  await tester.tap(find.byType(_HabitCheckbox).first);
  await tester.pump();
  
  // Verify check icon appears
  expect(find.byIcon(Icons.check), findsWidgets);
});
```

### Test Stats Update
```dart
test('Stats update on habit toggle', () {
  final provider = HabitTrackerProvider();
  final initialPercentage = provider.overallCompletionPercentage;
  
  provider.toggleHabitDay('1', 0);
  
  expect(
    provider.overallCompletionPercentage, 
    isNot(equals(initialPercentage))
  );
});
```

---

## File Navigation

```
lib/main.dart
├── UserConfig                    (Line ~13)
├── Habit Model                   (Line ~20)
├── HabitTrackerProvider          (Line ~30)
├── PrinceLifeTrackerApp          (Line ~100)
├── DashboardScreen               (Line ~130)
├── PremiumHeader                 (Line ~165)
├── TopStatsSection               (Line ~210)
├── DailyPerformanceChart         (Line ~300)
├── MasterHabitGrid               (Line ~350)
├── _DayHeader                    (Line ~450)
├── _HabitCheckbox                (Line ~480)
├── HabitAnalysisTable            (Line ~520)
└── WellnessTracker               (Line ~650)
```

---

## Performance Tips

1. **Use const constructors**
   ```dart
   const Text('Always const')  // ✅ Good
   Text('Sometimes const')      // ❌ Bad (if can be const)
   ```

2. **Minimize Consumer scope**
   ```dart
   // ✅ Good: Only stats widget rebuilds
   Consumer<Provider>(builder: (_, p, __) => StatsWidget())
   
   // ❌ Bad: Entire screen rebuilds
   Consumer<Provider>(builder: (_, p, __) => DashboardScreen())
   ```

3. **Use child parameter**
   ```dart
   // ✅ Good: Unchanged widget rebuilds once
   Consumer<Provider>(
     builder: (_, p, child) => Column(children: [p.data, child]),
     child: ExpensiveWidget(),
   )
   ```

---

## Debugging Tips

### Print Provider State
```dart
// Add to provider method
print('Habits: ${_habits.map((h) => h.completedCount).toList()}');
print('Overall %: $overallCompletionPercentage');
```

### Inspect Widget Tree
```bash
flutter run
# Press 'w' in terminal to show widget inspector
```

### Find Rebuilds
```dart
// In main.dart
debugPrintRebuildDirtyWidgets = true;
```

### Check Performance
```bash
flutter run --profile
# Press 'p' to show performance overlay
```

---

## Common Errors & Fixes

| Error | Cause | Fix |
|-------|-------|-----|
| `Bad state: No ChangeNotifier found` | Provider not initialized | Wrap app with `ChangeNotifierProvider` |
| `RenderFlex overflowed` | Widget too wide | Use `Expanded` or `SingleChildScrollView` |
| `State not updating` | Missing `notifyListeners()` | Add `notifyListeners()` after state change |
| `Null check error` | Accessing null value | Use `?.` or null coalescing `??` |
| `Asset not found` | Missing image file | Add image to `assets/` folder |

---

## Quick Customization Checklist

- [ ] Change `UserConfig.fullName` and `nickname`
- [ ] Add profile image to `assets/prince_profile.png`
- [ ] Modify habits in `_initializeHabits()`
- [ ] Update colors if desired
- [ ] Adjust tracking period
- [ ] Run `flutter analyze` - should pass
- [ ] Test on device/emulator

---

## Important Statistics Formulas

```
Total Possible Checks = Habits × Days = 10 × 31 = 310

Habit Progress % = Completed Days ÷ 31 × 100

Daily Completion % = Completed Habits ÷ Total Habits × 100

Overall Completion % = Total Completed ÷ Total Possible × 100
```

---

## Widget Quick Insert

### Add New Stat Box
```dart
_StatisticRow(
  label: 'New Stat',
  value: '${provider.newValue}',
  color: const Color(0xFF00D4FF),
),
```

### Add New Habit
```dart
Habit(
  id: '11',
  name: 'New Habit Name',
  emoji: '🎯',
  completionDays: List.generate(31, (i) => i % 2 == 0),
),
```

### Add New Color Variable
```dart
// Add to top of main.dart
const Color kNewColor = Color(0xFF123456);

// Use everywhere
Container(color: kNewColor)
```

---

## Useful Extensions

### Add Formatting Helper
```dart
extension StringExt on String {
  String get toProperCase => 
    '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
}

// Usage: 'prince'.toProperCase → 'Prince'
```

### Add Percentage Helper
```dart
extension DoubleExt on double {
  String get asPercent => '${toStringAsFixed(0)}%';
}

// Usage: 86.5.asPercent → '86%'
```

---

**Save this reference for quick lookups!**

Last Updated: March 2026 | Version: 1.0.0
