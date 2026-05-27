import 'package:flutter/material.dart';

class InputControlsDemo extends StatelessWidget {
  const InputControlsDemo({super.key});

  static const double _sampleSliderValue = 0.65;
  static const bool _sampleSwitchValue = true;
  static const int _sampleRadioValue = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 2 - Input Widgets')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Input Controls Demo',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          const Text(
            'This lab uses fixed values because every screen is a StatelessWidget.',
          ),
          const SizedBox(height: 16),

          // Slider is enabled with an empty callback, but the value is fixed.
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Volume: 65%'),
                  Slider(
                    value: _sampleSliderValue,
                    onChanged: (_) {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Switch displays a sample on/off state without updating state.
          Card(
            child: SwitchListTile(
              value: _sampleSwitchValue,
              onChanged: (_) {},
              title: const Text('Notifications'),
              subtitle: const Text('Sample value: enabled'),
              secondary: const Icon(Icons.notifications_active_outlined),
            ),
          ),
          const SizedBox(height: 12),

          // RadioListTile uses a fixed groupValue to show the selected option.
          Card(
            child: Column(
              children: [
                RadioListTile<int>(
                  value: 1,
                  // ignore: deprecated_member_use
                  groupValue: _sampleRadioValue,
                  // ignore: deprecated_member_use
                  onChanged: (_) {},
                  title: const Text('Beginner'),
                ),
                RadioListTile<int>(
                  value: 2,
                  // ignore: deprecated_member_use
                  groupValue: _sampleRadioValue,
                  // ignore: deprecated_member_use
                  onChanged: (_) {},
                  title: const Text('Intermediate'),
                ),
                RadioListTile<int>(
                  value: 3,
                  // ignore: deprecated_member_use
                  groupValue: _sampleRadioValue,
                  // ignore: deprecated_member_use
                  onChanged: (_) {},
                  title: const Text('Advanced'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Selected date sample: 27/05/2026'),
                  const SizedBox(height: 12),
                  // showDatePicker is called from a valid BuildContext.
                  ElevatedButton.icon(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime(2026, 5, 27),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                    },
                    icon: const Icon(Icons.calendar_month_outlined),
                    label: const Text('Open Date Picker'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
