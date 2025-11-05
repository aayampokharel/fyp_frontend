import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';

abstract interface class FileUploadIrepository {
  DefaultFutureEitherType<String> uploadCSVFileAsEntityList(
    List<CertificateDataEntity> certificateDataList,
    String instituitonID,
    String institutionFacultyID,
    String institutionFacultyName,
    String categoryID,
    String categoryName,
  );
}
