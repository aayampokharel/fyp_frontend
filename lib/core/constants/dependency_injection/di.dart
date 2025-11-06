import 'package:dio/dio.dart';
import 'package:flutter_dashboard/core/wrappers/dio_client.dart';
import 'package:flutter_dashboard/features/authentication/data/data_source/admin_remote_data_source.dart';
import 'package:flutter_dashboard/features/authentication/data/data_source/faculty_remote_data_source.dart';
import 'package:flutter_dashboard/features/authentication/data/data_source/institution_remote_data_source.dart';
import 'package:flutter_dashboard/features/authentication/data/data_source/user_account_remote_data_source.dart';
import 'package:flutter_dashboard/features/authentication/data/repository/admin_account_repository_impl.dart';
import 'package:flutter_dashboard/features/authentication/data/repository/faculty_repository_impl.dart';
import 'package:flutter_dashboard/features/authentication/data/repository/institution_repository_impl.dart';
import 'package:flutter_dashboard/features/authentication/data/repository/user_account_repository_impl.dart';
import 'package:flutter_dashboard/features/authentication/domain/repository/admin_repository.dart';
import 'package:flutter_dashboard/features/authentication/domain/repository/faculty_repository.dart';
import 'package:flutter_dashboard/features/authentication/domain/repository/institution_repository.dart';
import 'package:flutter_dashboard/features/authentication/domain/repository/user_account_repository.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/admin_account_usecase.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/faculty_usecase.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/institute_login_usecase.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/institution_usecase.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/user_account_usecase.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/data/data_source/category_batch_remote_data_source.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/data/data_source/certificate_batch_remote_data_source.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/data/repository/category_batch_repository_impl.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/data/repository/certificate_batch_repository_impl.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/repository/category_batch_irepository.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/repository/certificate_batch_iresponsibility.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/usecase/category_batch_usecase.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/usecase/certificate_batch_usecase.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/usecase/individual_certificate_download_usecase.dart';
import 'package:flutter_dashboard/features/csv_upload/data/data_source/category_creation_remote_data_source.dart';
import 'package:flutter_dashboard/features/csv_upload/data/data_source/certificate_list_remote_data_source.dart';
import 'package:flutter_dashboard/features/csv_upload/data/data_source/institution_is_active_data_source.dart';
import 'package:flutter_dashboard/features/csv_upload/data/repository/category_creation_repository_impl.dart';
import 'package:flutter_dashboard/features/csv_upload/data/repository/file_upload_repository_impl.dart';
import 'package:flutter_dashboard/features/csv_upload/data/repository/institution_is_active_impl.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/repository/category_creation_irepository.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/repository/file_upload_irepository.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/repository/institution_is_active_irepository.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/usecase/category_creation_usecase.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/usecase/certificate_upload_usecase.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/usecase/check_institution_is_active_usecase.dart';
import 'package:flutter_dashboard/features/sse/data/data_source/sse_data_source.dart';
import 'package:flutter_dashboard/features/sse/data/repository/sse_repository_impl.dart';
import 'package:flutter_dashboard/features/sse/domain/repository/sse_repository.dart';
import 'package:flutter_dashboard/features/sse/domain/usecase/sse_use_case.dart';
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
  getIt.registerLazySingleton<InstitutionUseCase>(
    () => InstitutionUseCase(getIt<InstitutionRepository>()),
  );

  //================================instituteAccountusecase==x

  getIt.registerLazySingleton<InstituteAccountUseCase>(
    () => InstituteAccountUseCase(getIt<InstitutionRepository>()),
  );

  //================================useraccount==x

  getIt.registerLazySingleton<UserAccountRemoteDataSource>(
    () => UserAccountRemoteDataSource(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<UserAccountRepositoryImpl>(
    () => UserAccountRepositoryImpl(getIt<UserAccountRemoteDataSource>()),
  );
  getIt.registerLazySingleton<UserAccountRepository>(
    () => getIt<UserAccountRepositoryImpl>(),
  );

  getIt.registerLazySingleton<UserAccountUseCase>(
    () => UserAccountUseCase(getIt<UserAccountRepository>()),
  );
  //================================faculty==x
  getIt.registerLazySingleton<FacultyRemoteDataSource>(
    () => FacultyRemoteDataSource(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<FacultyRepositoryImpl>(
    () => FacultyRepositoryImpl(getIt<FacultyRemoteDataSource>()),
  );
  getIt.registerLazySingleton<FacultyRepository>(
    () => getIt<FacultyRepositoryImpl>(),
  );

  getIt.registerLazySingleton<FacultyUseCase>(
    () => FacultyUseCase(getIt<FacultyRepository>()),
  );
  //===============================admin==x
  getIt.registerLazySingleton<AdminAccountRemoteDataSource>(
    () => AdminAccountRemoteDataSource(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<AdminAccountRepositoryImpl>(
    () => AdminAccountRepositoryImpl(getIt<AdminAccountRemoteDataSource>()),
  );
  getIt.registerLazySingleton<AdminAccountRepository>(
    () => getIt<AdminAccountRepositoryImpl>(),
  );

  getIt.registerLazySingleton<AdminAccountUseCase>(
    () => AdminAccountUseCase(getIt<AdminAccountRepository>()),
  );
  //===============================sse==x
  getIt.registerLazySingleton<SseRemoteDataSource>(() => SseRemoteDataSource());
  getIt.registerLazySingleton<SseRepositoryImpl>(
    () => SseRepositoryImpl(getIt<SseRemoteDataSource>()),
  );
  getIt.registerLazySingleton<SseRepository>(() => getIt<SseRepositoryImpl>());

  getIt.registerLazySingleton<SseUseCase>(
    () => SseUseCase(getIt<SseRepository>()),
  );
  //===============================category-batch==x
  getIt.registerLazySingleton<CategoryBatchRemoteDataSource>(
    () => CategoryBatchRemoteDataSource(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<CategoryBatchRepositoryImpl>(
    () => CategoryBatchRepositoryImpl(getIt<CategoryBatchRemoteDataSource>()),
  );
  getIt.registerLazySingleton<CategoryBatchIrepository>(
    () => getIt<CategoryBatchRepositoryImpl>(),
  );
  getIt.registerLazySingleton<CategoryBatchUseCase>(
    () => CategoryBatchUseCase(getIt<CategoryBatchIrepository>()),
  );
  //===============================certificate-batch==x
  getIt.registerLazySingleton<CertificateBatchRemoteDataSource>(
    () => CertificateBatchRemoteDataSource(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<CertificateBatchRepositoryImpl>(
    () => CertificateBatchRepositoryImpl(
      getIt<CertificateBatchRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton<CertificateBatchIrepository>(
    () => getIt<CertificateBatchRepositoryImpl>(),
  );
  getIt.registerLazySingleton<IndividualCertificateDownloadPDFUseCase>(
    () => IndividualCertificateDownloadPDFUseCase(
      getIt<CertificateBatchIrepository>(),
    ),
  );
  getIt.registerLazySingleton<CertificateBatchUseCase>(
    () => CertificateBatchUseCase(getIt<CertificateBatchIrepository>()),
  );
  //===============================certificate-upload==x
  getIt.registerLazySingleton<CertificateListRemoteDataSource>(
    () => CertificateListRemoteDataSource(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<FileUploadRepositoryImpl>(
    () => FileUploadRepositoryImpl(getIt<CertificateListRemoteDataSource>()),
  );
  getIt.registerLazySingleton<FileUploadIrepository>(
    () => getIt<FileUploadRepositoryImpl>(),
  );
  getIt.registerLazySingleton<CertificateUploadUseCase>(
    () => CertificateUploadUseCase(getIt<FileUploadIrepository>()),
  );
  //===============================check-institution-is-active==x
  getIt.registerLazySingleton<InstitutionIsActiveRemoteDataSource>(
    () => InstitutionIsActiveRemoteDataSource(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<InstitutionIsActiveRepositoryImpl>(
    () => InstitutionIsActiveRepositoryImpl(
      getIt<InstitutionIsActiveRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton<InstitutionIsActiveIrepository>(
    () => getIt<InstitutionIsActiveRepositoryImpl>(),
  );
  getIt.registerLazySingleton<CheckInstitutionIsActiveUsecase>(
    () => CheckInstitutionIsActiveUsecase(
      getIt<InstitutionIsActiveIrepository>(),
    ),
  );
  //===============================category-registration==x
  getIt.registerLazySingleton<CategoryCreationRemoteDataSource>(
    () => CategoryCreationRemoteDataSource(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<CategoryCreationRepositoryImpl>(
    () => CategoryCreationRepositoryImpl(
      getIt<CategoryCreationRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton<CategoryCreationIRepository>(
    () => getIt<CategoryCreationRepositoryImpl>(),
  );
  getIt.registerLazySingleton<CategoryCreationUseCase>(
    () => CategoryCreationUseCase(getIt<CategoryCreationIRepository>()),
  );
}
