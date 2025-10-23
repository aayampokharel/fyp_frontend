import 'package:dio/dio.dart';
import 'package:flutter_dashboard/core/wrappers/dio_client.dart';
import 'package:flutter_dashboard/features/authentication/data/data_source/institution_remote_data_source.dart';
import 'package:flutter_dashboard/features/authentication/data/repository/institution_repository_impl.dart';
import 'package:flutter_dashboard/features/authentication/domain/repository/institution_repository.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/institution_usecase.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future initDependencies() async {
  await _initCoreDependencies();
  await _authDependencies();
}

Future<void> _initCoreDependencies() async {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<DioClient>(() => DioClient(dio: getIt<Dio>()));
  return;
}

Future _authDependencies() async {
  getIt.registerLazySingleton<InstitutionRemoteDataSource>(
    () => InstitutionRemoteDataSource(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<InstitutionRepositoryImpl>(
    () => InstitutionRepositoryImpl(getIt<InstitutionRemoteDataSource>()),
  );
  getIt.registerLazySingleton<InstitutionRepository>(
    () => getIt<InstitutionRepositoryImpl>(),
  );
  getIt.registerLazySingleton<InstitutionUsecase>(
    () => InstitutionUsecase(getIt<InstitutionRepository>()),
  );
}
