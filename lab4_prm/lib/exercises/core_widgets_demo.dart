import 'package:flutter/material.dart';

class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 1 - Core Widgets')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Headline Text introduces the screen content.
            Text(
              'Core Flutter Widgets',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'A simple composition using Text, Icon, Image, Card, and ListTile.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),

            // Material Icons work automatically when uses-material-design is true.
            Row(
              children: [
                Icon(Icons.star_outline, color: colorScheme.primary, size: 36),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Material Icons make actions and concepts easy to scan.',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Image.network loads an online image without adding local assets.
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://picsum.photos/seed/flutter-lab-4/900/420',
                height: 190,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Card visually groups related information.
            Card(
              elevation: 1,
              child: ListTile(
                leading: Icon(
                  Icons.school_outlined,
                  color: colorScheme.primary,
                ),
                title: const Text('Flutter UI Fundamentals'),
                subtitle: const Text(
                  'ListTile gives a consistent layout for icon, title, subtitle, and action.',
                ),
                trailing: const Icon(Icons.check_circle_outline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
