// import 'package:flutter/material.dart';
// import 'package:flutter_dashboard/core/constants/color_constants.dart';
// import 'package:flutter_dashboard/features/authentication/presentation/view/pages/admin_log_in.dart';
// import 'package:flutter_dashboard/features/authentication/presentation/view/pages/institution_selection_page.dart';
// import 'package:flutter_dashboard/features/authentication/presentation/view/pages/sign_in_institution_page.dart';
// import 'package:flutter_dashboard/features/authentication/presentation/view/pages/sign_in_user_account_page.dart';

// class InitialRoleSelectionPage extends StatelessWidget {
//   const InitialRoleSelectionPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       body: Center(
//         child: Container(
//           width: 1200,
//           height: 650,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2),
//             ],
//           ),
//           child: Row(
//             children: [
//               // === Admin Section ===
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Admin Icon
//                     Icon(
//                       Icons.admin_panel_settings, // Suitable admin icon
//                       size: 180,
//                       color: ColorConstants.yellowGold,
//                     ),
//                     const SizedBox(height: 20),
//                     // Admin Button
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => AdminLoginPage(),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: ColorConstants.darkBrown,
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 30,
//                           vertical: 15,
//                         ),

//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text(
//                         'Admin',
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               Container(
//                 width: 2,
//                 margin: const EdgeInsets.symmetric(vertical: 40),
//                 color: Colors.grey[300],
//               ),

//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.school,
//                       size: 180,
//                       color: ColorConstants.yellowGold,
//                     ),
//                     const SizedBox(height: 20),

//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => SignInPage()),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 30,
//                           vertical: 15,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         backgroundColor: ColorConstants.darkBrown,
//                       ),
//                       child: const Text(
//                         'Institution',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: ColorConstants.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/color_constants.dart';
import 'package:flutter_dashboard/core/constants/image_constants.dart';
import 'package:flutter_dashboard/features/authentication/presentation/view/pages/admin_log_in.dart';
import 'package:flutter_dashboard/features/authentication/presentation/view/pages/sign_in_institution_page.dart';

class InitialRoleSelectionPage extends StatefulWidget {
  const InitialRoleSelectionPage({super.key});

  @override
  State<InitialRoleSelectionPage> createState() =>
      _InitialRoleSelectionPageState();
}

class _InitialRoleSelectionPageState extends State<InitialRoleSelectionPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  int _hoveredIndex = -1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(int index, bool isHovered) {
    setState(() {
      _hoveredIndex = isHovered ? index : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundLight,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Opacity(
                opacity: _fadeAnimation.value,
                child: Container(
                  width: 1200,
                  height: 650,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        ColorConstants.white,
                        ColorConstants.backgroundLight,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      _buildBlockchainPattern(),

                      Positioned(
                        top: 30,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          height: 120,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Blockchain Chain Icon
                                  Image.asset(
                                    ImageConstants.logoImage,
                                    height: 80,
                                    width: 80,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'DocSniff',
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.textDark,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.verified,
                                    color: ColorConstants.highlightOrange,
                                    size: 24,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Blockchain-Powered Certificate Verification',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorConstants.mediumGray,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 120,
                        left: 0,
                        right: 0,
                        bottom: 60,
                        child: Row(
                          children: [
                            // === Admin Section ===
                            _buildRoleSection(
                              index: 0,
                              icon: Icons.admin_panel_settings,
                              title: 'Admin',
                              subtitle:
                                  'System Administrator\nManage institutions & monitor blockchain records',
                              buttonText: 'Access Admin Portal',
                              gradient: const LinearGradient(
                                colors: [Color(0xFF4C7FFF), Color(0xFF8B4DFF)],
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminLoginPage(),
                                  ),
                                );
                              },
                            ),

                            // === Animated Divider ===
                            Container(
                              width: 2,
                              margin: const EdgeInsets.symmetric(vertical: 40),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    ColorConstants.primaryBlue.withOpacity(0.3),
                                    ColorConstants.highlightOrange.withOpacity(
                                      0.3,
                                    ),
                                    ColorConstants.primaryBlue.withOpacity(0.3),
                                  ],
                                ),
                              ),
                            ),

                            // === Institution Section ===
                            _buildRoleSection(
                              index: 1,
                              icon: Icons.school,
                              title: 'Institution',
                              subtitle:
                                  'Educational Institutions\nIssue & manage student certificates',
                              buttonText: 'Access Institution Portal',
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF8C4C), Color(0xFFFF4C4C)],
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignInPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      // Bottom Blockchain Info
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.security,
                                  color: ColorConstants.successGreen,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Powered by Custom Blockchain',
                                  style: TextStyle(
                                    color: ColorConstants.mediumGray,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Secure • Immutable • Verifiable',
                              style: TextStyle(
                                color: ColorConstants.darkGray,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRoleSection({
    required int index,
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
    required Gradient gradient,
    required VoidCallback onPressed,
  }) {
    final isHovered = _hoveredIndex == index;

    return Expanded(
      child: MouseRegion(
        onEnter: (_) => _onHover(index, true),
        onExit: (_) => _onHover(index, false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: isHovered ? ColorConstants.white : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: ColorConstants.primaryBlue.withOpacity(0.1),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
            border: isHovered
                ? Border.all(color: ColorConstants.lightGray, width: 1)
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Icon Container
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: isHovered ? 160 : 140,
                height: isHovered ? 160 : 140,
                decoration: BoxDecoration(
                  gradient: gradient,
                  shape: BoxShape.circle,
                  boxShadow: isHovered
                      ? [
                          BoxShadow(
                            color: gradient.colors.first.withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: gradient.colors.first.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                ),
                child: Icon(
                  icon,
                  size: isHovered ? 80 : 70,
                  color: ColorConstants.white,
                ),
              ),

              const SizedBox(height: 30),

              // Title
              Text(
                title,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.textDark,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: ColorConstants.mediumGray,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 30),

              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  gradient: isHovered
                      ? gradient
                      : LinearGradient(
                          colors: [
                            ColorConstants.darkGray,
                            ColorConstants.textDark,
                          ],
                        ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isHovered
                      ? [
                          BoxShadow(
                            color: gradient.colors.first.withOpacity(0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ]
                      : null,
                ),
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      fontSize: isHovered ? 17 : 16,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.white,
                    ),
                    child: Text(buttonText),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlockchainPattern() {
    return IgnorePointer(
      child: Opacity(
        opacity: 0.03,
        child: CustomPaint(
          size: Size(1200, 650),
          painter: _BlockchainPatternPainter(),
        ),
      ),
    );
  }
}

class _BlockchainPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorConstants.primaryBlue
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const circleRadius = 20.0;
    const spacing = 40.0;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        if (x + spacing < size.width) {
          canvas.drawLine(
            Offset(x + circleRadius, y),
            Offset(x + spacing - circleRadius, y),
            paint,
          );
        }
        if (y + spacing < size.height) {
          canvas.drawLine(
            Offset(x, y + circleRadius),
            Offset(x, y + spacing - circleRadius),
            paint,
          );
        }
        canvas.drawCircle(Offset(x, y), 3, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
