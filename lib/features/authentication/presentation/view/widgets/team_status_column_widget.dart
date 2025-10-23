import 'package:flutter/material.dart';

class TeamStatusColumnWidget extends StatelessWidget {
  const TeamStatusColumnWidget({super.key});

  final List<Map<String, String>> _team = const [
    {'name': 'John Doe', 'title': 'CEO', 'status': 'online'},
    {'name': 'John Doe', 'title': 'CEO', 'status': 'busy'},
    {'name': 'John Doe', 'title': 'CEO', 'status': 'offline'},
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Team Status',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Column(
          children: _team.map((member) {
            return Column(
              children: [
                Row(
                  children: [
                    // small avatar and status dot
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.black12,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: member['status'] == 'online'
                                  ? Colors.green
                                  : (member['status'] == 'busy'
                                        ? Colors.red
                                        : Colors.orange),
                              border: Border.all(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            member['name']!,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            member['title']!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
