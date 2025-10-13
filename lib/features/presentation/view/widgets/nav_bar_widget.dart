import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/color_constants.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Recent Workflow Runs',
          style: TextStyle(
            color: ColorConstants.primaryPurple,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Monitor your workflow executions and performance',
          style: TextStyle(color: Colors.black54),
        ),
        const Spacer(),
        // Filter button and View All button (static)
        _glassButtonRow(),
      ],
    );
  }
}

Widget _glassButtonRow() {
  return Row(
    children: [
      // Filter button
      ElevatedButton.icon(
        onPressed: null,
        icon: const Icon(Icons.filter_list),
        label: const Text('Filter'),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.primaryPurple.withOpacity(0.1),
          foregroundColor: ColorConstants.primaryPurple,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      const SizedBox(width: 12),
      // View All button - primary
      ElevatedButton.icon(
        onPressed: null,
        icon: const Icon(Icons.remove_red_eye_outlined),
        label: const Text('View All'),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.primaryPurple,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ],
  );
}
