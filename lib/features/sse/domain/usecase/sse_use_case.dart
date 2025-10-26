import 'package:flutter_dashboard/features/sse/domain/repository/sse_repository.dart';

class SseUseCase {
  final SseRepository _repository;

  SseUseCase(this._repository);

  Stream<Map<String, dynamic>> call() {
    return _repository.listenToSse();
  }
}
