import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_dashboard/core/constants/color_constants.dart";
import "package:flutter_dashboard/core/constants/dependency_injection/di.dart";
import "package:flutter_dashboard/core/constants/enum.dart";
import "package:flutter_dashboard/core/constants/image_constants.dart";
import "package:flutter_dashboard/core/constants/string_constants.dart";
import "package:flutter_dashboard/features/authentication/domain/use_case/user_account_usecase.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/pages/sign_in_faculty.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/colored_button_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/container_with_two_parts_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/nav_bar_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/text_field_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/upload_image_with_removed_bg.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_bloc.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_event.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_state.dart";

class SignInUserAccountPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController institutionLogoBase64Controller =
      TextEditingController();

  final UserAccountUseCase userAccountUseCase = getIt<UserAccountUseCase>();
  final String institutionID;

  SignInUserAccountPage({super.key, required this.institutionID});

  void _handleSignIn(BuildContext context) {
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;
    final String institutionRole = roleController.text;
    final String institutionLogoBase64 = institutionLogoBase64Controller.text;

    // TODO: Add validation for password match, email format, etc.

    context.read<AuthenticationBloc>().add(
      CreateUserAccountEvent(
        email: email,
        password: password,
        institutionID: institutionID,
        institutionLogoBase64: institutionLogoBase64,
        institutionRole: institutionRole,
        systemRole: systemRoletoString(SystemRole.institute),
      ),
    );
  }

  void _handleFileSelection() {
    // TODO: Implement file selection for institution logo
    // Convert image to base64 and store it
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: NavBarWidget(
          icon1: const Icon(Icons.person, color: Colors.white),
          icon2: const Icon(Icons.logout, color: Colors.white),
          onPressedIcon1: () {},
          onPressedIcon2: () {},
          companyName: StringConstants.companyName,
        ),
      ),
      body: Center(
        child: ContainerWithTwoParts(
          height: 800,
          width: 800,
          imagePath: ImageConstants.natureImage,
          companyLogo: ImageConstants.logoImage,
          companyName: StringConstants.companyName,
          taskName: "Sign In",
          taskDescription: "Please sign in to continue",
          isDataRightSided: true,
          inputChild: Column(
            children: [
              // Email Field
              TextFieldWidget(
                containerSize: 350,
                textController: emailController,
                labelText: "Email",
                hintText: "Enter your email",
              ),

              // Password Field
              TextFieldWidget(
                containerSize: 350,
                textController: passwordController,
                labelText: "Password",
                hintText: "Enter your password",
                // obscureText: true,
              ),

              // Confirm Password Field
              TextFieldWidget(
                containerSize: 350,
                textController: confirmPasswordController,
                labelText: "Confirm Password",
                hintText: "Confirm your password",
                // obscureText: true,
              ),

              // Role Field
              TextFieldWidget(
                containerSize: 350,
                textController: roleController,
                labelText: "Role",
                hintText: "Enter your role at your institution",
              ),

              // Institution Logo File Selection
              UploadImageWithRemovedBg(
                labelName: "Select Your Institution Logo",
                controller: institutionLogoBase64Controller,
              ),

              const SizedBox(height: 20),

              // Sign In Button
              ColoredButtonWidget(
                onPressed: () => _handleSignIn(context),
                width: 300,
                textColor: Colors.white,
                height: 50,
                color: ColorConstants.accentPurple,
                text: "Sign In",
              ),

              // Bloc Consumer for State Management
              _buildBlocConsumer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlocConsumer() {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is UserAccountSuccessState) {
          _handleAuthenticationSuccess(context, state.userAccountEntity.id);
        }
      },
      builder: (context, state) {
        return _buildStateWidget(state);
      },
    );
  }

  void _handleAuthenticationSuccess(
    BuildContext context,
    String userAccountID,
  ) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignInFacultyPage(
          institutionID: institutionID,
          userAccountID: userAccountID,
        ),
      ),
    );
  }

  Widget _buildStateWidget(AuthenticationState state) {
    if (state is AuthenticationInitialState) {
      return const SizedBox.shrink();
    } else if (state is AuthenticationErrorState) {
      return Text(
        'ERROR: ${state.displayErrorString} code: ${state.code.toString()}',
      );
    } else if (state is AuthenticationLoadingState) {
      return const CircularProgressIndicator();
    } else if (state is UserAccountSuccessState) {
      return Text(
        "Success: ${state.userAccountEntity.email} ${state.userAccountEntity.institutionRole} ${state.userAccountEntity.systemRole}",
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
