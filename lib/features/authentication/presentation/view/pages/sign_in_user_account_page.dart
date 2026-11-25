// import "package:flutter/material.dart";
// import "package:flutter_bloc/flutter_bloc.dart";
// import "package:flutter_dashboard/core/constants/color_constants.dart";
// import "package:flutter_dashboard/core/constants/dependency_injection/di.dart";
// import "package:flutter_dashboard/core/constants/enum.dart";
// import "package:flutter_dashboard/core/constants/image_constants.dart";
// import "package:flutter_dashboard/core/constants/string_constants.dart";
// import "package:flutter_dashboard/features/authentication/domain/use_case/user_account_usecase.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view/pages/sign_in_faculty.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view/widgets/colored_button_widget.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view/widgets/container_with_two_parts_widget.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view/widgets/nav_bar_widget.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view/widgets/custom_text_field_widget.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view/widgets/upload_image_with_removed_bg.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_bloc.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_event.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_state.dart";

// class SignInUserAccountPage extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();
//   final TextEditingController roleController = TextEditingController();
//   final TextEditingController institutionLogoBase64Controller =
//       TextEditingController();

//   final UserAccountUseCase userAccountUseCase = getIt<UserAccountUseCase>();
//   final String institutionID;

//   SignInUserAccountPage({super.key, required this.institutionID});

//   void _handleSignIn(BuildContext context) {
//     final String email = emailController.text;
//     final String password = passwordController.text;
//     final String confirmPassword = confirmPasswordController.text;
//     final String institutionRole = roleController.text;
//     final String institutionLogoBase64 = institutionLogoBase64Controller.text;

//     // TODO: Add validation for password match, email format, etc.

//     context.read<AuthenticationBloc>().add(
//       CreateUserAccountEvent(
//         email: email,
//         password: password,
//         institutionID: institutionID,
//         institutionLogoBase64: institutionLogoBase64,
//         institutionRole: institutionRole,
//         systemRole: systemRoletoString(SystemRole.institute),
//       ),
//     );
//   }

//   void _handleFileSelection() {
//     // TODO: Implement file selection for institution logo
//     // Convert image to base64 and store it
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: NavBarWidget(
//           icon1: const Icon(Icons.person, color: Colors.white),
//           icon2: const Icon(Icons.logout, color: Colors.white),
//           onPressedIcon1: () {},
//           onPressedIcon2: () {},
//           companyName: StringConstants.companyName,
//         ),
//       ),
//       body: Center(
//         child: ContainerWithTwoParts(
//           height: 800,
//           width: 800,
//           imagePath: ImageConstants.natureImage,
//           companyLogo: ImageConstants.logoImage,
//           companyName: StringConstants.companyName,
//           taskName: "Sign In",
//           taskDescription: "Please sign in to continue",
//           isDataRightSided: true,
//           inputChild: Column(
//             children: [
//               // Email Field
//               CustomTextFieldWidget(
//                 controller: emailController,
//                 label: "Email",
//                 icon: Icons.email_outlined,
//               ),

//               // Password Field
//               CustomTextFieldWidget(
//                 controller: passwordController,
//                 label: "Password",
//                 icon: Icons.lock_outline,
//                 // obscureText: true,
//               ),

//               // Confirm Password Field
//               CustomTextFieldWidget(
//                 controller: confirmPasswordController,
//                 label: "Confirm Password",
//                 icon: Icons.lock_outline,
//                 // obscureText: true,
//               ),

//               // Role Field
//               CustomTextFieldWidget(
//                 controller: roleController,
//                 label: "Institution Role",
//                 icon: Icons.manage_accounts_sharp,
//               ),

//               // Institution Logo File Selection
//               UploadImageWithRemovedBg(
//                 labelName: "Select Your Institution Logo",
//                 controller: institutionLogoBase64Controller,
//               ),

//               const SizedBox(height: 20),

//               // Sign In Button
//               ColoredButtonWidget(
//                 onPressed: () => _handleSignIn(context),
//                 width: 300,
//                 textColor: Colors.white,
//                 height: 50,
//                 color: ColorConstants.accentPurple,
//                 text: "Sign In",
//               ),

//               // Bloc Consumer for State Management
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
//         if (state is UserAccountSuccessState) {
//           _handleAuthenticationSuccess(context, state.userAccountEntity.id);
//         }
//       },
//       builder: (context, state) {
//         return _buildStateWidget(state);
//       },
//     );
//   }

//   void _handleAuthenticationSuccess(
//     BuildContext context,
//     String userAccountID,
//   ) {
//     Navigator.pop(context);
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => SignInFacultyPage(
//           institutionID: institutionID,
//           userAccountID: userAccountID,
//         ),
//       ),
//     );
//   }

//   Widget _buildStateWidget(AuthenticationState state) {
//     if (state is AuthenticationInitialState) {
//       return const SizedBox.shrink();
//     } else if (state is AuthenticationErrorState) {
//       return Text(
//         'ERROR: ${state.displayErrorString} code: ${state.code.toString()}',
//       );
//     } else if (state is AuthenticationLoadingState) {
//       return const CircularProgressIndicator();
//     } else if (state is UserAccountSuccessState) {
//       return Text(
//         "Success: ${state.userAccountEntity.email} ${state.userAccountEntity.institutionRole} ${state.userAccountEntity.systemRole}",
//       );
//     } else {
//       return const SizedBox.shrink();
//     }
//   }
// }

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_dashboard/core/constants/color_constants.dart";
import "package:flutter_dashboard/core/constants/dependency_injection/di.dart";
import "package:flutter_dashboard/core/constants/enum.dart";
import "package:flutter_dashboard/core/constants/image_constants.dart";
import "package:flutter_dashboard/core/constants/string_constants.dart";
import "package:flutter_dashboard/features/authentication/domain/use_case/user_account_usecase.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/pages/sign_in_faculty.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/custom_text_field_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/upload_image_with_removed_bg.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_bloc.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_event.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_state.dart";

class SignInUserAccountPage extends StatefulWidget {
  final String institutionID;

  const SignInUserAccountPage({super.key, required this.institutionID});

  @override
  State<SignInUserAccountPage> createState() => _SignInUserAccountPageState();
}

class _SignInUserAccountPageState extends State<SignInUserAccountPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController institutionLogoBase64Controller =
      TextEditingController();

  final UserAccountUseCase userAccountUseCase = getIt<UserAccountUseCase>();

  // 🔴 Added validation error holders
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;
  String? roleError;
  String? logoError;

  void _validateAndSubmit(BuildContext context) {
    setState(() {
      emailError = emailController.text.isEmpty
          ? "Email cannot be empty"
          : (!emailController.text.contains('@')
                ? "Invalid email format"
                : null);

      passwordError = passwordController.text.isEmpty
          ? "Password cannot be empty"
          : (passwordController.text.length < 6
                ? "Password must be at least 6 characters"
                : null);

      confirmPasswordError = confirmPasswordController.text.isEmpty
          ? "Please confirm your password"
          : (passwordController.text != confirmPasswordController.text
                ? "Passwords do not match"
                : null);

      roleError = roleController.text.isEmpty
          ? "Institution role is required"
          : null;

      logoError = institutionLogoBase64Controller.text.isEmpty
          ? "Institution logo is required"
          : null;
    });

    if (emailError == null &&
        passwordError == null &&
        confirmPasswordError == null &&
        roleError == null &&
        logoError == null) {
      _handleSignIn(context);
    }
  }

  void _handleSignIn(BuildContext context) {
    final String email = emailController.text;
    final String password = passwordController.text;
    final String institutionRole = roleController.text;
    final String institutionLogoBase64 = institutionLogoBase64Controller.text;

    context.read<AuthenticationBloc>().add(
      CreateUserAccountEvent(
        email: email,
        password: password,
        institutionID: widget.institutionID,
        institutionLogoBase64: institutionLogoBase64,
        institutionRole: institutionRole,
        systemRole: systemRoletoString(SystemRole.institute),
      ),
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
          if (state is UserAccountSuccessState) {
            _handleAuthenticationSuccess(context, state.userAccountEntity.id);
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
                    Text("Registration Failed"),
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
                  // 🌈 Left visual section
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage(
                            ImageConstants.userRegistrationImage,
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
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
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
                                Icons.add_reaction_rounded,
                                size: 60,
                                color: ColorConstants.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            'Register Your User Account',
                            style: TextStyle(
                              fontSize: 32, // Slightly larger
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // White for better contrast
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
                            'Register your user account in DocSniff to link your institution with your account. Once registered, you can easily manage your account and access our services. ',
                            style: TextStyle(
                              fontSize: 17,
                              color: ColorConstants.white.withOpacity(0.9),
                              height: 1.6,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildFeatureItem(
                            Icons.file_copy_outlined,
                            'Upload Multiple Documents',
                          ),
                          _buildFeatureItem(
                            Icons.qr_code_2,
                            'Easy Verification through QR Code',
                          ),
                          _buildFeatureItem(
                            Icons.picture_as_pdf_outlined,
                            'Download Documents as PDF',
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
                        child: Column(
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
                              'User Account Details',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Create your institution administrator account',
                              style: TextStyle(
                                color: ColorConstants.mediumGray,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 30),

                            // Email Field
                            CustomTextFieldWidget(
                              controller: emailController,
                              label: 'Email Address',
                              icon: Icons.email,
                              errorText: emailError,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 20),

                            // Password Field
                            CustomTextFieldWidget(
                              isPassword: true,
                              controller: passwordController,
                              label: 'Password',
                              icon: Icons.lock,
                              errorText: passwordError,
                            ),
                            const SizedBox(height: 20),

                            // Confirm Password Field
                            CustomTextFieldWidget(
                              controller: confirmPasswordController,
                              label: 'Confirm Password',
                              icon: Icons.lock_reset,
                              errorText: confirmPasswordError,
                              isPassword: true,
                            ),
                            const SizedBox(height: 20),

                            // Role Field
                            CustomTextFieldWidget(
                              controller: roleController,
                              label: 'Institution Role',
                              icon: Icons.manage_accounts,
                              errorText: roleError,
                            ),
                            const SizedBox(height: 20),

                            // Institution Logo
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Institution Logo",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.textDark,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                UploadImageWithRemovedBg(
                                  labelName: "Select Your Institution Logo",
                                  controller: institutionLogoBase64Controller,
                                ),
                                if (logoError != null) ...[
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.error_outline,
                                        color: Colors.redAccent,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        logoError!,
                                        style: const TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),

                            const SizedBox(height: 40),

                            // 🎯 Create Account Button
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
                                        'Create User Account',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
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

  void _handleAuthenticationSuccess(
    BuildContext context,
    String userAccountID,
  ) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SignInFacultyPage(
          institutionID: widget.institutionID,
          userAccountID: userAccountID,
        ),
      ),
    );
  }
}
