import 'package:flutter/material.dart';

class LayoutBasicsDemo extends StatelessWidget {
  const LayoutBasicsDemo({super.key});

  static const List<String> _movieTitles = [
    'The Flutter Journey',
    'Material Design Begins',
    'Layout Rules',
    'The Widget Tree',
    'Build Method Returns',
    'Debug Paint Adventure',
    'Responsive Rows',
    'ListView Nights',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 3 - Layout Basics')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Layout Basics',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            const Text('Column arranges sections vertically.'),
            const SizedBox(height: 16),

            // Row places compact items horizontally.
            Row(
              children: const [
                _SmallInfoChip(icon: Icons.star_outline, label: 'Rating'),
                SizedBox(width: 8),
                _SmallInfoChip(icon: Icons.timer_outlined, label: 'Runtime'),
                SizedBox(width: 8),
                _SmallInfoChip(icon: Icons.movie_outlined, label: 'Genre'),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Movie List',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),

            // Expanded gives ListView a bounded height inside Column.
            Expanded(
              child: ListView.builder(
                itemCount: _movieTitles.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(_movieTitles[index]),
                      subtitle: const Text('Built with ListView.builder'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SmallInfoChip extends StatelessWidget {
  const _SmallInfoChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon),
            const SizedBox(height: 8),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
