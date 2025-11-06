import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';

abstract interface class CertificateBatchIrepository {
  DefaultFutureEitherType<List<CertificateDataEntity>>
  getCertificateBatchForCategoryID(
    String institutionID,
    String institutionFacultyID,
    String categoryID,
  );
  DefaultFutureEitherType<void> getIndividualCertificatePDF(
    String categoryName,
    String fileID,
    String categoryID,
  );
  DefaultFutureEitherType<void> getCertificateHTMLPreview(String id);
}
