import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_dashboard/core/constants/color_constants.dart";
import "package:flutter_dashboard/core/constants/image_constants.dart";
import "package:flutter_dashboard/core/constants/string_constants.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/pages/institution_selection_page.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/colored_button_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/container_with_two_parts_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/nav_bar_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/text_field_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_bloc.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_event.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_state.dart";
import "package:flutter_dashboard/features/csv_upload/presentation/view/page/institution_upload_page.dart";

class LoginPage extends StatelessWidget {
  final systemRole = "INSTITUTE";
  final TextEditingController emailController = TextEditingController();
  final TextEditingController institutionController = TextEditingController();
  LoginPage({super.key});

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
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          // ✅ If login succeeds
          if (state is InstituteAccountVerificationSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => InstitutionSelectionPage(
                  institutions: state
                      .instituteAccountEntity
                      .institutionList, // <-- full list
                ),
              ),
            );
          }

          // ✅ If login fails
          if (state is InstituteAccountVerificationFailureState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
          }
        },
        builder: (context, state) {
          // ✅ Show loading when logging in
          if (state is AuthenticationLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          // ✅ Show failure UI in center if error found
          if (state is AuthenticationErrorState) {
            return Center(child: Text(state.displayErrorString));
          }

          // ✅ Default Login UI
          return Center(
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
                    textController: institutionController,
                    labelText: "Institution Name",
                    hintText: "Enter your Institution",
                  ),
                  ColoredButtonWidget(
                    onPressed: () {
                      if (systemRole == "INSTITUTE") {
                        context.read<AuthenticationBloc>().add(
                          InstituteLoginEvent(
                            email: emailController.text,
                            password: institutionController.text,
                          ),
                        );
                      } else if (systemRole == "ADMIN") {
                        context.read<AuthenticationBloc>().add(
                          AdminLoginEvent(
                            email: emailController.text,
                            password: institutionController.text,
                          ),
                        );
                      }
                    },
                    width: 300,
                    textColor: Colors.white,
                    height: 300,
                    color: ColorConstants.accentPurple,
                    text: "Sign In",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
