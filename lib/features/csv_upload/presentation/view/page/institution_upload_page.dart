import 'package:flutter/material.dart';

class InstitutionCsvUploadPage extends StatefulWidget {
  const InstitutionCsvUploadPage({super.key});

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
      appBar: AppBar(title: const Text("Upload CSV")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // File Selection
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    fileName = "example_data.csv";
                  });
                },
                child: Text(
                  fileName == null ? "Select CSV File" : "File: $fileName",
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Category
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Upload Button
            ElevatedButton(
              onPressed: () {
                String category = _categoryController.text;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "File: ${fileName ?? "No File"} | Category: ${category.isEmpty ? "Not Entered" : category}",
                    ),
                  ),
                );
              },
              child: const Text("Upload"),
            ),
          ],
        ),
      ),
    );
  }
}
