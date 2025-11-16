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
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/upload_image_with_removed_bg.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_bloc.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_event.dart";
import "package:flutter_dashboard/features/authentication/presentation/view_model/authentication_state.dart";
import "package:flutter_dashboard/features/csv_upload/presentation/view/page/institution_upload_page.dart";

class AddFacultyPage extends StatefulWidget {
  final String institutionID;

  AddFacultyPage({super.key, required this.institutionID});

  @override
  State<AddFacultyPage> createState() => _SignInFacultyPageState();
}

class _SignInFacultyPageState extends State<AddFacultyPage> {
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

  // 🔴 Added validation error holders
  String? facultyError;
  String? universityAffiliationError;
  String? universityCodeError;
  String? authoritiesError;

  void _validateAndSubmit(BuildContext context) {
    setState(() {
      facultyError = facultyController.text.isEmpty
          ? "Faculty name cannot be empty"
          : null;
      universityAffiliationError = universityAffilicationController.text.isEmpty
          ? "University affiliation is required"
          : null;
      universityCodeError = universityCodeController.text.isEmpty
          ? "University code is required"
          : null;
      authoritiesError = addedAuthorities.isEmpty
          ? "At least one authority must be added"
          : null;
    });

    if (facultyError == null &&
        universityAffiliationError == null &&
        universityCodeError == null &&
        authoritiesError == null) {
      _handleSignIn(context);
    }
  }

  void _handleSignIn(BuildContext context) {
    final String universityAffiliation = universityAffilicationController.text;
    final String universityCode = universityCodeController.text;
    final String faculty = facultyController.text;
    final List<Map<String, String>> authorityWithSignatures = addedAuthorities
        .map((e) => e.toJSON())
        .toList();

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
          if (state is FacultySuccessState) {
            _handleFacultySignInSuccess(
              context,
              widget.institutionID,
              state.facultyEntity,
            );
          }

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
                    Text("Faculty Registration Failed"),
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
                            ImageConstants.facultyRegistrationImage,
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
                                Icons.margin_outlined,
                                size: 60,
                                color: ColorConstants.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            'Register Your Institution Faculty',
                            style: TextStyle(
                              fontSize: 32, // Slightly larger
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
                            'Secure, transparent, and user-friendly platform for registering your institution faculty.Register and unlock the power of transparency, security, and ease of access.',
                            style: TextStyle(
                              fontSize: 17,
                              color: ColorConstants.white.withOpacity(0.9),
                              height: 1.6,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildFeatureItem(
                            Icons.verified_user,
                            'Supports Multiple Faculties',
                          ),
                          _buildFeatureItem(
                            Icons.navigation_outlined,
                            'Secure & Easy to Navigate',
                          ),
                          _buildFeatureItem(Icons.safety_check, 'Easy to Use'),
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
                              'Faculty Details',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Enter faculty information and add authorized signatories',
                              style: TextStyle(
                                color: ColorConstants.mediumGray,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 30),

                            // Faculty Name Field
                            _buildInputField(
                              controller: facultyController,
                              label: 'Faculty Name',
                              icon: Icons.school,
                              errorText: facultyError,
                            ),
                            const SizedBox(height: 20),

                            // University Affiliation Field
                            _buildInputField(
                              controller: universityAffilicationController,
                              label: 'University Affiliation',
                              icon: Icons.account_balance,
                              errorText: universityAffiliationError,
                            ),
                            const SizedBox(height: 20),

                            // University Code Field
                            _buildInputField(
                              controller: universityCodeController,
                              label: 'University Code',
                              icon: Icons.code,
                              errorText: universityCodeError,
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 20),

                            // Authorities Section
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Authorized Signatories",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: ColorConstants.textDark,
                                      ),
                                    ),
                                    if (authoritiesError != null) ...[
                                      const SizedBox(width: 8),
                                      Icon(
                                        Icons.error_outline,
                                        color: Colors.redAccent,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        authoritiesError!,
                                        style: const TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () => _showAuthoritiesDialog(
                                    context,
                                    addedAuthorities,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorConstants.primaryBlue,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.add, color: Colors.white),
                                      SizedBox(width: 8),
                                      Text(
                                        'Add Authority',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Authorities List
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: ColorConstants.lightGray,
                                ),
                              ),
                              height: 150,
                              width: double.infinity,
                              child: addedAuthorities.isEmpty
                                  ? Center(
                                      child: Text(
                                        "No authorities added yet",
                                        style: TextStyle(
                                          color: ColorConstants.mediumGray,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: addedAuthorities.length,
                                      itemBuilder: (context, index) {
                                        final authority =
                                            addedAuthorities[index];
                                        return ListTile(
                                          leading: Icon(
                                            Icons.person,
                                            color: ColorConstants.primaryBlue,
                                          ),
                                          title: Text(
                                            authority.authorityName,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          subtitle: Text(
                                            "Signature uploaded",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: ColorConstants.mediumGray,
                                            ),
                                          ),
                                          trailing: IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.redAccent,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                addedAuthorities.remove(
                                                  authority,
                                                );
                                              });
                                            },
                                          ),
                                        );
                                      },
                                    ),
                            ),

                            const SizedBox(height: 40),

                            // 🎯 Create Faculty Button
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
                                        'Create Faculty',
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

  Future<void> _showAuthoritiesDialog(
    BuildContext context,
    List<AuthorityEntity> authorities,
  ) async {
    await showDialog<List<AuthorityEntity>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Authority'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Enter the authority name with their signature',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TextField(
                    controller: authorityNameController,
                    decoration: const InputDecoration(
                      labelText: 'Authority Name',
                      border: OutlineInputBorder(),
                      hintText: 'Enter Authority like Principal, HOD, etc.',
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
              child: const Text('Cancel'),
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
                                // Clear controllers after adding
                                authorityNameController.clear();
                                authoritySignatureController.clear();
                              });
                              Navigator.pop(context);
                            }
                          : null,
                      child: const Text('Add Authority'),
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
