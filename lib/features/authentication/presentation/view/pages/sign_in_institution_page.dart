// import "package:flutter/material.dart";
// import "package:flutter_bloc/flutter_bloc.dart";
// import "package:flutter_dashboard/core/constants/color_constants.dart";
// import "package:flutter_dashboard/core/constants/dependency_injection/di.dart";
// import "package:flutter_dashboard/core/constants/enum.dart";
// import "package:flutter_dashboard/core/constants/image_constants.dart";
// import "package:flutter_dashboard/core/constants/string_constants.dart";
// import "package:flutter_dashboard/features/authentication/domain/use_case/institution_usecase.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view/pages/log_in_page.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view/pages/sign_in_user_account_page.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view/widgets/colored_button_widget.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view/widgets/container_with_two_parts_widget.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view/widgets/nav_bar_widget.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view/widgets/text_field_widget.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_bloc.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_event.dart";
// import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_state.dart";

// class SignInPage extends StatelessWidget {
//   final TextEditingController institutionNameController =
//       TextEditingController();
//   final TextEditingController institutionWardNoController =
//       TextEditingController();
//   final TextEditingController institutionToleNoController =
//       TextEditingController();
//   final TextEditingController institutionDistrictController =
//       TextEditingController();

//   final InstitutionUseCase institutionUseCase = getIt<InstitutionUseCase>();

//   SignInPage({super.key});

//   @override
//   Widget build(BuildContext context) {
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
//               TextFieldWidget(
//                 containerSize: 350,
//                 textController: institutionNameController,
//                 labelText: "institutionname",
//                 hintText: "Enter your email",
//               ),
//               TextFieldWidget(
//                 containerSize: 350,
//                 textController: institutionWardNoController,
//                 labelText: "institution wardno",
//                 hintText: "Enter your Institution",
//               ),
//               TextFieldWidget(
//                 containerSize: 350,
//                 textController: institutionDistrictController,
//                 labelText: "institution district",
//                 hintText: "Enter your Institution",
//               ),

//               TextFieldWidget(
//                 containerSize: 350,
//                 textController: institutionToleNoController,
//                 labelText: "institution tole",
//                 hintText: "Enter your Institution",
//               ),
//               ColoredButtonWidget(
//                 onPressed: () {
//                   String institutionName = institutionNameController.text;
//                   int wardNumber = int.parse(institutionWardNoController.text);
//                   String toleAddress = institutionToleNoController.text;
//                   String districtAddress = institutionDistrictController.text;

//                   context.read<AuthenticationBloc>().add(
//                     CreateInstitutionUserEvent(
//                       institutionName: institutionName,
//                       wardNumber: wardNumber,
//                       toleAddress: toleAddress,
//                       districtAddress: districtAddress,
//                     ),
//                   );
//                 },
//                 width: 300,
//                 textColor: Colors.white,
//                 height: 300,
//                 color: ColorConstants.accentPurple,
//                 text: "Sign In",
//               ),
//               BlocConsumer<AuthenticationBloc, AuthenticationState>(
//                 listener: (context, state) {
//                   if (state is AuthenticationSuccessState) {
//                     Navigator.pop(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => SignInUserAccountPage(
//                           institutionID: state.institutionEntity.institutionID,
//                         ),
//                       ),
//                     );
//                   }
//                 },
//                 builder: (context, state) {
//                   if (state is AuthenticationInitialState) {
//                     return const Text("");
//                   } else if (state is AuthenticationErrorState) {
//                     return Text(
//                       state.displayErrorString + state.code.toString(),
//                     );
//                   } else if (state is AuthenticationLoadingState) {
//                     return const CircularProgressIndicator();
//                   } else {
//                     return const SizedBox.shrink();
//                   }
//                 },
//               ),
//               SizedBox(height: 20),

//               BlocConsumer<AuthenticationBloc, AuthenticationState>(
//                 listener: (context, state) {
//                   if (state is AuthenticationSuccessState) {
//                     Navigator.pop(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => SignInUserAccountPage(
//                           institutionID: state.institutionEntity.institutionID,
//                         ),
//                       ),
//                     );
//                   }
//                 },
//                 builder: (context, state) {
//                   if (state is AuthenticationInitialState) {
//                     return const Text("");
//                   } else if (state is AuthenticationErrorState) {
//                     return Text(
//                       state.displayErrorString + state.code.toString(),
//                       style: TextStyle(color: Colors.red),
//                     );
//                   } else if (state is AuthenticationLoadingState) {
//                     return const CircularProgressIndicator();
//                   } else {
//                     return const SizedBox.shrink();
//                   }
//                 },
//               ),

//               SizedBox(height: 30),

//               // ✅ Add this section:
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Already have an account? "),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => LoginPage(
//                             systemRole: SystemRole.institute,
//                           ), // navigate to LoginPage
//                         ),
//                       );
//                     },
//                     child: Text(
//                       "Log In",
//                       style: TextStyle(
//                         color: ColorConstants.accentPurple,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_dashboard/core/constants/color_constants.dart";
import "package:flutter_dashboard/core/constants/dependency_injection/di.dart";
import "package:flutter_dashboard/core/constants/enum.dart";
import "package:flutter_dashboard/core/constants/image_constants.dart";
import "package:flutter_dashboard/core/constants/string_constants.dart";
import "package:flutter_dashboard/features/authentication/domain/use_case/institution_usecase.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/pages/log_in_page.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/pages/sign_in_user_account_page.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_bloc.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_event.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_state.dart";

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController institutionNameController =
      TextEditingController();
  final TextEditingController institutionWardNoController =
      TextEditingController();
  final TextEditingController institutionToleNoController =
      TextEditingController();
  final TextEditingController institutionDistrictController =
      TextEditingController();

  final InstitutionUseCase institutionUseCase = getIt<InstitutionUseCase>();

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  // 🔴 Added validation error holders
  String? nameError;
  String? wardError;
  String? districtError;
  String? toleError;

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
      nameError = institutionNameController.text.isEmpty
          ? "Institution name cannot be empty"
          : null;
      wardError = institutionWardNoController.text.isEmpty
          ? "Ward number is required"
          : null;
      districtError = institutionDistrictController.text.isEmpty
          ? "District field is required"
          : null;
      toleError = institutionToleNoController.text.isEmpty
          ? "Tole address is required"
          : null;
    });

    if (nameError == null &&
        wardError == null &&
        districtError == null &&
        toleError == null) {
      String institutionName = institutionNameController.text;
      int wardNumber = int.parse(institutionWardNoController.text);
      String toleAddress = institutionToleNoController.text;
      String districtAddress = institutionDistrictController.text;

      context.read<AuthenticationBloc>().add(
        CreateInstitutionUserEvent(
          institutionName: institutionName,
          wardNumber: wardNumber,
          toleAddress: toleAddress,
          districtAddress: districtAddress,
        ),
      );
    }
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
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: const AssetImage(
                                ImageConstants.institutionRegistrationImage,
                              ),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.4),
                                BlendMode.darken,
                              ),
                            ),

                            gradient: LinearGradient(
                              colors: [
                                Colors.blue[900]!.withOpacity(
                                  0.85,
                                ), // Dark blue
                                Colors.purple[900]!.withOpacity(
                                  0.8,
                                ), // Dark purple
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
                                    Icons.school,
                                    size: 60,
                                    color: ColorConstants.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                'Register Your Institution',
                                style: TextStyle(
                                  fontSize: 32, // Slightly larger
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Colors.white, // White for better contrast
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
                                'Join DocSniff to issue blockchain-verified certificates for your students. Secure, immutable, and easily verifiable credentials.',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: ColorConstants.white.withOpacity(0.9),
                                  height: 1.6,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Feature List
                              _buildFeatureItem(
                                Icons.verified_user,
                                'Blockchain Verified',
                              ),
                              _buildFeatureItem(
                                Icons.security,
                                'Secure & Immutable',
                              ),
                              _buildFeatureItem(
                                Icons.visibility,
                                'Easy Verification',
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
                            child:
                                BlocConsumer<
                                  AuthenticationBloc,
                                  AuthenticationState
                                >(
                                  listener: (context, state) {
                                    if (state is AuthenticationErrorState) {
                                      // 💬 Show error popup dialog
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          title: Row(
                                            children: const [
                                              Icon(
                                                Icons.error,
                                                color: Colors.redAccent,
                                              ),
                                              SizedBox(width: 8),
                                              Text("Registration Failed"),
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
                                    } else if (state
                                        is AuthenticationSuccessState) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => SignInUserAccountPage(
                                            institutionID: state
                                                .institutionEntity
                                                .institutionID,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                  color: ColorConstants
                                                      .primaryBlue,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        const Text(
                                          'Institution Details',
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 25),

                                        // 🏫 Institution Name
                                        _buildInputField(
                                          controller: institutionNameController,
                                          label: 'Institution Name',
                                          icon: Icons.school,
                                          errorText: nameError,
                                        ),
                                        const SizedBox(height: 20),

                                        // 🔢 Ward Number
                                        _buildInputField(
                                          controller:
                                              institutionWardNoController,
                                          label: 'Ward Number',
                                          icon: Icons.numbers,
                                          keyboardType: TextInputType.number,
                                          errorText: wardError,
                                        ),
                                        const SizedBox(height: 20),

                                        // 🏙 District
                                        _buildInputField(
                                          controller:
                                              institutionDistrictController,
                                          label: 'District',
                                          icon: Icons.location_city,
                                          errorText: districtError,
                                        ),
                                        const SizedBox(height: 20),

                                        // 📍 Tole
                                        _buildInputField(
                                          controller:
                                              institutionToleNoController,
                                          label: 'Tole Address',
                                          icon: Icons.location_on,
                                          errorText: toleError,
                                        ),

                                        const SizedBox(height: 40),

                                        // 🎯 Register Button
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () =>
                                                _validateAndSubmit(context),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  ColorConstants.primaryBlue,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 60,
                                                    vertical: 18,
                                                  ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: const Text(
                                              'Register Institution',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 30),

                                        if (state is AuthenticationLoadingState)
                                          const Center(
                                            child: CircularProgressIndicator(),
                                          ),

                                        const SizedBox(height: 20),

                                        // 🔗 Login Redirect
                                        Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                "Already have an account? ",
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) => LoginPage(
                                                        systemRole: SystemRole
                                                            .institute,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  "Log In",
                                                  style: TextStyle(
                                                    color: ColorConstants
                                                        .accentPurple,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
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

  // Updated _buildFeatureItem method
  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12), // Increased padding
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1), // Semi-transparent white
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Colors.green, // White icons
              size: 22,
            ),
          ),
          const SizedBox(width: 16), // Increased spacing
          Text(
            text,
            style: TextStyle(
              color: Colors.white, // White text
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
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          keyboardType: keyboardType,
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
}
