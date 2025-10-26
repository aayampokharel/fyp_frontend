import 'package:flutter_dashboard/features/sse/data/data_source/sse_data_source.dart';
import 'package:flutter_dashboard/features/sse/domain/repository/sse_repository.dart';

class SseRepositoryImpl implements SseRepository {
  final SseRemoteDataSource _remoteDataSource;

  SseRepositoryImpl(this._remoteDataSource);

  @override
  Stream<Map<String, dynamic>> listenToSse() {
    // simply forward the stream from remote data source
    return _remoteDataSource.connectToSse();
  }
}
