import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const PrinceLifeTrackerApp());
}

// ==================== USER CONFIGURATION ====================
class UserConfig {
  static const String fullName = 'Ashrafur Rahman Prince';
  static const String nickname = 'Prince';
  static const String profileImagePath = 'assets/prince_profile.png';
  static const String workspaceTitle = 'Lifestyle Matrix';
}

// ==================== MODELS ====================
class Habit { // 31 days

  Habit({
    required this.id,
    required this.name,
    required this.emoji,
    required this.completionDays,
  });
  final String id;
  final String name;
  final String emoji;
  final List<bool> completionDays;

  int get completedCount => completionDays.where((e) => e).length;
  int get remainingCount => completionDays.where((e) => !e).length;
  double get progressPercentage => (completedCount / 31) * 100;
}

// ==================== STATE MANAGEMENT ====================
class HabitTrackerProvider extends ChangeNotifier {

  HabitTrackerProvider() {
    _initializeHabits();
  }
  late List<Habit> _habits;
  int _currentMood = 2; // 0-4: 😢 😐 🙂 😀 🤩
  int _sleepHours = 7;

  void _initializeHabits() {
    _habits = [
      Habit(
        id: '1',
        name: 'Wake up at 05:00',
        emoji: '⏰',
        completionDays: List.generate(31, (i) => i % 3 == 0),
      ),
      Habit(
        id: '2',
        name: 'Gym',
        emoji: '💪',
        completionDays: List.generate(31, (i) => i % 2 == 0),
      ),
      Habit(
        id: '3',
        name: 'Reading / Learning',
        emoji: '📚',
        completionDays: List.generate(31, (i) => i % 2 != 0),
      ),
      Habit(
        id: '4',
        name: 'Day Planning',
        emoji: '🗓️',
        completionDays: List.generate(31, (i) => i % 4 != 0),
      ),
      Habit(
        id: '5',
        name: 'No Gooning',
        emoji: '🥶',
        completionDays: List.generate(31, (i) => i % 5 != 0),
      ),
      Habit(
        id: '6',
        name: 'Project Work',
        emoji: '🛠️',
        completionDays: List.generate(31, (i) => i % 3 != 0),
      ),
      Habit(
        id: '7',
        name: 'No Alcohol',
        emoji: '🙅‍♂️',
        completionDays: List.generate(31, (i) => i < 25),
      ),
      Habit(
        id: '8',
        name: 'Social Media Detox',
        emoji: '🌿',
        completionDays: List.generate(31, (i) => i % 2 == 0 || i > 20),
      ),
      Habit(
        id: '9',
        name: 'Goal Journaling',
        emoji: '📝',
        completionDays: List.generate(31, (i) => i % 7 < 5),
      ),
      Habit(
        id: '10',
        name: 'Cold Shower',
        emoji: '❄️',
        completionDays: List.generate(31, (i) => i % 4 == 0 || i % 4 == 1),
      ),
    ];
  }

  List<Habit> get habits => _habits;
  int get currentMood => _currentMood;
  int get sleepHours => _sleepHours;

  int get totalCompletedChecks =>
      _habits.fold(0, (sum, habit) => sum + habit.completedCount);
  int get totalPossibleChecks => _habits.length * 31;
  int get remainingChecks => totalPossibleChecks - totalCompletedChecks;
  double get overallCompletionPercentage =>
      (totalCompletedChecks / totalPossibleChecks) * 100;

  int getDayCompletionCount(int dayIndex) => _habits.where((habit) => habit.completionDays[dayIndex]).length;

  double getDayCompletionPercentage(int dayIndex) => (getDayCompletionCount(dayIndex) / _habits.length) * 100;

  void toggleHabitDay(String habitId, int dayIndex) {
    final habitIndex = _habits.indexWhere((h) => h.id == habitId);
    if (habitIndex != -1) {
      _habits[habitIndex].completionDays[dayIndex] =
          !_habits[habitIndex].completionDays[dayIndex];
      notifyListeners();
    }
  }

  void setMood(int moodIndex) {
    _currentMood = moodIndex;
    notifyListeners();
  }

  void updateSleepHours(int hours) {
    _sleepHours = hours.clamp(0, 24);
    notifyListeners();
  }
}

// ==================== MAIN APP ====================
class PrinceLifeTrackerApp extends StatelessWidget {
  const PrinceLifeTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (_) => HabitTrackerProvider(),
      child: MaterialApp(
        title: '${UserConfig.nickname}\'s Lifestyle Matrix',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF0A0E27),
          primaryColor: const Color(0xFF00D4FF),
        ),
        home: const DashboardScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
}

// ==================== MAIN DASHBOARD SCREEN ====================
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController _gridScrollController = ScrollController();

  @override
  void dispose() {
    _gridScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Profile
              const PremiumHeader(),
              const SizedBox(height: 24),

              // Top Stats Section
              const TopStatsSection(),
              const SizedBox(height: 32),

              // Daily Performance Chart
              const DailyPerformanceChart(),
              const SizedBox(height: 32),

              // Master Habit Grid
              MasterHabitGrid(scrollController: _gridScrollController),
              const SizedBox(height: 32),

              // Analysis Table
              const HabitAnalysisTable(),
              const SizedBox(height: 32),

              // Wellness Tracker
              const WellnessTracker(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
}

// ==================== PREMIUM HEADER ====================
class PremiumHeader extends StatelessWidget {
  const PremiumHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
      children: [
        // Profile Avatar
        CircleAvatar(
          radius: 40,
          backgroundColor: const Color(0xFF1a1f3a),
          child: ClipOval(
            child: Image.asset(
              UserConfig.profileImagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00D4FF),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      UserConfig.nickname[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A0E27),
                      ),
                    ),
                  ),
                ),
            ),
          ),
        ),
        const SizedBox(width: 20),

        // Profile Info
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${UserConfig.nickname}\'s Lifestyle Matrix',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF00D4FF),
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 6),
              Text(
                '${UserConfig.fullName} • Premium Workspace',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFFB0B5C8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'March 2026 • Tracking Period',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF7A7F8F),
                ),
              ),
            ],
          ),
        ),
      ],
    );
}

// ==================== TOP STATS SECTION ====================
class TopStatsSection extends StatelessWidget {
  const TopStatsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<HabitTrackerProvider>(
      builder: (context, provider, _) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Panel: Circular Progress Indicator
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF15192D),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF2A3150),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      '${UserConfig.nickname}\'s Overall Stats',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFB0B5C8),
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 160,
                      width: 160,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Background Circle
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF2A3150),
                                width: 2,
                              ),
                            ),
                          ),
                          // Progress Circle
                          SizedBox.expand(
                            child: CircularProgressIndicator(
                              value:
                                  provider.overallCompletionPercentage / 100,
                              strokeWidth: 8,
                              backgroundColor: const Color(0xFF2A3150),
                              valueColor:
                                  const AlwaysStoppedAnimation<Color>(
                                Color(0xFF00D4FF),
                              ),
                            ),
                          ),
                          // Center Text
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${provider.overallCompletionPercentage.toStringAsFixed(0)}%',
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF00D4FF),
                                ),
                              ),
                              const Text(
                                'Completion',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF7A7F8F),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),

            // Right Panel: Numeric Breakdown
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF15192D),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF2A3150),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${UserConfig.nickname}\'s Progress Breakdown',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFB0B5C8),
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _StatisticRow(
                      label: 'Total Goal',
                      value: '${provider.totalPossibleChecks}',
                      color: const Color(0xFF7A7F8F),
                    ),
                    const SizedBox(height: 16),
                    _StatisticRow(
                      label: 'Completed',
                      value: '${provider.totalCompletedChecks}',
                      color: const Color(0xFF00D4FF),
                    ),
                    const SizedBox(height: 16),
                    _StatisticRow(
                      label: 'Remaining',
                      value: '${provider.remainingChecks}',
                      color: const Color(0xFFFF6B6B),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
}

class _StatisticRow extends StatelessWidget {

  const _StatisticRow({
    required this.label,
    required this.value,
    required this.color,
    Key? key,
  }) : super(key: key);
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFFB0B5C8),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ],
    );
}

// ==================== DAILY PERFORMANCE CHART ====================
class DailyPerformanceChart extends StatelessWidget {
  const DailyPerformanceChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<HabitTrackerProvider>(
      builder: (context, provider, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${UserConfig.nickname}\'s Daily Performance',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
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
              child: SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 31,
                  itemBuilder: (context, index) {
                    final percentage =
                        provider.getDayCompletionPercentage(index);
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Bar
                          Container(
                            width: 28,
                            height: 120 * (percentage / 100),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Color(0xFF00D4FF),
                                  Color(0xFF0099CC),
                                ],
                              ),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Day Label
                          Text(
                            'D${index + 1}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFF7A7F8F),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
    );
}

// ==================== MASTER HABIT GRID ====================
class MasterHabitGrid extends StatelessWidget {

  const MasterHabitGrid({
    required this.scrollController,
    Key? key,
  }) : super(key: key);
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) => Consumer<HabitTrackerProvider>(
      builder: (context, provider, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${UserConfig.nickname}\'s Habit Tracker',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF15192D),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF2A3150),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  // Left Column: Habit Names (Sticky)
                  Container(
                    width: 180,
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Color(0xFF2A3150),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFF2A3150),
                                width: 1,
                              ),
                            ),
                          ),
                          child: const Text(
                            'Habits',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFB0B5C8),
                            ),
                          ),
                        ),
                        ...provider.habits.map(
                          (habit) => Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xFF2A3150),
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  habit.emoji,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    habit.name,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFE0E3F0),
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Right Section: Calendar Grid (Scrollable)
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: scrollController,
                      child: Column(
                        children: [
                          // Header Row with Day Labels
                          Container(
                            height: 60,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xFF2A3150),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Row(
                              children: List.generate(
                                31,
                                (dayIndex) => _DayHeader(dayIndex: dayIndex),
                              ),
                            ),
                          ),

                          // Habit Rows
                          ...provider.habits.map(
                            (habit) => Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xFF2A3150),
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: List.generate(
                                  31,
                                  (dayIndex) => _HabitCheckbox(
                                    habitId: habit.id,
                                    dayIndex: dayIndex,
                                    isChecked:
                                        habit.completionDays[dayIndex],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
}

class _DayHeader extends StatelessWidget {

  const _DayHeader({required this.dayIndex, Key? key}) : super(key: key);
  final int dayIndex;

  @override
  Widget build(BuildContext context) {
    const dayNames = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
    final dayName = dayNames[dayIndex % 7];
    final dayNumber = dayIndex + 1;

    return Container(
      width: 44,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Color(0xFF2A3150),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dayName,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFF00D4FF),
            ),
          ),
          Text(
            dayNumber.toString(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFFE0E3F0),
            ),
          ),
        ],
      ),
    );
  }
}

class _HabitCheckbox extends StatelessWidget {

  const _HabitCheckbox({
    required this.habitId,
    required this.dayIndex,
    required this.isChecked,
    Key? key,
  }) : super(key: key);
  final String habitId;
  final int dayIndex;
  final bool isChecked;

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () {
        context.read<HabitTrackerProvider>().toggleHabitDay(habitId, dayIndex);
      },
      child: Container(
        width: 44,
        height: 48,
        decoration: BoxDecoration(
          border: const Border(
            right: BorderSide(
              color: Color(0xFF2A3150),
              width: 0.5,
            ),
          ),
          color: isChecked ? Color.fromRGBO(0, 212, 255, 0.1) : null,
        ),
        child: Center(
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              border: Border.all(
                color: isChecked
                    ? const Color(0xFF00D4FF)
                    : const Color(0xFF4A5070),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4),
              color: isChecked ? const Color(0xFF00D4FF) : null,
            ),
            child: isChecked
                ? const Center(
                    child: Icon(
                      Icons.check,
                      size: 14,
                      color: Color(0xFF0A0E27),
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
}

// ==================== HABIT ANALYSIS TABLE ====================
class HabitAnalysisTable extends StatelessWidget {
  const HabitAnalysisTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<HabitTrackerProvider>(
      builder: (context, provider, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Habit Efficiency Analysis for ${UserConfig.nickname}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF15192D),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF2A3150),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  // Header Row
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFF2A3150),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: const [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Habit',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFB0B5C8),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Goal',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFB0B5C8),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Actual',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFB0B5C8),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Left',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFB0B5C8),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Progress',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFB0B5C8),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Data Rows
                  ...provider.habits.map(
                    (habit) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFF2A3150),
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          // Habit Name
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${habit.emoji} ${habit.name}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFE0E3F0),
                              ),
                            ),
                          ),

                          // Goal
                          Expanded(
                            flex: 1,
                            child: Text(
                              '31',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF7A7F8F),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          // Actual
                          Expanded(
                            flex: 1,
                            child: Text(
                              '${habit.completedCount}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF00D4FF),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          // Left
                          Expanded(
                            flex: 1,
                            child: Text(
                              '${habit.remainingCount}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFF6B6B),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          // Progress Bar
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2A3150),
                                        borderRadius:
                                            BorderRadius.circular(3),
                                      ),
                                      child: Stack(
                                        children: [
                                          FractionallySizedBox(
                                            widthFactor:
                                                habit.progressPercentage / 100,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                gradient:
                                                    const LinearGradient(
                                                  colors: [
                                                    Color(0xFF00D4FF),
                                                    Color(0xFF0099CC),
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  SizedBox(
                                    width: 35,
                                    child: Text(
                                      '${habit.progressPercentage.toStringAsFixed(0)}%',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF00D4FF),
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
}

// ==================== WELLNESS TRACKER ====================
class WellnessTracker extends StatelessWidget {
  const WellnessTracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const moodEmojis = ['😢', '😐', '🙂', '😀', '🤩'];

    return Consumer<HabitTrackerProvider>(
      builder: (context, provider, _) => Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF15192D),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF2A3150),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '${UserConfig.nickname}\'s Wellness Tracker',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),

              // Mood Tracker
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How are you feeling today?',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFB0B5C8),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      5,
                      (index) => GestureDetector(
                        onTap: () => provider.setMood(index),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: provider.currentMood == index
                              ? Color.fromRGBO(0, 212, 255, 0.2)
                              : const Color(0xFF0A0E27),
                            border: Border.all(
                              color: provider.currentMood == index
                                  ? const Color(0xFF00D4FF)
                                  : const Color(0xFF2A3150),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              moodEmojis[index],
                              style: const TextStyle(fontSize: 28),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Sleep Log
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hours of Sleep',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFB0B5C8),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            provider.updateSleepHours(provider.sleepHours - 1),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0A0E27),
                            border: Border.all(
                              color: const Color(0xFF2A3150),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.remove,
                              color: Color(0xFF00D4FF),
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0A0E27),
                            border: Border.all(
                              color: const Color(0xFF2A3150),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '${provider.sleepHours}',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF00D4FF),
                                ),
                              ),
                              const Text(
                                'hours',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF7A7F8F),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () =>
                            provider.updateSleepHours(provider.sleepHours + 1),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0A0E27),
                            border: Border.all(
                              color: const Color(0xFF2A3150),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              color: Color(0xFF00D4FF),
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}
