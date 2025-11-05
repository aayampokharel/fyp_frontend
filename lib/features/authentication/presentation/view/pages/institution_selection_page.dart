import 'package:flutter/material.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';

import 'package:flutter_dashboard/features/csv_upload/presentation/view/page/institution_upload_page.dart';

class InstitutionSelectionPage extends StatelessWidget {
  final List<InstitutionEntity> institutions;

  const InstitutionSelectionPage({super.key, required this.institutions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Institution"),
        centerTitle: true,
      ),
      body: institutions.isEmpty
          ? const Center(child: Text("No institutions found."))
          : ListView.builder(
              itemCount: institutions.length,
              itemBuilder: (context, index) {
                final institution = institutions[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(institution.institutionName ?? "No Name"),
                    subtitle: Text("ID: ${institution.institutionID}"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      //! first get all the associated faculties from institution ID , make separate Usecase then if not available .
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => InstitutionCsvUploadPage(
                            institutionID: institution.institutionID,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
