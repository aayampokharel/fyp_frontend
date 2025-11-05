import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/presentation/view/category_batch_display_page.dart';
import 'package:flutter_dashboard/features/csv_upload/presentation/view_model/upload_bloc.dart';
import 'package:flutter_dashboard/features/csv_upload/presentation/view_model/upload_state.dart';

class InstitutionCsvUploadPage extends StatefulWidget {
  final String institutionID;

  const InstitutionCsvUploadPage({super.key, required this.institutionID});

  @override
  State<InstitutionCsvUploadPage> createState() =>
      _InstitutionUploadPageState();
}

class _InstitutionUploadPageState extends State<InstitutionCsvUploadPage> {
  String? fileName;
  final TextEditingController _categoryController = TextEditingController();

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

      // ✅ Main Body (unchanged, your CSV upload)
      body: BlocBuilder<UploadBloc, UploadState>(
        builder: (context, state) {
          if (state is UploadPageStartFailureState) {
            return Center(child: Text(state.message));
          } else if (state is UploadPageStartSuccessState) {
            return _buildUploadPageUI(context); // extracted for cleanliness
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildUploadPageUI(BuildContext context) {
    return Center(child: Text("CSV Upload UI goes here..."));
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
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Categories")),
    body: const Center(child: Text("Categories List Page")),
  );
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Settings")),
    body: const Center(child: Text("Settings Page")),
  );
}

class ProfilePage extends StatelessWidget {
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
