import 'package:flutter/material.dart';

class DataTableWidget extends StatelessWidget {
  const DataTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text("Rank")),
        DataColumn(label: Text("Institution")),
        DataColumn(label: Text("Certificates")),
        DataColumn(label: Text("Growth")),
        DataColumn(label: Text("Status")),
      ],
      rows: const [
        DataRow(
          cells: [
            DataCell(Text("1")),
            DataCell(Text("Harvard University")),
            DataCell(Text("2,543")),
            DataCell(Text("+12%")),
            DataCell(Text("Active")),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text("2")),
            DataCell(Text("MIT")),
            DataCell(Text("2,128")),
            DataCell(Text("+8%")),
            DataCell(Text("Active")),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text("3")),
            DataCell(Text("Stanford University")),
            DataCell(Text("1,897")),
            DataCell(Text("+15%")),
            DataCell(Text("Active")),
          ],
        ),
      ],
    );
  }
}
