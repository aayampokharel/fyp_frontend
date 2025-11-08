import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_dashboard/core/constants/color_constants.dart";
import "package:flutter_dashboard/core/constants/image_constants.dart";
import "package:flutter_dashboard/core/constants/string_constants.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/colored_button_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/container_with_two_parts_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/nav_bar_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/text_field_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_bloc.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_event.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_state.dart";
import "package:flutter_dashboard/features/sse/presentation/view/widgets/notification.dart";

class AdminLoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AdminLoginPage({super.key});

  void _handAdminLogIn(BuildContext context) {
    final String email = emailController.text;
    final String password = passwordController.text;

    context.read<AuthenticationBloc>().add(
      AdminLoginEvent(email: email, password: password),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.extraLightGray,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: NavBarWidget(
          icon1: Icon(Icons.person, color: ColorConstants.white, size: 28),
          icon2: Icon(Icons.logout, color: ColorConstants.white, size: 28),
          onPressedIcon1: () {},
          onPressedIcon2: () {},
          companyName: StringConstants.companyName,
        ),
      ),
      body: Center(
        child: ContainerWithTwoParts(
          width: 800,
          height: 700, // Increased height for proper spacing
          imagePath: ImageConstants.natureImage,
          companyLogo: ImageConstants.logoImage,
          companyName: StringConstants.companyName,
          taskName: "Admin Sign In",
          isDataRightSided: false,
          taskDescription: "Please enter your credentials to continue",
          inputChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              TextFieldWidget(
                containerSize: 400,
                textController: emailController,
                labelText: "Email",
                hintText: "Enter your email",
              ),
              const SizedBox(height: 20),
              TextFieldWidget(
                containerSize: 400,
                textController: passwordController,
                labelText: "Password",
                hintText: "Enter your password",
                // obscureText: true,
              ),
              const SizedBox(height: 40),
              ColoredButtonWidget(
                onPressed: () => _handAdminLogIn(context),
                width: 300,
                height: 55, // realistic button height
                color: ColorConstants.accentPurple,
                textColor: ColorConstants.white,
                text: "Sign In",
              ),
              const SizedBox(height: 25),
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
        if (state is AdminAccountVerificationSuccessState) {
          _handleFacultySignInSuccess(context);
        }
      },
      builder: (context, state) {
        return _buildStateWidget(state);
      },
    );
  }

  void _handleFacultySignInSuccess(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SseListPage()),
    );
  }

  Widget _buildStateWidget(AuthenticationState state) {
    if (state is AuthenticationInitialState) {
      return const SizedBox.shrink();
    } else if (state is AuthenticationErrorState) {
      return Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Text(
          'ERROR: ${state.displayErrorString} (code: ${state.code})',
          style: const TextStyle(color: Colors.red, fontSize: 14),
          textAlign: TextAlign.center,
        ),
      );
    } else if (state is AuthenticationLoadingState) {
      return const Padding(
        padding: EdgeInsets.only(top: 12.0),
        child: CircularProgressIndicator(),
      );
    } else if (state is FacultySuccessState) {
      return Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Text(
          "Welcome: ${state.facultyEntity.facultyName}",
          style: TextStyle(
            fontSize: 16,
            color: ColorConstants.darkBrown,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
