import 'package:flutter/material.dart';

class DebugFixCommonUiErrors extends StatelessWidget {
  const DebugFixCommonUiErrors({super.key});

  static const List<String> _items = [
    'Use Expanded',
    'Give ListView bounded height',
    'Avoid unbounded viewport errors',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 5 - Debug UI Errors')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Debug & Fix Common UI Errors',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          _FixSection(
            icon: Icons.view_list_outlined,
            title: 'Fix ListView inside Column',
            description:
                'When a ListView is placed inside a Column, wrap it with Expanded so Flutter knows its height.',
            child: SizedBox(
              height: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Correct example:'),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          dense: true,
                          leading: const Icon(Icons.check_circle_outline),
                          title: Text(_items[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const _FixSection(
            icon: Icons.swap_vert_outlined,
            title: 'Fix overflow',
            description:
                'If content may be taller than the screen, wrap it with SingleChildScrollView or use ListView as the page body.',
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Long content can scroll instead of causing a yellow/black overflow warning.',
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const _FixSection(
            icon: Icons.sync_problem_outlined,
            title: 'Fix state update issue',
            description:
                'In a StatefulWidget, UI changes should be wrapped in setState. This lab forbids StatefulWidget, so inputs only simulate fixed UI values.',
            child: Text('Sample fixed value: Switch = ON, Slider = 65%.'),
          ),
          const SizedBox(height: 12),
          _FixSection(
            icon: Icons.event_available_outlined,
            title: 'Fix DatePicker context error',
            description:
                'Call showDatePicker from a valid BuildContext inside the widget tree, such as a button onPressed callback.',
            child: Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime(2026, 5, 27),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                },
                icon: const Icon(Icons.calendar_today_outlined),
                label: const Text('Test DatePicker'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FixSection extends StatelessWidget {
  const _FixSection({
    required this.icon,
    required this.title,
    required this.description,
    required this.child,
  });

  final IconData icon;
  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}
