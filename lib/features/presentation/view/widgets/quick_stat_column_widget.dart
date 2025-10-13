import 'package:flutter/material.dart';

Map<String, String> get _stats => {
  'Total Certs': '12,543',
  'Institutions': '256',
  'Verifications': '45,129',
  'Pending': '28',
};

class QuickStatColumnWidget extends StatelessWidget {
  const QuickStatColumnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Stats',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        // grid of small stat tiles
        Column(
          children: _stats.entries.map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(e.key, style: const TextStyle(color: Colors.black54)),
                  Text(
                    e.value,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
