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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: NavBarWidget(
          icon1: Icon(Icons.person, color: Colors.white),
          icon2: Icon(Icons.logout, color: Colors.white),
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
          rightSideChild: Column(
            children: [
              TextFieldWidget(
                containerSize: 350,
                textController: emailController,
                labelText: "email",
                hintText: "Enter your email",
              ),
              TextFieldWidget(
                containerSize: 350,
                textController: passwordController,
                labelText: "Institution Name",
                hintText: "Enter your Institution",
              ),
              ColoredButtonWidget(
                onPressed: () => _handAdminLogIn(context),
                width: 300,
                textColor: Colors.white,
                height: 300,
                color: ColorConstants.accentPurple,
                text: "Sign In",
              ),
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
      return Text(
        'ERROR: ${state.displayErrorString} code: ${state.code.toString()}',
      );
    } else if (state is AuthenticationLoadingState) {
      return const CircularProgressIndicator();
    } else if (state is FacultySuccessState) {
      return Text(
        "Success: ${state.facultyEntity.faculty} ${state.facultyEntity.principalName} ${state.facultyEntity.universityAffiliation} ${state.facultyEntity.universityCollegeCode}",
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
