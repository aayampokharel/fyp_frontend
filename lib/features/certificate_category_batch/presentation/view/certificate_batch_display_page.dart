import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/presentation/view_model/batch_bloc.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/presentation/view_model/batch_event.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/presentation/view_model/batch_state.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';

class CertificateSelectionPage extends StatefulWidget {
  String institutionID;
  String institutionFacultyID;
  String categoryID;

  CertificateSelectionPage({
    super.key,
    required this.institutionID,
    required this.institutionFacultyID,
    required this.categoryID,
  });

  @override
  State<CertificateSelectionPage> createState() =>
      _CertificateSelectionPageState();
}

class _CertificateSelectionPageState extends State<CertificateSelectionPage> {
  @override
  void initState() {
    super.initState();
    // Ensure context is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BatchBloc>().add(
        GetCertificatesBatchListEvent(
          institutionID: widget.institutionID,
          institutionFacultyID: widget.institutionFacultyID,
          categoryID: widget.categoryID,
        ),
      );
    });
  }

  final List<CertificateDataEntity> categories = [
    CertificateDataEntity(
      createdAt: DateTime.now(),
      certificateId: "cert_001",
      blockNumber: 1,
      position: 1,
      studentId: "STU001",
      studentName: "John Smith",
      institutionId: "INST001",
      institutionFacultyId: "FAC001",
      pdfCategoryId: "CAT001",
      certificateType: "COURSE_COMPLETION",
      degree: "Bachelor of Science",
      college: "Science College",
      major: "Computer Science",
      gpa: "3.8",
      percentage: 85.5,
      division: "First",
      universityName: "Tech University",
      issueDate: DateTime(2024, 1, 15),
      enrollmentDate: DateTime(2020, 8, 1),
      completionDate: DateTime(2024, 1, 10),
      certificateHash: "abc123",
      facultyPublicKey: "pub_key_001",
    ),
    CertificateDataEntity(
      createdAt: DateTime.now(),

      certificateId: "cert_002",
      blockNumber: 1,
      position: 2,
      studentId: "STU002",
      studentName: "Emma Wilson",
      institutionId: "INST001",
      institutionFacultyId: "FAC002",
      pdfCategoryId: "CAT002",
      certificateType: "CHARACTER",
      college: "Arts College",
      major: "Mathematics",
      gpa: "3.9",
      percentage: 88.2,
      division: "First",
      universityName: "Math University",
      issueDate: DateTime(2024, 1, 16),
      enrollmentDate: DateTime(2020, 8, 1),
      completionDate: DateTime(2024, 1, 12),
      characterRemarks: "Excellent character and leadership qualities",
      certificateHash: "def456",
      facultyPublicKey: "pub_key_002",
    ),
    CertificateDataEntity(
      createdAt: DateTime.now(),
      certificateId: "cert_003",
      blockNumber: 1,
      position: 3,
      studentId: "STU003",
      studentName: "Michael Brown",
      institutionId: "INST001",
      institutionFacultyId: "FAC003",
      pdfCategoryId: "CAT003",
      certificateType: "LEAVING",
      degree: "Bachelor of Arts",
      college: "Arts College",
      major: "Physics",
      percentage: 82.0,
      division: "First",
      universityName: "Science University",
      issueDate: DateTime(2024, 1, 17),
      enrollmentDate: DateTime(2020, 8, 1),
      leavingDate: DateTime(2024, 1, 14),
      reasonForLeaving: "Transfer to another institution",
      certificateHash: "ghi789",
      facultyPublicKey: "pub_key_003",
    ),
  ];

  void _onViewPressed(CertificateDataEntity certificate) {
    print('View pressed for: ${certificate.studentName}');
  }

  void _onDownloadPressed(CertificateDataEntity certificate) {
    print('Download pressed for: ${certificate.studentName}');
  }

  void _onDownloadAllPressed() {
    print('Download All pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificates'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton.icon(
              onPressed: _onDownloadAllPressed,
              icon: const Icon(Icons.download, size: 20),
              label: const Text('Download All'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<BatchBloc, BatchState>(
        builder: (context, state) {
          if (state is CategoryBatchSelectSuccessState) {
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final certificate = categories[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Certificate info
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              certificate.studentName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'ID: ${certificate.studentId}',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Type: ${certificate.certificateType}',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Major: ${certificate.major ?? "N/A"}',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Buttons row - aligned to bottom right
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // View Button
                            ElevatedButton(
                              onPressed: () => _onViewPressed(certificate),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                              child: const Text('View'),
                            ),
                            const SizedBox(width: 8),

                            // Download PDF Button
                            ElevatedButton(
                              onPressed: () => _onDownloadPressed(certificate),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                              child: const Text('Download PDF'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is CategoryBatchSelectFailureState) {
            return Center(child: Text(state.errorMsg));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
