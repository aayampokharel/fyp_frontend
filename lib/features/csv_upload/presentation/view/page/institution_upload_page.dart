import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';
import 'package:flutter_dashboard/features/csv_upload/presentation/view_model/upload_bloc.dart';
import 'package:flutter_dashboard/features/csv_upload/presentation/view_model/upload_event.dart';
import 'package:flutter_dashboard/features/csv_upload/presentation/view_model/upload_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/presentation/view/category_batch_display_page.dart';
import 'package:universal_html/html.dart' as html;

class InstitutionCsvUploadPage extends StatefulWidget {
  final String institutionID;

  const InstitutionCsvUploadPage({super.key, required this.institutionID});

  @override
  State<InstitutionCsvUploadPage> createState() =>
      _InstitutionCsvUploadPageState();
}

class _InstitutionCsvUploadPageState extends State<InstitutionCsvUploadPage> {
  String? fileName;
  PlatformFile? pickedFile;
  final TextEditingController _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
    if (institutionEntity.isActive == null) {
      return _buildPendingVerificationUI(institutionEntity);
    } else if (institutionEntity.isActive!) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // File Picker (CSV only)
            GestureDetector(
              onTap: () async {
                final result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['csv'],
                  allowMultiple: false,
                );

                if (result != null && result.files.isNotEmpty) {
                  setState(() {
                    pickedFile = result.files.first;
                    fileName = pickedFile!.name;
                    _showCsvPreview(result.files.first);
                  });
                }
              },
              child: Container(
                height: 150,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.upload_file,
                      size: 50,
                      color: fileName == null ? Colors.grey : Colors.green,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      fileName ?? "Click to select CSV file",
                      style: TextStyle(
                        fontSize: 16,
                        color: fileName == null ? Colors.grey : Colors.black,
                        fontWeight: fileName == null
                            ? FontWeight.normal
                            : FontWeight.bold,
                      ),
                    ),
                    if (fileName != null) ...[
                      const SizedBox(height: 5),
                      Text(
                        "File size: ${_formatFileSize(pickedFile!.size)}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // CSV Format Help
            _buildCsvFormatHelp(),

            const SizedBox(height: 20),

            // Category TextField
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Category Name",
                hintText: "e.g., CS_2021_Computer_Science",
                prefixIcon: Icon(Icons.category),
              ),
            ),

            const SizedBox(height: 10),
            Text(
              "This will be used to organize your certificates",
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),

            const SizedBox(height: 20),

            // Upload Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed:
                    pickedFile != null && _categoryController.text.isNotEmpty
                    ? () {
                        context.read<UploadBloc>().add(
                          UploadCsvFileEvent(
                            institutionID: widget.institutionID,
                            categoryName: _categoryController.text,
                            platformFile: pickedFile,
                          ),
                        );
                      }
                    : null,
                icon: const Icon(Icons.cloud_upload),
                label: const Text("Upload CSV"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor:
                      pickedFile != null && _categoryController.text.isNotEmpty
                      ? Colors.blue
                      : Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Sample CSV Download
            TextButton.icon(
              onPressed: _downloadSampleCsv,
              icon: const Icon(Icons.download),
              label: const Text("Download Sample CSV Template"),
            ),
          ],
        ),
      );
    } else {
      return _buildRejectedUI();
    }
  }

  // Helper method to show CSV preview
  void _showCsvPreview(PlatformFile file) {
    if (file.bytes != null) {
      final content = String.fromCharCodes(file.bytes!);
      final lines = content.split('\n').take(3); // Show first 3 lines
      AppLogger.info("CSV Preview:\n${lines.join('\n')}");
    }
  }

  // Helper method to format file size
  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  // CSV Format Help Widget
  Widget _buildCsvFormatHelp() {
    return ExpansionTile(
      title: const Text("CSV Format Requirements"),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Required Columns:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: const [
                  Chip(label: Text("certificate_id")),
                  Chip(label: Text("student_id")),
                  Chip(label: Text("student_name")),
                  Chip(label: Text("certificate_type")),
                  Chip(label: Text("issue_date")),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                "Certificate Types:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: const [
                  Chip(label: Text("COURSE_COMPLETION")),
                  Chip(label: Text("CHARACTER")),
                  Chip(label: Text("LEAVING")),
                  Chip(label: Text("TRANSFER")),
                  Chip(label: Text("PROVISIONAL")),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Sample CSV Download
  void _downloadSampleCsv() {
    const sampleCsv = '''
certificate_id,block_number,position,student_id,student_name,certificate_type,degree,college,major,gpa,percentage,division,university_name,issue_date,enrollment_date,completion_date,leaving_date,reason_for_leaving,character_remarks,general_remarks
CERT_2024_001,12345,1,STU_2020_001,John Doe,COURSE_COMPLETION,Bachelor of Science,Engineering College,Computer Science,3.8,85.5,First Class,University of Technology,2024-01-15,2020-06-01,2024-05-30,2024-05-30,Graduation,Excellent character,Completed with distinction
CERT_2024_002,12346,2,STU_2021_002,Jane Smith,CHARACTER,,,,,,,,,2024-01-16,2021-07-01,,2024-01-16,Transfer,Good conduct,Transfer certificate
''';

    // For web, you can show the CSV content or implement download
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Sample CSV Template"),
        content: SingleChildScrollView(child: SelectableText(sampleCsv)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement download logic for web
              _downloadCsvFile(sampleCsv, 'sample_certificate_template.csv');
              Navigator.pop(context);
            },
            child: const Text("Download"),
          ),
        ],
      ),
    );
  }

  // Download CSV file for web
  void _downloadCsvFile(String content, String filename) {
    final bytes = utf8.encode(content);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = filename;

    html.document.body!.children.add(anchor);
    anchor.click();
    html.document.body!.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  Widget _buildPendingVerificationUI(InstitutionEntity entity) {
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
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "${entity.institutionName}\n${entity.toleAddress}, ${entity.districtAddress}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRejectedUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.error_outline, size: 60, color: Colors.red),
          SizedBox(height: 16),
          Text(
            "Institution Not Approved",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            "Your institution has been rejected or disabled.\nPlease contact admin for details.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
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
      Container(
        height: 180,
        color: Colors.blue.shade100,
        child: const Center(
          child: CircularProgressIndicator(color: Colors.blue),
        ),
      ),
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
