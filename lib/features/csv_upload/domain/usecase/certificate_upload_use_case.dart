import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/repository/file_upload_irepository.dart';

class CertificateUseCaseParams {
  final List<CertificateDataEntity> certificateDataList;
  String instituitonID;
  String institutionFacultyID;
  String institutionFacultyName;
  String categoryID;
  String categoryName;
  CertificateUseCaseParams({
    required this.certificateDataList,
    required this.instituitonID,
    required this.institutionFacultyID,
    required this.institutionFacultyName,
    required this.categoryID,
    required this.categoryName,
  });
}

class CertificateUploadUseCase
    implements UseCase<String, CertificateUseCaseParams> {
  final FileUploadIrepository _fileUploadIrepository;

  CertificateUploadUseCase(this._fileUploadIrepository);
  @override
  DefaultFutureEitherType<String> call(CertificateUseCaseParams params) {
    return _fileUploadIrepository.uploadCSVFileAsEntityList(
      params.certificateDataList,
      params.instituitonID,
      params.institutionFacultyID,
      params.institutionFacultyName,
      params.categoryID,
      params.categoryName,
    );
  }
}
