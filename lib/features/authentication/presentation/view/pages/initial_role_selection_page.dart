import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/color_constants.dart';
import 'package:flutter_dashboard/features/authentication/presentation/view/pages/admin_log_in.dart';
import 'package:flutter_dashboard/features/authentication/presentation/view/pages/institution_selection_page.dart';
import 'package:flutter_dashboard/features/authentication/presentation/view/pages/sign_in_institution_page.dart';
import 'package:flutter_dashboard/features/authentication/presentation/view/pages/sign_in_user_account_page.dart';

class InitialRoleSelectionPage extends StatelessWidget {
  const InitialRoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          width: 1200,
          height: 650,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2),
            ],
          ),
          child: Row(
            children: [
              // === Admin Section ===
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Admin Icon
                    Icon(
                      Icons.admin_panel_settings, // Suitable admin icon
                      size: 180,
                      color: ColorConstants.yellowGold,
                    ),
                    const SizedBox(height: 20),
                    // Admin Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminLoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.darkBrown,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Admin',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: 2,
                margin: const EdgeInsets.symmetric(vertical: 40),
                color: Colors.grey[300],
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.school,
                      size: 180,
                      color: ColorConstants.yellowGold,
                    ),
                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignInPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: ColorConstants.darkBrown,
                      ),
                      child: const Text(
                        'Institution',
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorConstants.white,
                        ),
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
  }
}
