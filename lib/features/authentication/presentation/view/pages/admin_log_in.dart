// import "package:flutter/material.dart";
// import "package:flutter_bloc/flutter_bloc.dart";
// import "package:flutter_dashboard/core/constants/color_constants.dart";
// import "package:flutter_dashboard/core/constants/image_constants.dart";
// import "package:flutter_dashboard/core/constants/string_constants.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view/widgets/colored_button_widget.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view/widgets/container_with_two_parts_widget.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view/widgets/nav_bar_widget.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view/widgets/custom_text_field_widget.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_bloc.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_event.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_state.dart";
// import "package:flutter_dashboard/features/sse/presentation/view/widgets/notification.dart";

// class AdminLoginPage extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   AdminLoginPage({super.key});

//   void _handAdminLogIn(BuildContext context) {
//     final String email = emailController.text;
//     final String password = passwordController.text;

//     context.read<AuthenticationBloc>().add(
//       AdminLoginEvent(email: email, password: password),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorConstants.darkGray,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(70),
//         child: NavBarWidget(
//           icon1: Icon(Icons.person, color: ColorConstants.white, size: 28),
//           icon2: Icon(Icons.logout, color: ColorConstants.white, size: 28),
//           onPressedIcon1: () {},
//           onPressedIcon2: () {},
//           companyName: StringConstants.companyName,
//         ),
//       ),
//       body: Center(
//         child: ContainerWithTwoParts(
//           width: 800,
//           height: 700,
//           imagePath: ImageConstants.natureImage,
//           companyLogo: ImageConstants.logoImage,
//           companyName: StringConstants.companyName,
//           taskName: "Admin Sign In",
//           isDataRightSided: false,
//           taskDescription: "Please enter your credentials to continue",
//           inputChild: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(height: 20),
//               CustomTextFieldWidget(
//                 controller: emailController,
//                 label: "Email",
//                 icon: Icons.email_outlined,
//               ),
//               const SizedBox(height: 20),
//               CustomTextFieldWidget(
//                 controller: emailController,
//                 label: "Password",
//                 icon: Icons.lock_outline_rounded,
//                 // obscureText: true,
//               ),
//               const SizedBox(height: 40),
//               ColoredButtonWidget(
//                 onPressed: () => _handAdminLogIn(context),
//                 width: 300,
//                 height: 55, // realistic button height
//                 color: ColorConstants.accentPurple,
//                 textColor: ColorConstants.white,
//                 text: "Sign In",
//               ),
//               const SizedBox(height: 25),
//               _buildBlocConsumer(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBlocConsumer() {
//     return BlocConsumer<AuthenticationBloc, AuthenticationState>(
//       listener: (context, state) {
//         if (state is AdminAccountVerificationSuccessState) {
//           _handleFacultySignInSuccess(context);
//         }
//       },
//       builder: (context, state) {
//         return _buildStateWidget(state);
//       },
//     );
//   }

//   void _handleFacultySignInSuccess(BuildContext context) {
//     Navigator.pop(context);
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => SseListPage()),
//     );
//   }

//   Widget _buildStateWidget(AuthenticationState state) {
//     if (state is AuthenticationInitialState) {
//       return const SizedBox.shrink();
//     } else if (state is AuthenticationErrorState) {
//       return Padding(
//         padding: const EdgeInsets.only(top: 12.0),
//         child: Text(
//           'ERROR: ${state.displayErrorString} (code: ${state.code})',
//           style: const TextStyle(color: Colors.red, fontSize: 14),
//           textAlign: TextAlign.center,
//         ),
//       );
//     } else if (state is AuthenticationLoadingState) {
//       return const Padding(
//         padding: EdgeInsets.only(top: 12.0),
//         child: CircularProgressIndicator(),
//       );
//     } else if (state is FacultySuccessState) {
//       return Padding(
//         padding: const EdgeInsets.only(top: 12.0),
//         child: Text(
//           "Welcome: ${state.facultyEntity.facultyName}",
//           style: TextStyle(
//             fontSize: 16,
//             color: ColorConstants.darkGray,
//             fontWeight: FontWeight.w600,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       );
//     } else {
//       return const SizedBox.shrink();
//     }
//   }
// }

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_dashboard/core/constants/color_constants.dart";
import "package:flutter_dashboard/core/constants/image_constants.dart";
import "package:flutter_dashboard/core/constants/string_constants.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/nav_bar_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_bloc.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_event.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_state.dart";
import "package:flutter_dashboard/features/sse/presentation/view/widgets/notification.dart";

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // 🔴 Added validation error holders
  String? emailError;
  String? passwordError;

  void _validateAndSubmit(BuildContext context) {
    setState(() {
      emailError = emailController.text.isEmpty
          ? "Email cannot be empty"
          : (!emailController.text.contains('@')
                ? "Invalid email format"
                : null);

      passwordError = passwordController.text.isEmpty
          ? "Password cannot be empty"
          : null;
    });

    if (emailError == null && passwordError == null) {
      _handAdminLogIn(context);
    }
  }

  void _handAdminLogIn(BuildContext context) {
    final String email = emailController.text;
    final String password = passwordController.text;

    context.read<AuthenticationBloc>().add(
      AdminLoginEvent(email: email, password: password),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              shadows: [
                Shadow(
                  blurRadius: 5,
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(1, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? errorText,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: isPassword,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, color: ColorConstants.primaryBlue),
            filled: true,
            fillColor: ColorConstants.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: ColorConstants.lightGray),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: ColorConstants.primaryBlue,
                width: 2,
              ),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.redAccent,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  errorText,
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundLight,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: ColorConstants.primaryBlue,
          title: Text(
            StringConstants.companyName,
            style: const TextStyle(color: Colors.white),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
      ),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AdminAccountVerificationSuccessState) {
            _handleAdminSignInSuccess(context);
          }

          // 💬 Show error popup for backend errors
          if (state is AuthenticationErrorState) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Row(
                  children: const [
                    Icon(Icons.error, color: Colors.redAccent),
                    SizedBox(width: 8),
                    Text("Login Failed"),
                  ],
                ),
                content: Text(
                  "${state.displayErrorString} (Code: ${state.code})",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Container(
              width: 1100,
              height: 700,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // 🧾 Left form section (since isDataRightSided is false)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ImageConstants.logoImage,

                                    height: 120,
                                    width: 120,
                                  ),
                                  Text(
                                    "DocSniff",
                                    style: TextStyle(
                                      color: ColorConstants.primaryBlue,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              'Admin Login',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Access the admin dashboard with your credentials',
                              style: TextStyle(
                                color: ColorConstants.mediumGray,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 40),

                            // Email Field
                            _buildInputField(
                              controller: emailController,
                              label: 'Email Address',
                              icon: Icons.email,
                              errorText: emailError,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 20),

                            // Password Field
                            _buildInputField(
                              controller: passwordController,
                              label: 'Password',
                              icon: Icons.lock,
                              errorText: passwordError,
                              isPassword: true,
                            ),
                            const SizedBox(height: 30),

                            // 🎯 Sign In Button with loading state
                            Center(
                              child: ElevatedButton(
                                onPressed: state is AuthenticationLoadingState
                                    ? null
                                    : () => _validateAndSubmit(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstants.primaryBlue,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 60,
                                    vertical: 18,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: state is AuthenticationLoadingState
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                        ),
                                      )
                                    : const Text(
                                        'Sign In as Admin',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Security Note
                            Center(
                              child: Text(
                                'Secure admin access powered by DocSniff',
                                style: TextStyle(
                                  color: ColorConstants.mediumGray,
                                  fontSize: 12,
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 🌈 Right visual section
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage(
                            ImageConstants.adminDashboardImage,
                          ),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.4),
                            BlendMode.darken,
                          ),
                        ),

                        gradient: LinearGradient(
                          colors: [
                            Colors.blue[900]!.withOpacity(0.85), // Dark blue
                            Colors.purple[900]!.withOpacity(0.8), // Dark purple
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Institution Icon
                          Center(
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFF8C4C),
                                    Color(0xFFFF4C4C),
                                  ],
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorConstants.highlightOrange
                                        .withOpacity(0.3),
                                    blurRadius: 15,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.admin_panel_settings,
                                size: 60,
                                color: ColorConstants.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            'Admin Portal',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Access the centralized admin dashboard to manage system-wide operations, institutions, and monitor platform activities.',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white.withOpacity(0.9),
                              height: 1.7,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 30),
                          // Feature List
                          _buildFeatureItem(
                            Icons.dashboard,
                            'Centralized Dashboard',
                          ),
                          _buildFeatureItem(
                            Icons.supervised_user_circle,
                            'User Management',
                          ),
                          _buildFeatureItem(
                            Icons.analytics,
                            'System Analytics',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleAdminSignInSuccess(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SseListPage()),
    );
  }
}
