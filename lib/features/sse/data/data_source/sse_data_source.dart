import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dashboard/core/constants/api_endpoints.dart';
import '../../../../core/errors/app_logger.dart';

class SseRemoteDataSource {
  late String connectionToken;

  Stream<Map<String, dynamic>> connectToSse() async* {
    final url = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.sseInstitution);
    final client = http.Client();
    final request = http.Request('GET', url);

    final streamedResponse = await client.send(request);
    String? currentEvent;
    StringBuffer dataBuffer = StringBuffer();
    await for (final chunk in streamedResponse.stream.transform(utf8.decoder)) {
      final lines = chunk.split(RegExp(r'\r?\n'));

      for (final line in lines) {
        if (line.startsWith('event:')) {
          currentEvent = line.substring(6).trim();
        } else if (line.startsWith('data:')) {
          dataBuffer.writeln(line.substring(5).trim());
        } else if (line.trim().isEmpty && currentEvent != null) {
          final rawJson = dataBuffer.toString().trim();
          if (rawJson.isNotEmpty) {
            try {
              AppLogger.info(
                "📡 Received SSE event: $currentEvent, data: $rawJson",
              );
              final data = json.decode(rawJson) as Map<String, dynamic>;
              yield {
                //'connection_token': connectionToken,
                'event': currentEvent,
                'data': data,
              };
            } catch (e) {
              AppLogger.error("❌ Failed to decode SSE data: $e");
            }
          }

          // Reset for next event
          currentEvent = null;
          dataBuffer.clear();
        }
      }
    }
  }
}
