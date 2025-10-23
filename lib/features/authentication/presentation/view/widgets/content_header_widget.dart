import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/color_constants.dart';

class ContentHeaderWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String icon1Name;
  final String icon2Name;
  const ContentHeaderWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon1Name,
    required this.icon2Name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: ColorConstants.primaryPurple,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          // 'Monitor your workflow executions and performance',
          subTitle,
          style: TextStyle(color: Colors.black54),
        ),
        const Spacer(),

        _glassButtonRow(icon1Name, icon2Name),
      ],
    );
  }
}

Widget _glassButtonRow(String icon1Name, String icon2Name) {
  return Row(
    children: [
      // Filter button
      ElevatedButton.icon(
        onPressed: null,
        icon: const Icon(Icons.filter_list),
        // label: const Text('Filter'),
        label: Text(icon1Name),
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
        // label: const Text('View All'),
        label: Text(icon2Name),
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
