import 'dart:convert';

class SSEEntity<T> {
  final String event;
  final T data;

  SSEEntity({required this.event, required this.data});

  factory SSEEntity.fromRawSSE({
    required String event,
    required String rawData,
    required T Function(dynamic) fromJsonT,
  }) {
    final decoded = jsonDecode(rawData) as dynamic;
    return SSEEntity(event: event, data: fromJsonT(decoded));
  }
}
