import 'package:flutter/material.dart';

import 'exercises/core_widgets_demo.dart';
import 'exercises/debug_fix_common_ui_errors.dart';
import 'exercises/input_controls_demo.dart';
import 'exercises/layout_basics_demo.dart';
import 'exercises/scaffold_theme_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 4 - Flutter UI Fundamentals',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final List<_ExerciseItem> _exercises = [
    _ExerciseItem(
      title: 'Exercise 1 - Core Widgets',
      subtitle: 'Text, Icon, Image, Card, ListTile',
      icon: Icons.widgets_outlined,
      builder: (_) => const CoreWidgetsDemo(),
    ),
    _ExerciseItem(
      title: 'Exercise 2 - Input Widgets',
      subtitle: 'Slider, Switch, Radio, DatePicker',
      icon: Icons.tune_outlined,
      builder: (_) => const InputControlsDemo(),
    ),
    _ExerciseItem(
      title: 'Exercise 3 - Layout Basics',
      subtitle: 'Column, Row, spacing, ListView.builder',
      icon: Icons.view_quilt_outlined,
      builder: (_) => const LayoutBasicsDemo(),
    ),
    _ExerciseItem(
      title: 'Exercise 4 - Scaffold & Theme',
      subtitle: 'AppBar, body, FAB, Material 3 theme',
      icon: Icons.dashboard_customize_outlined,
      builder: (_) => const ScaffoldThemeDemo(),
    ),
    _ExerciseItem(
      title: 'Exercise 5 - Debug UI Errors',
      subtitle: 'Common layout and context fixes',
      icon: Icons.bug_report_outlined,
      builder: (_) => const DebugFixCommonUiErrors(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 4 - UI Fundamentals'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _exercises.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final exercise = _exercises[index];

          // Card + ListTile creates a clear menu item for each lab screen.
          return Card(
            elevation: 1,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              leading: CircleAvatar(
                child: Icon(exercise.icon),
              ),
              title: Text(
                exercise.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(exercise.subtitle),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: exercise.builder),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _ExerciseItem {
  const _ExerciseItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.builder,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final WidgetBuilder builder;
}
