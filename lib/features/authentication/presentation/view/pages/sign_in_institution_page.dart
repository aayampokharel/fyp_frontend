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
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/colored_button_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/container_with_two_parts_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/nav_bar_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/text_field_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_bloc.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_event.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_state.dart";

class SignInPage extends StatelessWidget {
  final TextEditingController institutionNameController =
      TextEditingController();
  final TextEditingController institutionWardNoController =
      TextEditingController();
  final TextEditingController institutionToleNoController =
      TextEditingController();
  final TextEditingController institutionDistrictController =
      TextEditingController();

  final InstitutionUseCase institutionUseCase = getIt<InstitutionUseCase>();

  SignInPage({super.key});

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
          isDataRightSided: true,

          inputChild: Column(
            children: [
              TextFieldWidget(
                containerSize: 350,
                textController: institutionNameController,
                labelText: "institutionname",
                hintText: "Enter your email",
              ),
              TextFieldWidget(
                containerSize: 350,
                textController: institutionWardNoController,
                labelText: "institution wardno",
                hintText: "Enter your Institution",
              ),
              TextFieldWidget(
                containerSize: 350,
                textController: institutionDistrictController,
                labelText: "institution district",
                hintText: "Enter your Institution",
              ),

              TextFieldWidget(
                containerSize: 350,
                textController: institutionToleNoController,
                labelText: "institution tole",
                hintText: "Enter your Institution",
              ),
              ColoredButtonWidget(
                onPressed: () {
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
                },
                width: 300,
                textColor: Colors.white,
                height: 300,
                color: ColorConstants.accentPurple,
                text: "Sign In",
              ),
              BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is AuthenticationSuccessState) {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SignInUserAccountPage(
                          institutionID: state.institutionEntity.institutionID,
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthenticationInitialState) {
                    return const Text("");
                  } else if (state is AuthenticationErrorState) {
                    return Text(
                      state.displayErrorString + state.code.toString(),
                    );
                  } else if (state is AuthenticationLoadingState) {
                    return const CircularProgressIndicator();
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              SizedBox(height: 20),

              BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is AuthenticationSuccessState) {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SignInUserAccountPage(
                          institutionID: state.institutionEntity.institutionID,
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthenticationInitialState) {
                    return const Text("");
                  } else if (state is AuthenticationErrorState) {
                    return Text(
                      state.displayErrorString + state.code.toString(),
                      style: TextStyle(color: Colors.red),
                    );
                  } else if (state is AuthenticationLoadingState) {
                    return const CircularProgressIndicator();
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),

              SizedBox(height: 30),

              // ✅ Add this section:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginPage(
                            systemRole: SystemRole.institute,
                          ), // navigate to LoginPage
                        ),
                      );
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        color: ColorConstants.accentPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
