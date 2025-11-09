// import "package:flutter/material.dart";
// import "package:flutter_bloc/flutter_bloc.dart";
// import "package:flutter_dashboard/core/constants/color_constants.dart";
// import "package:flutter_dashboard/core/constants/enum.dart";
// import "package:flutter_dashboard/core/constants/image_constants.dart";
// import "package:flutter_dashboard/core/constants/string_constants.dart";
// import "package:flutter_dashboard/core/errors/app_logger.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view/pages/institution_selection_page.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view/widgets/colored_button_widget.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view/widgets/container_with_two_parts_widget.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view/widgets/nav_bar_widget.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view/widgets/custom_text_field_widget.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_bloc.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_event.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_state.dart";
// import "package:flutter_dashboard/features/csv_upload/presentation/view/page/institution_upload_page.dart";

// class LoginPage extends StatelessWidget {
//   SystemRole systemRole = SystemRole.institute;
//   bool isDataRightSided = true;
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   LoginPage({super.key, required this.systemRole});

//   @override
//   Widget build(BuildContext context) {
//     if (systemRole == SystemRole.institute) {
//       isDataRightSided = true;
//     } else {
//       isDataRightSided = false;
//     }
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(kToolbarHeight),
//         child: NavBarWidget(
//           icon1: Icon(Icons.person, color: Colors.white),
//           icon2: Icon(Icons.logout, color: Colors.white),
//           onPressedIcon1: () {},
//           onPressedIcon2: () {},
//           companyName: StringConstants.companyName,
//         ),
//       ),
//       body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
//         listener: (context, state) {
//           // ✅ If login succeeds
//           if (state is InstituteAccountVerificationSuccessState) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => InstitutionSelectionPage(
//                   institutions: state.instituteAccountEntity.institutionList,
//                 ),
//               ),
//             );
//           }

//           // ✅ If login fails
//           if (state is InstituteAccountVerificationFailureState) {
//             ScaffoldMessenger.of(
//               context,
//             ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
//           }
//         },
//         builder: (context, state) {
//           // ✅ Show loading when logging in
//           if (state is AuthenticationLoadingState) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           // ✅ Show failure UI in center if error found
//           if (state is AuthenticationErrorState) {
//             return Center(child: Text(state.displayErrorString));
//           }

//           // ✅ Default Login UI
//           return Center(
//             child: ContainerWithTwoParts(
//               isDataRightSided: isDataRightSided,
//               height: 800,
//               width: 800,
//               imagePath: ImageConstants.natureImage,
//               companyLogo: ImageConstants.logoImage,
//               companyName: StringConstants.companyName,
//               taskName: "Sign In",
//               taskDescription: "Please sign in to continue",
//               inputChild: Column(
//                 children: [
//                   CustomTextFieldWidget(
//                     controller: emailController,
//                     label: "Email",
//                     icon: Icons.email,
//                   ),
//                   CustomTextFieldWidget(
//                     controller: passwordController,
//                     label: "Password",
//                     icon: Icons.lock_outline,
//                   ),
//                   ColoredButtonWidget(
//                     onPressed: () {
//                       if (systemRole == SystemRole.institute) {
//                         context.read<AuthenticationBloc>().add(
//                           InstituteLoginEvent(
//                             email: emailController.text,
//                             password: passwordController.text,
//                           ),
//                         );
//                       } else if (systemRole == SystemRole.admin) {
//                         context.read<AuthenticationBloc>().add(
//                           AdminLoginEvent(
//                             email: emailController.text,
//                             password: passwordController.text,
//                           ),
//                         );
//                       }
//                     },
//                     width: 300,
//                     textColor: Colors.white,
//                     height: 300,
//                     color: ColorConstants.accentPurple,
//                     text: "Sign In",
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_dashboard/core/constants/color_constants.dart";
import "package:flutter_dashboard/core/constants/enum.dart";
import "package:flutter_dashboard/core/constants/image_constants.dart";
import "package:flutter_dashboard/core/constants/string_constants.dart";
import "package:flutter_dashboard/core/errors/app_logger.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/pages/institution_selection_page.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/primary_button_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/custom_text_field_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_bloc.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_event.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_state.dart";
import "package:flutter_dashboard/features/csv_upload/presentation/view/page/institution_upload_page.dart";

class LoginPage extends StatefulWidget {
  final SystemRole systemRole;

  LoginPage({super.key, required this.systemRole});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  String? emailError;
  String? passwordError;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _slideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validateAndSubmit(BuildContext context) {
    setState(() {
      emailError = emailController.text.isEmpty
          ? "Email cannot be empty"
          : null;
      passwordError = passwordController.text.isEmpty
          ? "Password cannot be empty"
          : null;
    });

    if (emailError == null && passwordError == null) {
      if (widget.systemRole == SystemRole.institute) {
        context.read<AuthenticationBloc>().add(
          InstituteLoginEvent(
            email: emailController.text,
            password: passwordController.text,
          ),
        );
      } else if (widget.systemRole == SystemRole.admin) {
        context.read<AuthenticationBloc>().add(
          AdminLoginEvent(
            email: emailController.text,
            password: passwordController.text,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isInstitute = widget.systemRole == SystemRole.institute;

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
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.translate(
              offset: Offset(0, _slideAnimation.value),
              child: Center(
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
                      // 🌈 Left visual section - Dynamic based on role
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isInstitute
                                  ? [
                                      ColorConstants.primaryBlue.withOpacity(
                                        0.8,
                                      ),
                                      ColorConstants.accentPurple.withOpacity(
                                        0.7,
                                      ),
                                    ]
                                  : [
                                      ColorConstants.highlightOrange
                                          .withOpacity(0.8),
                                      ColorConstants.accentPurple.withOpacity(
                                        0.7,
                                      ),
                                    ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Role-specific Icon
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  gradient: isInstitute
                                      ? const LinearGradient(
                                          colors: [
                                            Color(0xFFFF8C4C),
                                            Color(0xFFFF4C4C),
                                          ],
                                        )
                                      : const LinearGradient(
                                          colors: [
                                            Color(0xFF4C7FFF),
                                            Color(0xFF8B4DFF),
                                          ],
                                        ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          (isInstitute
                                                  ? ColorConstants
                                                        .highlightOrange
                                                  : ColorConstants.primaryBlue)
                                              .withOpacity(0.3),
                                      blurRadius: 15,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  isInstitute
                                      ? Icons.school
                                      : Icons.admin_panel_settings,
                                  size: 60,
                                  color: ColorConstants.white,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                isInstitute ? 'Welcome Back!' : 'Admin Portal',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.textDark,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                isInstitute
                                    ? 'Access your institution dashboard to manage certificates and student records securely.'
                                    : 'Administrator access to manage system-wide operations and institutions.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorConstants.mediumGray,
                                  height: 1.6,
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Feature List
                              _buildFeatureItem(
                                Icons.verified,
                                'Blockchain Secured',
                              ),
                              _buildFeatureItem(
                                Icons.security,
                                'Enterprise Grade Security',
                              ),
                              _buildFeatureItem(
                                Icons.dashboard,
                                'Advanced Dashboard',
                              ),
                            ],
                          ),
                        ),
                      ),

                      // 🧾 Right form section
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: SingleChildScrollView(
                            child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                              listener: (context, state) {
                                // ✅ If login succeeds
                                if (state
                                    is InstituteAccountVerificationSuccessState) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => InstitutionSelectionPage(
                                        institutions: state
                                            .instituteAccountEntity
                                            .institutionList,
                                      ),
                                    ),
                                  );
                                }

                                // ✅ If login fails with backend error
                                if (state
                                    is InstituteAccountVerificationFailureState) {
                                  // 💬 Show error popup dialog (similar to SignInPage)
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      title: Row(
                                        children: const [
                                          Icon(
                                            Icons.error,
                                            color: Colors.redAccent,
                                          ),
                                          SizedBox(width: 8),
                                          Text("Login Failed"),
                                        ],
                                      ),
                                      content: Text(state.errorMsg),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text(
                                            "OK",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                // 💬 Handle other authentication errors
                                if (state is AuthenticationErrorState) {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      title: Row(
                                        children: const [
                                          Icon(
                                            Icons.error,
                                            color: Colors.redAccent,
                                          ),
                                          SizedBox(width: 8),
                                          Text("Authentication Error"),
                                        ],
                                      ),
                                      content: Text(
                                        "${state.displayErrorString} (Code: ${state.code})",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text(
                                            "OK",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                    Text(
                                      isInstitute
                                          ? 'Institution Login'
                                          : 'Admin Login',
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Enter your credentials to continue',
                                      style: TextStyle(
                                        color: ColorConstants.mediumGray,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 40),

                                    CustomTextFieldWidget(
                                      controller: emailController,
                                      label: 'Email Address',
                                      icon: Icons.email,
                                      errorText: emailError,
                                    ),
                                    const SizedBox(height: 20),

                                    CustomTextFieldWidget(
                                      controller: passwordController,
                                      label: 'Password',
                                      icon: Icons.lock_outline,
                                      isPassword: true,
                                      errorText: passwordError,
                                    ),

                                    const SizedBox(height: 40),

                                    // 🎯 Login Button with loading state
                                    Center(
                                      child: ElevatedButton(
                                        onPressed:
                                            state is AuthenticationLoadingState
                                            ? null
                                            : () => _validateAndSubmit(context),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorConstants.primaryBlue,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 60,
                                            vertical: 18,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                        child:
                                            state is AuthenticationLoadingState
                                            ? const SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(Colors.white),
                                                ),
                                              )
                                            : Text(
                                                isInstitute
                                                    ? 'Sign In as Institution'
                                                    : 'Sign In as Admin',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                      ),
                                    ),

                                    const SizedBox(height: 30),

                                    // 🔗 Sign Up Redirect for Institution
                                    if (isInstitute)
                                      Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Don't have an account? ",
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                // Navigate to sign up page
                                                // You'll need to add this navigation based on your app structure
                                              },
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Sign Up",
                                                  style: TextStyle(
                                                    color: ColorConstants
                                                        .accentPurple,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    const SizedBox(height: 20),

                                    // 🔒 Security Note
                                    Center(
                                      child: Text(
                                        'Secure access powered by DocSniff',
                                        style: TextStyle(
                                          color: ColorConstants.mediumGray,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: ColorConstants.successGreen, size: 20),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(color: ColorConstants.darkGray, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
