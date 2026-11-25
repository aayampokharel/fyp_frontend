import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/color_constants.dart';

class LeftSideBarWidget extends StatelessWidget {
  const LeftSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo area
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: ColorConstants.primaryBlue,
                  child: const Icon(Icons.security, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Admin Panel',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Nav items (static - no navigation)
            _navItem(Icons.dashboard_rounded, 'Dashboard', true),
            _navItem(Icons.verified_outlined, 'Certificates', false),
            _navItem(Icons.school_outlined, 'Institutions', false),
            _navItem(Icons.analytics_outlined, 'Analytics', false),
            _navItem(Icons.settings_outlined, 'Settings', false),

            const Spacer(),

            // User info at bottom of sidebar
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.black12,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Mycoder',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Admin',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _navItem(IconData icon, String title, bool selected) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        Icon(
          icon,
          color: selected ? ColorConstants.primaryBlue : Colors.black54,
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            color: selected ? ColorConstants.primaryBlue : Colors.black54,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
