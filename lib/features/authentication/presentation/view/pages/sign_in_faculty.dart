import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_dashboard/core/constants/color_constants.dart";
import "package:flutter_dashboard/core/constants/dependency_injection/di.dart";
import "package:flutter_dashboard/core/constants/image_constants.dart";
import "package:flutter_dashboard/core/constants/string_constants.dart";
import "package:flutter_dashboard/core/errors/app_logger.dart";
import "package:flutter_dashboard/features/authentication/domain/entity/authority_entity.dart";
import "package:flutter_dashboard/features/authentication/domain/entity/faculty_entity.dart";
import "package:flutter_dashboard/features/authentication/domain/use_case/user_account_usecase.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/colored_button_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/container_with_two_parts_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/nav_bar_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/text_field_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/upload_image_with_removed_bg.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_bloc.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_event.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_state.dart";
import "package:flutter_dashboard/features/csv_upload/presentation/view/page/institution_upload_page.dart";

class SignInFacultyPage extends StatefulWidget {
  final String institutionID;
  final String userAccountID;

  SignInFacultyPage({
    super.key,
    required this.institutionID,
    required this.userAccountID,
  });

  @override
  State<SignInFacultyPage> createState() => _SignInFacultyPageState();
}

class _SignInFacultyPageState extends State<SignInFacultyPage> {
  final TextEditingController facultyController = TextEditingController();

  final TextEditingController authorityNameController = TextEditingController();

  final TextEditingController authoritySignatureController =
      TextEditingController();

  final TextEditingController universityAffilicationController =
      TextEditingController();

  final TextEditingController universityCodeController =
      TextEditingController();

  List<AuthorityEntity> addedAuthorities = [];

  final UserAccountUseCase userAccountUseCase = getIt<UserAccountUseCase>();

  void _handleSignIn(BuildContext context) {
    //! here is to be updated .
    // final String facultyHODName = facultyHODNameController.text;
    final String universityAffiliation = universityAffilicationController.text;
    final String universityCode = universityCodeController.text;
    final String faculty = facultyController.text;
    final List<Map<String, String>> authorityWithSignatures = addedAuthorities
        .map((e) => e.toJSON())
        .toList();
    // final String principalName = principalNameController.text;

    AppLogger.info("faculty::: " + faculty);
    context.read<AuthenticationBloc>().add(
      CreateFacultyEvent(
        institutionID: widget.institutionID,
        faculty: faculty,
        facultyAuthorityWithSignatures: authorityWithSignatures,
        universityAffiliation: universityAffiliation,
        universityCollegeCode: universityCode,
      ),
    );
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
          isDataRightSided: true,
          imagePath: ImageConstants.natureImage,
          companyLogo: ImageConstants.logoImage,
          companyName: StringConstants.companyName,
          taskName: "Sign In",
          taskDescription: "Please sign in to continue",
          inputChild: Column(
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
                textController: universityAffilicationController,
                labelText: "University Affiliation",
                hintText: "Enter your affiliated University",
                // !obscureText: true,
              ),

              TextFieldWidget(
                containerSize: 350,
                textController: universityCodeController,
                labelText: "university code",
                hintText: "university code",
                // obscureText: true,
              ),

              // Institution Logo File Selection
              addAuthoritiesWithSignature(
                context,
                addedAuthorities,
                authorityNameController,
                authoritySignatureController,
              ),

              Container(
                color: Colors.white30,
                height: 200,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: addedAuthorities.length,
                  itemBuilder: (context, index) {
                    final authority = addedAuthorities[index];
                    return ListTile(
                      title: Text(authority.authorityName),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            addedAuthorities.remove(authority);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              ColoredButtonWidget(
                onPressed: () => _handleSignIn(context),
                width: 300,
                textColor: Colors.white,
                height: 50,
                color: ColorConstants.accentPurple,
                text: "Sign In",
              ),

              _buildBlocConsumer(widget.institutionID),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlocConsumer(String institutionID) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is FacultySuccessState) {
          _handleFacultySignInSuccess(
            context,
            institutionID,
            state.facultyEntity,
          );
        }
      },
      builder: (context, state) {
        return _buildStateWidget(state);
      },
    );
  }

  void _handleFacultySignInSuccess(
    BuildContext context,
    String institutionID,
    FacultyEntity facultyEntity,
  ) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            InstitutionCsvUploadPage(institutionID: institutionID),
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
    } else if (state is FacultySuccessState) {
      return Text(
        "Success: ${state.facultyEntity.facultyName} ${state.facultyEntity.facultyAuthorityWithSignatures} ${state.facultyEntity.universityAffiliation} ${state.facultyEntity.universityCollegeCode}",
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget addAuthoritiesWithSignature(
    BuildContext context,
    List<AuthorityEntity> authorities,
    TextEditingController authorityNameController,
    TextEditingController authoritySignatureController,
  ) {
    return ElevatedButton(
      onPressed: () => _showAuthoritiesDialog(context, authorities),
      child: Text('Add Authorities'),
    );
  }

  Future<void> _showAuthoritiesDialog(
    BuildContext context,
    List<AuthorityEntity> authorities,
  ) async {
    await showDialog<List<AuthorityEntity>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Authorities'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter the authority name with their signature',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TextField(
                    controller: authorityNameController,
                    decoration: InputDecoration(
                      labelText: 'Authority Name',
                      border: OutlineInputBorder(),
                      hintText: 'Enter Authority like Principal,HOD,etc',
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 12),

                  child: UploadImageWithRemovedBg(
                    labelName: "Upload Authority Signature",
                    controller: authoritySignatureController,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ListenableBuilder(
              listenable: authorityNameController,
              builder: (context, child) {
                return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    final bool isImageReady =
                        state is SendImageForBackgroundRemovalSuccessState;
                    final bool isNameNotEmpty = authorityNameController.text
                        .trim()
                        .isNotEmpty;
                    final bool isOkEnabled = isImageReady && isNameNotEmpty;
                    return ElevatedButton(
                      onPressed: isOkEnabled
                          ? () {
                              setState(() {
                                authorities.add(
                                  AuthorityEntity(
                                    authorityNameController.text.trim(),
                                    authoritySignatureController.text,
                                  ),
                                );
                              });

                              Navigator.pop(context);
                            }
                          : null,
                      child: Text('OK'),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
