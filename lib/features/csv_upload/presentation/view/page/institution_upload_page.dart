import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/faculty_entity.dart';
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
  List<FacultyEntity> facultyList = [];
  FacultyEntity? selectedFaculty; // Track selected faculty
  final TextEditingController _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<UploadBloc>().add(
      InstitutionCheckEvent(institutionID: widget.institutionID),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload CSV"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Row(
        children: [
          // Sidebar - Always visible
          BlocBuilder<UploadBloc, UploadState>(
            builder: (context, state) {
              if (state is InstitutionCheckSuccessState) {
                facultyList = state.institutionWithFacultiesEntity.faculties;
                // Set first faculty as default selection
                if (facultyList.isNotEmpty && selectedFaculty == null) {
                  selectedFaculty = facultyList.first;
                }
                return _buildFacultiesSidebar(widget.institutionID);
              } else {
                return _buildLoadingSidebar();
              }
            },
          ),

          // Main content area
          Expanded(
            child: BlocBuilder<UploadBloc, UploadState>(
              builder: (context, state) {
                if (state is InstitutionCheckFailureState) {
                  return Center(child: Text(state.message));
                } else if (state is InstitutionCheckSuccessState) {
                  facultyList = state.institutionWithFacultiesEntity.faculties;
                  // Set first faculty as default selection if not already set
                  if (facultyList.isNotEmpty && selectedFaculty == null) {
                    selectedFaculty = facultyList.first;
                  }
                  return _buildUploadPageUI(
                    context,
                    state.institutionWithFacultiesEntity.institution,
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Sidebar with faculties list
  Widget _buildFacultiesSidebar(String institutionID) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(right: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Column(
        children: [
          // User info section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              border: Border(bottom: BorderSide(color: Colors.blue.shade700)),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Icon(Icons.person, size: 40, color: Colors.blue),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),

          // Faculties Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SELECT FACULTY",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                ...facultyList.map((faculty) {
                  final isSelected =
                      selectedFaculty?.institutionFacultyID ==
                      faculty.institutionFacultyID;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    color: isSelected
                        ? Colors.blue.withOpacity(0.1)
                        : Colors.white,
                    elevation: isSelected ? 2 : 0,
                    child: ListTile(
                      dense: true,
                      leading: Icon(
                        Icons.school,
                        color: isSelected ? Colors.blue : Colors.grey,
                      ),
                      title: Text(
                        faculty.facultyName.isNotEmpty
                            ? faculty.facultyName
                            : "Unnamed Faculty",
                        style: TextStyle(
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected ? Colors.blue : Colors.black87,
                        ),
                      ),
                      subtitle: faculty.universityAffiliation.isNotEmpty
                          ? Text(
                              faculty.universityAffiliation,
                              style: TextStyle(fontSize: 11),
                            )
                          : null,
                      trailing: isSelected
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16,
                            )
                          : null,
                      onTap: () {
                        setState(() {
                          selectedFaculty = faculty;
                        });
                      },
                    ),
                  );
                }),
              ],
            ),
          ),

          const Spacer(),

          // Navigation Section
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton.icon(
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (_) => CategorySelectionPage(
                //             institutionFacultyID:
                //                 selectedFaculty?.institutionFacultyID ?? '',
                //             institutionID: institutionID,
                //           ),
                //         ),
                //       );
                //     },
                //     icon: const Icon(Icons.list),
                //     label: const Text('View Categories'),
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.green,
                //       foregroundColor: Colors.white,
                //     ),
                //   ),
                // ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Settings functionality
                    },
                    icon: const Icon(Icons.settings),
                    label: const Text('Settings'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Logout functionality
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
            // Selected Faculty Info
            if (selectedFaculty != null) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.school, color: Colors.blue),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Selected Faculty: ${selectedFaculty!.facultyName.isNotEmpty ? selectedFaculty!.facultyName : 'Unnamed Faculty'}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            if (selectedFaculty!
                                .universityAffiliation
                                .isNotEmpty)
                              Text(
                                selectedFaculty!.universityAffiliation,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                          ],
                        ),
                      ),
                      Chip(
                        label: Text(
                          selectedFaculty!.universityCollegeCode,
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],

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
                    pickedFile != null &&
                        _categoryController.text.isNotEmpty &&
                        selectedFaculty != null
                    ? () {
                        context.read<UploadBloc>().add(
                          UploadCsvFileEvent(
                            institutionID: widget.institutionID,
                            categoryName: _categoryController.text,
                            platformFile: pickedFile,
                            facultyPublicKey: selectedFaculty!.facultyPublicKey,
                            institutionFacultyName:
                                selectedFaculty!.facultyName == ""
                                ? institutionEntity.institutionName + " faculty"
                                : selectedFaculty!.facultyName,
                            institutionFacultyID:
                                selectedFaculty!.institutionFacultyID,
                          ),
                        );
                      }
                    : null,
                icon: const Icon(Icons.cloud_upload),
                label: const Text("Upload CSV"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor:
                      pickedFile != null &&
                          _categoryController.text.isNotEmpty &&
                          selectedFaculty != null
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

  // Loading sidebar
  Widget _buildLoadingSidebar() {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(right: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Column(
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
      ),
    );
  }

  // Keep old sidebar for compatibility (if needed elsewhere)
  Widget _buildLoadedDrawer(
    BuildContext context,
    UploadPageStartSuccessState state,
  ) {
    return _buildFacultiesSidebar(widget.institutionID);
  }

  // Rest of your helper methods remain the same...
  void _showCsvPreview(PlatformFile file) {
    if (file.bytes != null) {
      final content = String.fromCharCodes(file.bytes!);
      final lines = content.split('\n').take(3);
      AppLogger.info("CSV Preview:\n${lines.join('\n')}");
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

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

  void _downloadSampleCsv() {
    const sampleCsv = '''
certificate_id,block_number,position,student_id,student_name,certificate_type,degree,college,major,gpa,percentage,division,university_name,issue_date,enrollment_date,completion_date,leaving_date,reason_for_leaving,character_remarks,general_remarks
CERT_2024_001,12345,1,STU_2020_001,John Doe,COURSE_COMPLETION,Bachelor of Science,Engineering College,Computer Science,3.8,85.5,First Class,University of Technology,2024-01-15,2020-06-01,2024-05-30,2024-05-30,Graduation,Excellent character,Completed with distinction
CERT_2024_002,12346,2,STU_2021_002,Jane Smith,CHARACTER,,,,,,,,,2024-01-16,2021-07-01,,2024-01-16,Transfer,Good conduct,Transfer certificate
''';

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
              _downloadCsvFile(sampleCsv, 'sample_certificate_template.csv');
              Navigator.pop(context);
            },
            child: const Text("Download"),
          ),
        ],
      ),
    );
  }

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

  Widget _buildLoadedSidebar(
    BuildContext context,
    InstitutionCheckSuccessState state,
    FacultyEntity? selectedFaculty,
  ) {
    final faculties = state.institutionWithFacultiesEntity.faculties;
    if (faculties.isNotEmpty && selectedFaculty == null) {
      selectedFaculty = faculties.first;
    }

    return Container(
      width: 280,
      color: Colors.grey[50],
      child: Column(
        children: [
          // Institution Info
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.blue),
                ),
                const SizedBox(height: 8),
                Text(
                  state
                      .institutionWithFacultiesEntity
                      .institution
                      .institutionName,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Faculties List
          Expanded(
            child: ListView.builder(
              itemCount: faculties.length,
              itemBuilder: (context, index) {
                final faculty = faculties[index];
                final isSelected =
                    selectedFaculty?.institutionFacultyID ==
                    faculty.institutionFacultyID;

                return ListTile(
                  leading: Icon(
                    Icons.school,
                    color: isSelected ? Colors.blue : Colors.grey,
                  ),
                  title: Text(
                    faculty.facultyName.isEmpty
                        ? "Unnamed Faculty"
                        : faculty.facultyName,
                  ),
                  trailing: isSelected
                      ? Icon(Icons.check, color: Colors.blue)
                      : null,
                  tileColor: isSelected ? Colors.blue.withOpacity(0.1) : null,
                  onTap: () => setState(() => selectedFaculty = faculty),
                );
              },
            ),
          ),

          // Actions
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: selectedFaculty != null
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CategorySelectionPage(
                                institutionFacultyID:
                                    selectedFaculty!.institutionFacultyID,
                                institutionID: widget.institutionID,
                              ),
                            ),
                          );
                        }
                      : null,
                  child: const Text('View Categories'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
