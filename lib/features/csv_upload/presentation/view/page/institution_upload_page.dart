import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/faculty_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/presentation/view/category_batch_display_page.dart';
import 'package:flutter_dashboard/features/csv_upload/presentation/view_model/upload_bloc.dart';
import 'package:flutter_dashboard/features/csv_upload/presentation/view_model/upload_event.dart';
import 'package:flutter_dashboard/features/csv_upload/presentation/view_model/upload_state.dart';

class InstitutionCsvUploadPage extends StatefulWidget {
  final String institutionID;
  final FacultyEntity facultyEntity;

  const InstitutionCsvUploadPage({
    super.key,
    required this.institutionID,
    required this.facultyEntity,
  });

  @override
  State<InstitutionCsvUploadPage> createState() =>
      _InstitutionUploadPageState();
}

class _InstitutionUploadPageState extends State<InstitutionCsvUploadPage> {
  String? fileName;
  final TextEditingController _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // context.read<UploadBloc>().add(
    //   UploadPageStartedEvent(
    //     institutionID: widget.institutionID,
    //     facultyEntity: widget.facultyEntity,
    //   ),
    // );
    context.read<UploadBloc>().add(
      InstitutionCheckEvent(institutionID: widget.institutionID),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload CSV"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      drawer: Drawer(
        child: BlocBuilder<UploadBloc, UploadState>(
          builder: (context, state) {
            if (state is UploadPageStartSuccessState) {
              return _buildLoadedDrawer(context, state);
            } else {
              return _buildLoadingDrawer();
            }
          },
        ),
      ),
      body: BlocBuilder<UploadBloc, UploadState>(
        builder: (context, state) {
          if (state is InstitutionCheckFailureState) {
            return Center(child: Text(state.message));
          } else if (state is InstitutionCheckSuccessState) {
            return _buildUploadPageUI(context, state.institutionEntity);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildUploadPageUI(
    BuildContext context,
    InstitutionEntity institutionEntity,
  ) {
    // ✅ 1. Yet to be verified (isActive == null)
    if (institutionEntity.isActive == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.access_time, size: 60, color: Colors.orange),
              const SizedBox(height: 16),
              Text(
                "Institution Verification Pending",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "${institutionEntity.institutionName}\n${institutionEntity.toleAddress}, ${institutionEntity.districtAddress}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 16),
              const Text(
                "Your institution has been registered.\n"
                "Manual verification is in progress and may take a few days.\n"
                "You can close this page and return after approval.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    } else if (institutionEntity.isActive!) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔹 CSV Drag/Select Box
            GestureDetector(
              onTap: () {
                // TODO: Implement file picker
              },
              child: DottedBorder(
                child: Container(
                  height: 150,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.upload_file, size: 50, color: Colors.grey),
                      SizedBox(height: 10),
                      Text("Drag & Drop CSV here or Click to Upload"),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Category Name TextField
            TextField(
              controller: _categoryController, // Already defined in your class
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Category Name",
                prefixIcon: Icon(Icons.category),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Upload Button
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement upload functionality
              },
              icon: const Icon(Icons.cloud_upload),
              label: const Text("Upload CSV"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
            ),
          ],
        ),
      );
    }
    // ✅ 3. Institution is Rejected or Disabled
    else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              "Institution Not Approved",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Your institution has been rejected or disabled.\n"
              "Please contact admin for further details.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Account"),
        content: const Text(
          "Are you sure you want to delete your account permanently?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // API call for delete
              Navigator.pop(context);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Categories")),
    body: const Center(child: Text("Categories List Page")),
  );
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Settings")),
    body: const Center(child: Text("Settings Page")),
  );
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Profile")),
    body: const Center(child: Text("Profile Page")),
  );
}

Widget _buildLoadedDrawer(
  BuildContext context,
  UploadPageStartSuccessState state,
) {
  return ListView(
    padding: EdgeInsets.zero,
    children: [
      UserAccountsDrawerHeader(
        decoration: BoxDecoration(color: Colors.blue),
        accountName: Text("User Name"),
        accountEmail: Text("user@email.com"),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.person, size: 40, color: Colors.blue),
        ),
      ),
      ListTile(
        leading: Icon(Icons.list),
        title: Text('Categories'),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CategorySelectionPage(
                institutionFacultyID: state.facultyEntity.institutionFacultyID,
                institutionID: state.facultyEntity.institutionID,
              ),
            ),
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('Settings'),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.person),
        title: Text('Profile'),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.logout),
        title: Text('Logout'),
        onTap: () {},
      ),
    ],
  );
}

Widget _buildLoadingDrawer() {
  return ListView(
    padding: EdgeInsets.zero,
    children: [
      // Fake header
      Container(
        height: 180,
        color: Colors.blue.shade100,
        child: const Center(
          child: CircularProgressIndicator(color: Colors.blue),
        ),
      ),

      // Menu skeletons
      ...List.generate(4, (index) {
        return ListTile(
          leading: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
          ),
          title: Container(
            height: 15,
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    ],
  );
}
