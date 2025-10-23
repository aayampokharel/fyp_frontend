import 'package:flutter/material.dart';

class ContainerWithTwoParts extends StatelessWidget {
  final double height;
  final double width;
  final String imagePath;
  final String companyLogo;
  final String companyName;
  final String taskName;
  final String taskDescription;
  final Widget rightSideChild;

  const ContainerWithTwoParts({
    super.key,
    required this.height,
    required this.width,
    required this.imagePath,
    required this.companyLogo,
    required this.companyName,
    required this.taskName,
    required this.taskDescription,
    required this.rightSideChild,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Row(
        children: [
          // LEFT SIDE
          Expanded(
            child: Stack(
              children: [
                // Background image
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Foreground content
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(companyLogo),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        companyName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        taskName,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      Text(
                        taskDescription,
                        style: const TextStyle(color: Colors.white60),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // RIGHT SIDE
          Expanded(child: rightSideChild),
        ],
      ),
    );
  }
}
