import 'package:flutter/material.dart';

class BackgroundJobsColumnWidget extends StatelessWidget {
  const BackgroundJobsColumnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Background Jobs', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        ListTile(
          leading: CircleAvatar(radius: 6, backgroundColor: Colors.green),
          title: Text('Customer Webhook'),
          subtitle: Text('5 minutes ago · 30s'),
        ),
        Divider(),
        ListTile(
          leading: CircleAvatar(radius: 6, backgroundColor: Colors.green),
          title: Text('Data Enrichment'),
          subtitle: Text('12 minutes ago · 2m 15s'),
        ),
        Divider(),
        ListTile(
          leading: CircleAvatar(radius: 6, backgroundColor: Colors.red),
          title: Text('Inventory Sync'),
          subtitle: Text('32 minutes ago · 45s'),
        ),
      ],
    );
  }
}
