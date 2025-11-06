import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/entity/certificate_category_entity.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/repository/category_creation_irepository.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/repository/file_upload_irepository.dart';

class CertificateCategoryCreationUseCaseParams {
  String facultyName;
  String preferredCategoryName;
  String institutionId;
  String institutionFacultyId;

  CertificateCategoryCreationUseCaseParams({
    required this.facultyName,
    required this.preferredCategoryName,
    required this.institutionId,
    required this.institutionFacultyId,
  });
}

class CategoryCreationUseCase
    implements
        UseCase<
          CertificateCategoryEntity,
          CertificateCategoryCreationUseCaseParams
        > {
  final CategoryCreationIRepository _categoryCreationRepository;

  CategoryCreationUseCase(this._categoryCreationRepository);
  @override
  DefaultFutureEitherType<CertificateCategoryEntity> call(
    CertificateCategoryCreationUseCaseParams params,
  ) {
    return _categoryCreationRepository.categoryCreation(
      params.facultyName,
      params.preferredCategoryName,
      params.institutionId,
      params.institutionFacultyId,
    );
  }
}
