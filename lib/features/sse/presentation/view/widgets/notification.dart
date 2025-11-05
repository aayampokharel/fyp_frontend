import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/dependency_injection/di.dart';
import 'package:flutter_dashboard/core/constants/enum.dart';
import 'package:flutter_dashboard/features/sse/domain/usecase/sse_use_case.dart';

class SseListPage extends StatefulWidget {
  const SseListPage({super.key});

  @override
  State<SseListPage> createState() => _SseListPageState();
}

class _SseListPageState extends State<SseListPage> {
  final List<Map<String, dynamic>> _institutions = [];

  @override
  void initState() {
    super.initState();
    final sseUseCase = getIt<SseUseCase>();

    // //rather than this , simply use ssesingleform only not others change logic only to fetch that have pending when approved or rejected remove from list .
    sseUseCase.call().listen((event) {
      if (event['event'] == SSEType.sseSingleForm.value) {
        setState(() {
          _institutions.add(event['data']);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Institutions SSE")),
      body: _institutions.isEmpty
          ? const Center(child: Text("Waiting for institutions..."))
          : ListView.builder(
              itemCount: _institutions.length,
              itemBuilder: (context, index) {
                final inst = _institutions[index];
                return ListTile(
                  title: Text(inst['name'] ?? 'No Name'),
                  subtitle: Text(inst['location'] ?? 'No Location'),
                  leading: CircleAvatar(child: Text(inst['id'] ?? '?')),
                );
              },
            ),
    );
  }
}
