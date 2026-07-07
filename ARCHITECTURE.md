# Architecture & Implementation Notes

## Project Overview

**Prince's Lifestyle Matrix** is a premium Flutter habit tracker dashboard with real-time state management and responsive UI design. This document outlines the technical architecture, design decisions, and implementation details.

---

## Architecture Pattern

### State Management: Provider Pattern

We use the **Provider** package with **ChangeNotifier** pattern for state management:

```
┌─────────────────────────────────────┐
│   HabitTrackerProvider              │
│  (ChangeNotifier / Business Logic)  │
├─────────────────────────────────────┤
│ - habits: List<Habit>               │
│ - _currentMood: int                 │
│ - _sleepHours: int                  │
│                                     │
│ Methods:                            │
│ - toggleHabitDay()                  │
│ - setMood()                         │
│ - updateSleepHours()                │
│ - Getters for computed stats        │
└─────────────────────────────────────┘
         ↓
    notifyListeners()
         ↓
┌─────────────────────────────────────┐
│   Consumer Widgets                  │
│  (Listen to state changes)          │
├─────────────────────────────────────┤
│ - TopStatsSection                   │
│ - DailyPerformanceChart             │
│ - MasterHabitGrid                   │
│ - HabitAnalysisTable                │
│ - WellnessTracker                   │
└─────────────────────────────────────┘
```

### Why Provider?
- ✅ Minimal boilerplate
- ✅ Automatic widget rebuilds on state change
- ✅ Better performance than setState
- ✅ Easy to test and maintain
- ✅ Recommended by Flutter team

---

## Data Structures

### Habit Model
```dart
class Habit {
  final String id;                           // Unique identifier
  final String name;                         // "Wake up at 05:00"
  final String emoji;                        // "⏰"
  final List<bool> completionDays;           // [true, false, true, ...]
  
  // Computed properties
  int get completedCount => ...;             // Days completed
  int get remainingCount => ...;             // Days remaining
  double get progressPercentage => ...;      // 0-100%
}
```

### State Structure
```dart
class HabitTrackerProvider extends ChangeNotifier {
  late List<Habit> _habits;                  // 10 habits, 31 days each
  int _currentMood = 2;                      // 0-4 emoji index
  int _sleepHours = 7;                       // 0-24 hours
  
  // Computed getters for real-time stats
  int get totalCompletedChecks => ...;       // Sum across all days
  int get totalPossibleChecks => 310;        // 10 habits × 31 days
  double get overallCompletionPercentage => ...;
  int getDayCompletionCount(int dayIndex) => ...;
}
```

---

## Widget Hierarchy

```
MaterialApp
└── DashboardScreen
    └── SingleChildScrollView
        └── Column
            ├── PremiumHeader
            │   ├── CircleAvatar (profile)
            │   └── Text (name, workspace title)
            │
            ├── TopStatsSection
            │   ├── Left: Circular Progress Indicator
            │   └── Right: Numeric Breakdown
            │
            ├── DailyPerformanceChart
            │   └── ListView.builder (31 days)
            │       └── Container (bar)
            │
            ├── MasterHabitGrid
            │   ├── Container (sticky labels)
            │   │   └── Column (habit names)
            │   └── SingleChildScrollView (calendar)
            │       └── Row (days)
            │           └── _HabitCheckbox
            │
            ├── HabitAnalysisTable
            │   └── Column
            │       ├── Header Row
            │       └── Habit Rows with progress
            │
            └── WellnessTracker
                ├── Mood Selector
                └── Sleep Logger
```

---

## Data Flow Diagram

```
User Interaction (click checkbox)
         ↓
_HabitCheckbox.onTap()
         ↓
context.read<HabitTrackerProvider>().toggleHabitDay()
         ↓
HabitTrackerProvider.notifyListeners()
         ↓
All Consumer Widgets Rebuild:
├── TopStatsSection recalculates percentages
├── DailyPerformanceChart updates bar heights
├── MasterHabitGrid reflects checkbox state
└── HabitAnalysisTable refreshes progress bars
```

---

## Key Implementation Details

### 1. Real-Time Stats Calculation

**OnChange Flow**:
```dart
void toggleHabitDay(String habitId, int dayIndex) {
  final habitIndex = _habits.indexWhere((h) => h.id == habitId);
  if (habitIndex != -1) {
    // Toggle the boolean
    _habits[habitIndex].completionDays[dayIndex] = 
        !_habits[habitIndex].completionDays[dayIndex];
    // Trigger rebuild
    notifyListeners();  // ← All consumers rebuild
  }
}
```

**Computed Stats**:
```dart
double get overallCompletionPercentage {
  return (totalCompletedChecks / totalPossibleChecks) * 100;
  // This automatically reflects changes because totalCompletedChecks
  // is recalculated from _habits each time it's accessed
}
```

### 2. Responsive Grid Layout

**Sticky Left Column + Scrollable Calendar**:
```dart
Row(
  children: [
    // Fixed width sticky column
    Container(width: 180, ...)
    
    // Expanded scrollable calendar
    Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _gridScrollController,
        child: Row(
          children: List.generate(31, ...)
        )
      )
    )
  ]
)
```

### 3. Custom Checkbox Design

```dart
GestureDetector(
  onTap: () => provider.toggleHabitDay(habitId, dayIndex),
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      border: Border.all(
        color: isChecked ? cyan : grey,
      ),
      color: isChecked ? cyan.withOpacity(0.1) : null,
    ),
    child: isChecked ? Icon(Icons.check) : null,
  ),
)
```

### 4. Color System

Uses a consistent color palette with semantic naming:
```dart
const Color kBgDark = Color(0xFF0A0E27);      // Main background
const Color kBgSecondary = Color(0xFF15192D);  // Card background
const Color kBorder = Color(0xFF2A3150);       // Borders
const Color kAccent = Color(0xFF00D4FF);       // Primary accent (cyan)
const Color kTextPrimary = Color(0xFFE0E3F0);  // Primary text
const Color kTextSecondary = Color(0xFFB0B5C8);// Secondary text
const Color kTextMuted = Color(0xFF7A7F8F);    // Muted text
const Color kWarning = Color(0xFFFF6B6B);      // Warning/negative
```

---

## Performance Considerations

### Optimizations Implemented

1. **Const Constructors**
   - All widgets use `const` where possible
   - Reduces unnecessary rebuilds

2. **Provider Scoping**
   - Consumer widgets wrap only necessary parts
   - Prevents full-screen rebuilds

3. **List.generate() Efficiency**
   - Habits use List.generate for initial data
   - Predictable memory usage

4. **Scrolling Optimization**
   - ListView for 31 days (not GridView)
   - More efficient for horizontal scroll
   - PageView could replace for swipe navigation

### Potential Improvements

- Add `RepaintBoundary` for expensive chart rendering
- Implement virtual scrolling for 1000+ items
- Use `computeValue` pattern for expensive calculations
- Add `kIsWeb` checks for platform-specific optimizations

---

## State Mutations

### Safe State Updates

All mutations happen through provider methods:
```dart
// ✅ Good: Goes through provider
provider.toggleHabitDay(habitId, dayIndex);

// ❌ Bad: Direct state mutation
provider.habits[0].completionDays[0] = true;  // Won't notify!
```

### Immutability Considerations

Current implementation uses mutable List for 31-day data:
```dart
List<bool> completionDays;  // Mutable
```

For better practices with large datasets:
```dart
final List<bool> completionDays;  // Make final
// Use List.from() or spread operator for modifications
```

---

## Extension Points

### Adding a New Feature: Habit Streaks

```dart
// 1. Add to Habit model
class Habit {
  int get currentStreak => ...;  // Calculate consecutive days
}

// 2. Add to provider
class HabitTrackerProvider {
  void resetStreak(String habitId) {
    notifyListeners();
  }
}

// 3. Display in UI
Text('Streak: ${habit.currentStreak} days')
```

### Adding Habit Categories

```dart
// 1. Extend model
class Habit {
  final HabitCategory category;  // HEALTH, PRODUCTIVITY, MINDSET
}

// 2. Filter in provider
List<Habit> getHabitsByCategory(HabitCategory category) {
  return _habits.where((h) => h.category == category).toList();
}

// 3. Group in UI
for (var category in HabitCategory.values) {
  HabitSection(category: category)
}
```

### Adding Persistence

```dart
// Use shared_preferences or hive
Future<void> saveHabits() async {
  final json = _habits.map((h) => h.toJson()).toList();
  await prefs.setString('habits', jsonEncode(json));
}

Future<void> loadHabits() async {
  final json = prefs.getString('habits');
  _habits = (jsonDecode(json) as List)
      .map((h) => Habit.fromJson(h))
      .toList();
  notifyListeners();
}
```

---

## Testing Strategy

### Unit Tests

```dart
test('Habit completion percentage calculation', () {
  final habit = Habit(
    id: '1',
    name: 'Test',
    emoji: '📝',
    completionDays: List.generate(31, (i) => i < 15),
  );
  expect(habit.progressPercentage, equals(100 * 15 / 31));
});
```

### Widget Tests

```dart
testWidgets('Checkbox toggles habit state', (tester) async {
  await tester.pumpWidget(const PrinceLifeTrackerApp());
  
  expect(find.byIcon(Icons.check), findsNothing);
  
  await tester.tap(find.byType(_HabitCheckbox).first);
  await tester.pump();
  
  expect(find.byIcon(Icons.check), findsOne);
});
```

---

## Code Quality

### Linting Rules Applied
- Uses `flutter_lints` with strict rules
- All files pass `flutter analyze`
- Consistent naming conventions
  - Classes: PascalCase
  - Methods/variables: camelCase
  - Constants: CONSTANT_CASE

### Comment Strategy
- Architecture-level comments at class level
- Complex logic has inline comments
- UI structure comments for large widgets
- Method documentation for public APIs

---

## Deployment Checklist

- [ ] Update version in pubspec.yaml
- [ ] Run `flutter analyze` - no errors
- [ ] Run tests with coverage
- [ ] Build APK: `flutter build apk`
- [ ] Test on multiple devices
- [ ] Update CHANGELOG
- [ ] Tag git commit with version

---

## Troubleshooting Guide

### Issue: Stats not updating
**Cause**: Missing `notifyListeners()`
**Fix**: Ensure all state mutations call notifyListeners()

### Issue: Checkboxes not clickable
**Cause**: GestureDetector hierarchy issue
**Fix**: Verify GestureDetector wraps the entire clickable area

### Issue: Layout overflow on small screens
**Cause**: Insufficient scrolling containers
**Fix**: App uses SingleChildScrollView and ListView - should handle all sizes

### Issue: Performance lag with 31-day grid
**Cause**: All 310 cells rebuild together
**Fix**: Already optimized - if issue persists, profile with DevTools

---

## Future Roadmap

### Phase 2: Analytics
- Weekly/monthly reports
- Trend analysis charts
- Habit correlation insights
- Export functionality

### Phase 3: Social
- Share achievements
- Accountability partners
- Leaderboards

### Phase 4: AI
- Personalized recommendations
- Pattern detection
- Predictive analytics

### Phase 5: Integration
- Calendar sync
- Smartwatch support
- Voice logging

---

## References & Resources

- **Provider Package**: https://pub.dev/packages/provider
- **Flutter Architecture**: https://flutter.dev/docs/development/architecture
- **State Management Guide**: https://flutter.dev/docs/development/data-and-backend/state-mgmt/intro
- **Performance Best Practices**: https://flutter.dev/docs/perf/best-practices

---

**Last Updated**: March 2026
**Version**: 1.0.0
**Status**: Production Ready
