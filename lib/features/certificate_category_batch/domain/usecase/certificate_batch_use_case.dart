import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/entity/certificate_category_entity.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/repository/category_batch_irepository.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/repository/certificate_batch_iresponsibility.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';

class CertificateBatchUseCaseParams {
  String institutionID;
  String institutionFacultyID;
  String categoryID;

  CertificateBatchUseCaseParams({
    required this.institutionID,
    required this.institutionFacultyID,
    required this.categoryID,
  });
}

class CertificateBatchUseCase
    implements
        UseCase<List<CertificateDataEntity>, CertificateBatchUseCaseParams> {
  CertificateBatchIrepository _certificateBatchIrepository;
  CertificateBatchUseCase(this._certificateBatchIrepository);
  @override
  DefaultFutureEitherType<List<CertificateDataEntity>> call(
    CertificateBatchUseCaseParams params,
  ) {
    return _certificateBatchIrepository.getCertificateBatchForCategoryID(
      params.institutionID,
      params.institutionFacultyID,
      params.categoryID,
    );
  }
}
