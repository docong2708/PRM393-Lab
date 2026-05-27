import 'package:flutter/material.dart';

class ScaffoldThemeDemo extends StatelessWidget {
  const ScaffoldThemeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 4 - Scaffold & Theme'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
            tooltip: 'More',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Scaffold Structure',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          const Text(
            'MaterialApp defines the shared ThemeData. Scaffold provides AppBar, body, and FAB slots.',
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.palette_outlined,
                    color: colorScheme.primary,
                    size: 40,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Material 3 Theme',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Colors come from colorSchemeSeed in main.dart.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Dark mode is represented as fixed UI because the lab is Stateless.
          Card(
            child: SwitchListTile(
              value: false,
              onChanged: (_) {},
              title: const Text('Dark Mode'),
              subtitle: const Text('UI mock only: themeMode is not updated.'),
              secondary: const Icon(Icons.dark_mode_outlined),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Action'),
      ),
    );
  }
}
