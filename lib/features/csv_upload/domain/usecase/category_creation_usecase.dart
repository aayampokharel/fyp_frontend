// import 'package:flutter_dashboard/core/use_case.dart';
// import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';
// import 'package:flutter_dashboard/features/csv_upload/domain/repository/file_upload_irepository.dart';

// class CertificateUploadUseCase implements UseCase<String, String> {
//   final FileUploadIrepository _fileUploadIrepository;

//   CertificateUploadUseCase(this._fileUploadIrepository);
//   @override
//   DefaultFutureEitherType<String> call(
//     CertificateCategoryCreationUseCaseParams params,
//   ) {
//     return _fileUploadIrepository.uploadCSVFileAsEntityList(
//       params.certificateDataList,
//       params.instituitonID,
//       params.institutionFacultyID,
//       params.institutionFacultyName,
//       params.categoryID,
//       params.categoryName,
//     );
//   }
// }
