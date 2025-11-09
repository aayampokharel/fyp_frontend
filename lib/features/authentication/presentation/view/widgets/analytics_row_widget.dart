import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/color_constants.dart';
import 'package:flutter_dashboard/features/authentication/presentation/view/widgets/glass_card_widget.dart';

class AnalyticsRowWidget extends StatelessWidget {
  const AnalyticsRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GlassCardWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Certificate Growth',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Monthly certificate issuance (preview)',
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 14),
                // Simple static line-ish "chart" using stacked bars with differing heights
                SizedBox(
                  height: 120,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(12, (i) {
                      final heights = [
                        30,
                        42,
                        55,
                        70,
                        65,
                        90,
                        130,
                        115,
                        95,
                        80,
                        60,
                        45,
                      ];
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Container(
                            height: heights[i].toDouble(),
                            decoration: BoxDecoration(
                              color: i == 6
                                  ? ColorConstants.primaryBlue
                                  : ColorConstants.primaryBlue.withOpacity(
                                      0.18,
                                    ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 8),
                // X axis labels
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Jan',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    Text(
                      'Feb',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    Text(
                      'Mar',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    Text(
                      'Apr',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    Text(
                      'May',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    Text(
                      'Jun',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: GlassCardWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Certificate Types',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Distribution by category',
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 12),
                // Simple donut-like static representation using stacked containers
                Row(
                  children: [
                    // small legend and pseudo donut
                    Column(
                      children: [
                        // pseudo donut using circles
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorConstants.primaryBlue.withOpacity(
                                  0.18,
                                ),
                              ),
                            ),
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorConstants.primaryBlue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    // legend
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(height: 6),
                          Text(
                            'Degree Certificates',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Diploma Certificates',
                            style: TextStyle(color: Colors.black54),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Short Course',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
