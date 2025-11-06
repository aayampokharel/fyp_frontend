import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/presentation/view_model/batch_bloc.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/presentation/view_model/batch_event.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/presentation/view_model/batch_state.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';

class CertificateBatchDisplayPage extends StatefulWidget {
  String institutionID;
  String institutionFacultyID;
  String categoryID;
  String categoryName;

  CertificateBatchDisplayPage({
    super.key,
    required this.institutionID,
    required this.institutionFacultyID,
    required this.categoryID,
    required this.categoryName,
  });

  @override
  State<CertificateBatchDisplayPage> createState() =>
      _CertificateSelectionPageState();
}

class _CertificateSelectionPageState
    extends State<CertificateBatchDisplayPage> {
  @override
  void initState() {
    super.initState();
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

  List<CertificateDataEntity> categories = [];

  void _onViewPressed(CertificateDataEntity certificate) {
    print('View pressed for: ${certificate.studentName}');
  }

  void _onDownloadPressed(CertificateDataEntity certificate) {
    context.read<BatchBloc>().add(
      DownloadIndividualPDFButtonPressedEvent(
        categoryID: certificate.pdfCategoryId,
        categoryName: widget.categoryName,
        fileID: certificate.PDFFileID,
      ),
    );
  }

  void _onDownloadAllPressed() {
    print('Download All pressed');
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BatchBloc, BatchState>(
      listener: (context, state) {
        // Listen for failure states and show snackbar
        if (state is CertificateBatchSelectFailureState) {
          _showErrorSnackbar(state.errorMsg);
        }
      },
      child: Scaffold(
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
          buildWhen: (previous, current) {
            // Don't rebuild the UI for failure states, just show snackbar
            return current is! CertificateBatchSelectFailureState;
          },
          builder: (context, state) {
            if (state is CertificateBatchSelectSuccessState) {
              AppLogger.info(state.selectedCertificateBatch.length.toString());
              categories = state.selectedCertificateBatch;
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
                                onPressed: () =>
                                    _onDownloadPressed(certificate),
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
            } else if (state is CertificateBatchSelectLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              // Initial state or other states - show loading
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
