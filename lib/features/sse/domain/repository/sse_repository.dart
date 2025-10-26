abstract interface class SseRepository {
  Stream<Map<String, dynamic>> listenToSse();
}
