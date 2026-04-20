import 'package:flutter/material.dart';

void main() {
  runApp(const StudentAttendanceApp());
}

class StudentAttendanceApp extends StatelessWidget {
  const StudentAttendanceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Attendance Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.light,
      home: const MainNavigationScreen(),
    );
  }
}

// Student Model
class Student {
  final int rollNumber;
  final String name;
  bool isPresent;

  Student({
    required this.rollNumber,
    required this.name,
    this.isPresent = false,
  });
}

// Main Navigation Screen
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late List<Student> students;
  late AnimationController _fabAnimationController;

  @override
  void initState() {
    super.initState();
    _initializeStudents();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _initializeStudents() {
    students = [
      Student(rollNumber: 1, name: 'Aarav Sharma', isPresent: false),
      Student(rollNumber: 2, name: 'Bhavna Gupta', isPresent: false),
      Student(rollNumber: 3, name: 'Charu Singh', isPresent: false),
      Student(rollNumber: 4, name: 'Devendra Patel', isPresent: false),
      Student(rollNumber: 5, name: 'Esha Verma', isPresent: false),
      Student(rollNumber: 6, name: 'Farhan Ahmed', isPresent: false),
      Student(rollNumber: 7, name: 'Gita Nair', isPresent: false),
      Student(rollNumber: 8, name: 'Harjot Kaur', isPresent: false),
      Student(rollNumber: 9, name: 'Ishan Roy', isPresent: false),
      Student(rollNumber: 10, name: 'Jiya Desai', isPresent: false),
      Student(rollNumber: 11, name: 'Kavya Reddy', isPresent: false),
      Student(rollNumber: 12, name: 'Laxmi Rao', isPresent: false),
      Student(rollNumber: 13, name: 'Mohit Kumar', isPresent: false),
      Student(rollNumber: 14, name: 'Neha Singh', isPresent: false),
      Student(rollNumber: 15, name: 'Ojaswi Mishra', isPresent: false),
      Student(rollNumber: 16, name: 'Priya Kapoor', isPresent: false),
      Student(rollNumber: 17, name: 'Qasim Khan', isPresent: false),
      Student(rollNumber: 18, name: 'Ravi Tiwari', isPresent: false),
      Student(rollNumber: 19, name: 'Sonali Joshi', isPresent: false),
      Student(rollNumber: 20, name: 'Tanvi Malhotra', isPresent: false),
    ];
  }

  void _onNavigation(int index) {
    setState(() => _selectedIndex = index);
    _fabAnimationController.forward().then((_) {
      _fabAnimationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(students: students, onStudentUpdate: () => setState(() {})),
      AttendanceScreen(
        students: students,
        onAttendanceUpdate: () => setState(() {}),
      ),
      SummaryScreen(students: students),
    ];

    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: screens[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onNavigation,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_rounded),
              label: 'Attendance',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded),
              label: 'Summary',
            ),
          ],
        ),
      ),
    );
  }
}

// Home Screen
class HomeScreen extends StatefulWidget {
  final List<Student> students;
  final VoidCallback onStudentUpdate;

  const HomeScreen({
    Key? key,
    required this.students,
    required this.onStudentUpdate,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _headerAnimationController;
  late List<AnimationController> _itemAnimationControllers;

  @override
  void initState() {
    super.initState();
    _headerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _itemAnimationControllers = List.generate(
      widget.students.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      ),
    );
    _startAnimations();
  }

  void _startAnimations() {
    _headerAnimationController.forward();
    for (int i = 0; i < _itemAnimationControllers.length; i++) {
      Future.delayed(Duration(milliseconds: 100 * (i + 1)), () {
        if (mounted) {
          _itemAnimationControllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    for (var controller in _itemAnimationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final present = widget.students.where((s) => s.isPresent).length;
    final absent = widget.students.length - present;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.indigo.shade50,
            Colors.blue.shade50,
            Colors.purple.shade50,
          ],
        ),
      ),
      child: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            expandedHeight: 220,
            flexibleSpace: FlexibleSpaceBar(
              background: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-0.5, -0.5),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _headerAnimationController,
                    curve: Curves.easeOutCubic,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Attendance Manager',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Track student presence with ease',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.indigo.shade600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Quick Stats
                      Row(
                        children: [
                          _StatChip(
                            label: 'Present',
                            count: present,
                            color: Colors.green,
                            icon: Icons.check_circle,
                          ),
                          const SizedBox(width: 12),
                          _StatChip(
                            label: 'Absent',
                            count: absent,
                            color: Colors.red,
                            icon: Icons.cancel,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Student List
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ScaleTransition(
                    scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                      CurvedAnimation(
                        parent: _itemAnimationControllers[index],
                        curve: Curves.easeOutCubic,
                      ),
                    ),
                    child: _StudentCard(
                      student: widget.students[index],
                      onToggle: () {
                        setState(() {
                          widget.students[index].isPresent =
                              !widget.students[index].isPresent;
                        });
                        widget.onStudentUpdate();
                      },
                      index: index,
                    ),
                  );
                },
                childCount: widget.students.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Student Card Widget with Improved Formatting
class _StudentCard extends StatefulWidget {
  final Student student;
  final VoidCallback onToggle;
  final int index;

  const _StudentCard({
    Key? key,
    required this.student,
    required this.onToggle,
    required this.index,
  }) : super(key: key);

  @override
  State<_StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<_StudentCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _tapAnimationController;

  @override
  void initState() {
    super.initState();
    _tapAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tapAnimationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    _tapAnimationController.forward().then((_) {
      _tapAnimationController.reverse();
    });
    widget.onToggle();
  }

  @override
  Widget build(BuildContext context) {
    final isPresent = widget.student.isPresent;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: _handleTap,
        child: ScaleTransition(
          scale: Tween<double>(begin: 1.0, end: 0.98).animate(
            CurvedAnimation(
              parent: _tapAnimationController,
              curve: Curves.easeInOut,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: isPresent
                      ? Colors.green.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: isPresent
                      ? Colors.green.withOpacity(0.3)
                      : Colors.red.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: isPresent
                        ? [Colors.green.shade50, Colors.teal.shade50]
                        : [Colors.red.shade50, Colors.orange.shade50],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Roll Number Circle
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: isPresent
                              ? [Colors.green.shade400, Colors.teal.shade400]
                              : [Colors.red.shade400, Colors.orange.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isPresent
                                ? Colors.green.withOpacity(0.4)
                                : Colors.red.withOpacity(0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          widget.student.rollNumber.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Student Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.student.name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.grey.shade900,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isPresent
                                  ? Colors.green.withOpacity(0.2)
                                  : Colors.red.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isPresent
                                    ? Colors.green.withOpacity(0.4)
                                    : Colors.red.withOpacity(0.4),
                              ),
                            ),
                            child: Text(
                              isPresent ? 'Present' : 'Absent',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: isPresent
                                    ? Colors.green.shade700
                                    : Colors.red.shade700,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Toggle Icon
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Icon(
                        isPresent ? Icons.check_circle : Icons.radio_button_unchecked,
                        key: ValueKey(isPresent),
                        color: isPresent ? Colors.green.shade500 : Colors.grey.shade400,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Stat Chip Widget
class _StatChip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  final IconData icon;

  const _StatChip({
    Key? key,
    required this.label,
    required this.count,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: color.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '$count',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Attendance Screen
class AttendanceScreen extends StatefulWidget {
  final List<Student> students;
  final VoidCallback onAttendanceUpdate;

  const AttendanceScreen({
    Key? key,
    required this.students,
    required this.onAttendanceUpdate,
  }) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Student> get _filteredStudents {
    if (_searchQuery.isEmpty) return widget.students;
    return widget.students
        .where((student) =>
            student.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            student.rollNumber.toString().contains(_searchQuery))
        .toList();
  }

  void _markAllPresent() {
    setState(() {
      for (var student in widget.students) {
        student.isPresent = true;
      }
    });
    widget.onAttendanceUpdate();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All students marked as present'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _markAllAbsent() {
    setState(() {
      for (var student in widget.students) {
        student.isPresent = false;
      }
    });
    widget.onAttendanceUpdate();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All students marked as absent'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.indigo.shade50,
            Colors.purple.shade50,
          ],
        ),
      ),
      child: CustomScrollView(
        slivers: [
          // Header
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: FadeTransition(
              opacity: Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: const Interval(0, 0.5),
                ),
              ),
              child: Text(
                'Mark Attendance',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
                ),
              ),
            ),
          ),
          // Search and Actions
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  // Search Bar
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -0.3),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(0.1, 0.6),
                      ),
                    ),
                    child: TextField(
                      onChanged: (value) => setState(() => _searchQuery = value),
                      decoration: InputDecoration(
                        hintText: 'Search by name or roll number',
                        prefixIcon: const Icon(Icons.search_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Quick Actions
                  Row(
                    children: [
                      Expanded(
                        child: ScaleTransition(
                          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: const Interval(0.2, 0.7),
                            ),
                          ),
                          child: _ActionButton(
                            label: 'All Present',
                            icon: Icons.done_all_rounded,
                            color: Colors.green,
                            onPressed: _markAllPresent,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ScaleTransition(
                          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: const Interval(0.3, 0.8),
                            ),
                          ),
                          child: _ActionButton(
                            label: 'All Absent',
                            icon: Icons.clear_all_rounded,
                            color: Colors.red,
                            onPressed: _markAllAbsent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Student List
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            sliver: _filteredStudents.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          children: [
                            Icon(
                              Icons.person_off_rounded,
                              size: 64,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No students found',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _AttendanceToggleCard(
                            student: _filteredStudents[index],
                            onToggle: () {
                              setState(() {
                                _filteredStudents[index].isPresent =
                                    !_filteredStudents[index].isPresent;
                              });
                              widget.onAttendanceUpdate();
                            },
                          ),
                        );
                      },
                      childCount: _filteredStudents.length,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// Attendance Toggle Card
class _AttendanceToggleCard extends StatefulWidget {
  final Student student;
  final VoidCallback onToggle;

  const _AttendanceToggleCard({
    Key? key,
    required this.student,
    required this.onToggle,
  }) : super(key: key);

  @override
  State<_AttendanceToggleCard> createState() => _AttendanceToggleCardState();
}

class _AttendanceToggleCardState extends State<_AttendanceToggleCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _toggleController;

  @override
  void initState() {
    super.initState();
    _toggleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _toggleController.dispose();
    super.dispose();
  }

  void _handleToggle() {
    _toggleController.forward().then((_) {
      _toggleController.reverse();
    });
    widget.onToggle();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 0.98).animate(
        CurvedAnimation(
          parent: _toggleController,
          curve: Curves.easeInOut,
        ),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: Colors.indigo.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.indigo.shade50.withOpacity(0.5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            title: Text(
              widget.student.name,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              'Roll: ${widget.student.rollNumber}',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
            trailing: GestureDetector(
              onTap: _handleToggle,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return RotationTransition(
                    turns: animation,
                    child: child,
                  );
                },
                child: Switch(
                  key: ValueKey(widget.student.isPresent),
                  value: widget.student.isPresent,
                  onChanged: (_) => _handleToggle(),
                  activeColor: Colors.green,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Action Button Widget
class _ActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _ActionButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handlePressed() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handlePressed,
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 0.95).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.color.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Icon(widget.icon, color: widget.color, size: 24),
              const SizedBox(height: 4),
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.color,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Summary Screen
class SummaryScreen extends StatefulWidget {
  final List<Student> students;

  const SummaryScreen({Key? key, required this.students}) : super(key: key);

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final present = widget.students.where((s) => s.isPresent).length;
    final absent = widget.students.length - present;
    final percentage = widget.students.isEmpty ? 0.0 : (present / widget.students.length) * 100;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.teal.shade50,
            Colors.indigo.shade50,
            Colors.purple.shade50,
          ],
        ),
      ),
      child: CustomScrollView(
        slivers: [
          // Header
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-0.5, 0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: const Interval(0, 0.4),
                ),
              ),
              child: Text(
                'Attendance Summary',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
                ),
              ),
            ),
          ),
          // Summary Cards
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Overall Percentage
                  ScaleTransition(
                    scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(0.1, 0.5),
                      ),
                    ),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Colors.indigo.shade400,
                              Colors.indigo.shade600,
                              Colors.purple.shade600,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.indigo.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Text(
                              'Attendance Rate',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '${percentage.toStringAsFixed(1)}%',
                              style: TextStyle(
                                fontSize: 56,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _ProgressBar(
                              value: percentage / 100,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Statistics Grid
                  Text(
                    'Statistics',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade900,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ScaleTransition(
                          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: const Interval(0.2, 0.6),
                            ),
                          ),
                          child: _SummaryCard(
                            title: 'Present',
                            count: present,
                            color: Colors.green,
                            icon: Icons.person_add_alt_1_rounded,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ScaleTransition(
                          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: const Interval(0.3, 0.7),
                            ),
                          ),
                          child: _SummaryCard(
                            title: 'Absent',
                            count: absent,
                            color: Colors.red,
                            icon: Icons.person_off_rounded,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ScaleTransition(
                          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: const Interval(0.4, 0.8),
                            ),
                          ),
                          child: _SummaryCard(
                            title: 'Total',
                            count: widget.students.length,
                            color: Colors.blue,
                            icon: Icons.people_alt_rounded,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  // Detailed List
                  Text(
                    'Student Details',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade900,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          // Student List
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final student = widget.students[index];
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.5, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: Interval(
                          0.3 + (index * 0.02),
                          0.8 + (index * 0.02),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: student.isPresent
                                ? Colors.green.withOpacity(0.2)
                                : Colors.red.withOpacity(0.2),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: student.isPresent
                                  ? [Colors.green.shade50, Colors.teal.shade50]
                                  : [Colors.red.shade50, Colors.orange.shade50],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(
                              student.isPresent
                                  ? Icons.check_circle_rounded
                                  : Icons.cancel_rounded,
                              color: student.isPresent
                                  ? Colors.green
                                  : Colors.red,
                              size: 28,
                            ),
                            title: Text(
                              '${student.rollNumber}. ${student.name}',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: student.isPresent
                                    ? Colors.green.withOpacity(0.15)
                                    : Colors.red.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                student.isPresent ? 'Present' : 'Absent',
                                style: TextStyle(
                                  color: student.isPresent
                                      ? Colors.green.shade700
                                      : Colors.red.shade700,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: widget.students.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Summary Card Widget
class _SummaryCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final IconData icon;

  const _SummaryCard({
    Key? key,
    required this.title,
    required this.count,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.1),
              color.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1.5,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              '$count',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Progress Bar Widget
class _ProgressBar extends StatelessWidget {
  final double value;
  final Color color;

  const _ProgressBar({
    Key? key,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: LinearProgressIndicator(
        value: value.clamp(0.0, 1.0),
        minHeight: 8,
        backgroundColor: color.withOpacity(0.2),
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}