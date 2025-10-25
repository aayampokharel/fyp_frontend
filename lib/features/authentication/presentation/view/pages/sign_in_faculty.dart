import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_dashboard/core/constants/color_constants.dart";
import "package:flutter_dashboard/core/constants/dependency_injection/di.dart";
import "package:flutter_dashboard/core/constants/enum.dart";
import "package:flutter_dashboard/core/constants/image_constants.dart";
import "package:flutter_dashboard/core/constants/string_constants.dart";
import "package:flutter_dashboard/features/authentication/domain/entity/faculty_entity.dart";
import "package:flutter_dashboard/features/authentication/domain/use_case/user_account_usecase.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/colored_button_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/container_with_two_parts_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/nav_bar_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/text_field_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_bloc.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_event.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_state.dart";

class SignInFacultyPage extends StatelessWidget {
  final TextEditingController facultyController = TextEditingController();
  final TextEditingController principalNameController = TextEditingController();
  //principalSignaturebase64
  //HODSignaturebase64
  final TextEditingController facultyHODNameController =
      TextEditingController();
  final TextEditingController universityAffilicationController =
      TextEditingController();
  final TextEditingController universityCodeController =
      TextEditingController();

  final UserAccountUseCase userAccountUseCase = getIt<UserAccountUseCase>();
  final String institutionID;
  final String userAccountID;

  SignInFacultyPage({
    super.key,
    required this.institutionID,
    required this.userAccountID,
  });

  void _handleSignIn(BuildContext context) {
    final String facultyHODName = facultyHODNameController.text;
    final String universityAffiliation = universityAffilicationController.text;
    final String universityCode = universityCodeController.text;
    final String faculty = facultyController.text;
    final String principalName = principalNameController.text;
    final String principalSignatureBase64 = "";
    final String hodSignatureBase64 = "";

    context.read<AuthenticationBloc>().add(
      CreateFacultyEvent(
        institutionID: institutionID,
        faculty: faculty,
        principalName: principalName,
        principalSignatureBase64: principalSignatureBase64,
        facultyHodName: facultyHODName,
        universityAffiliation: universityAffiliation,
        universityCollegeCode: universityCode,
        facultyHodSignatureBase64: hodSignatureBase64,
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
          rightSideChild: Column(
            children: [
              // Email Field
              TextFieldWidget(
                containerSize: 350,
                textController: facultyController,
                labelText: "Faculty Name",
                hintText: "Enter your Faculty name",
              ),
              TextFieldWidget(
                containerSize: 350,
                textController: principalNameController,
                labelText: "faculty Principal Name",
                hintText: "Enter faculty Principal name",
              ),

              // Password Field
              TextFieldWidget(
                containerSize: 350,
                textController: universityAffilicationController,
                labelText: "University Affiliation",
                hintText: "Enter your affiliated University",
                // obscureText: true,
              ),

              // Confirm Password Field
              TextFieldWidget(
                containerSize: 350,
                textController: universityCodeController,
                labelText: "university code",
                hintText: "university code",
                // obscureText: true,
              ),

              // Institution Logo File Selection
              ColoredButtonWidget(
                onPressed: _handleFileSelection,
                width: 300,
                textColor: Colors.white,
                height: 50,
                color: ColorConstants.accentPurple,
                text: "Select Institution Logo",
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
        if (state is FacultySuccessState) {
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
