import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/entity/certificate_category_entity.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/presentation/view/certificate_batch_display_page.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/presentation/view_model/batch_bloc.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/presentation/view_model/batch_event.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/presentation/view_model/batch_state.dart';

class CategorySelectionPage extends StatefulWidget {
  String institutionID;
  String institutionFacultyID;
  CategorySelectionPage({
    super.key,
    required this.institutionID,
    required this.institutionFacultyID,
  });

  @override
  State<CategorySelectionPage> createState() => _CategorySelectionPageState();
}

class _CategorySelectionPageState extends State<CategorySelectionPage> {
  final bool _hasTriggeredLoad = false;

  @override
  void initState() {
    super.initState();
    // Ensure context is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BatchBloc>().add(
        GetCategoryBatchListEvent(
          institutionID: widget.institutionID,
          institutionFacultyID: widget.institutionFacultyID,
        ),
      );
    });
  }

  List<CertificateCategoryEntity> categories = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Category')),
      body: BlocBuilder<BatchBloc, BatchState>(
        builder: (context, state) {
          if (state is CategoryBatchLoadSuccessState) {
            categories = state.batches;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final item = categories[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(
                      item.categoryName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Created: ${item.createdAt}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('Selected: ${item.categoryName}'),
                      //   ),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CertificateBatchDisplayPage(
                            institutionID: widget.institutionID,
                            institutionFacultyID: widget.institutionFacultyID,
                            categoryID: item.categoryID,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is CategoryBatchLoadFailureState) {
            return Center(child: Text(state.errorMsg));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
