import 'package:flutter/material.dart';

class TopUniversityTable extends StatelessWidget {
  const TopUniversityTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recent Certificate Activities",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _activityItem(
              icon: Icons.verified,
              color: Colors.blue,
              text: "Certificate issued to John Doe (Harvard)",
              time: "2 hours ago",
            ),
            _activityItem(
              icon: Icons.check_circle,
              color: Colors.green,
              text: "Certificate verified for Jane Smith (MIT)",
              time: "5 hours ago",
            ),
            _activityItem(
              icon: Icons.error_outline,
              color: Colors.orange,
              text: "Certificate revoked for Bob Lee (Oxford)",
              time: "1 day ago",
            ),
          ],
        ),
      ),
    );
  }
}

Widget _activityItem({
  required IconData icon,
  required Color color,
  required String text,
  required String time,
}) {
  return Column(
    children: [
      Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text, style: const TextStyle(fontSize: 15)),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
      const Divider(height: 20),
    ],
  );
}
