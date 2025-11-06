import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/entity/certificate_category_entity.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/repository/category_batch_irepository.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/repository/certificate_batch_iresponsibility.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';

class CertificateHTMLPreviewUseCase implements UseCase<void, String> {
  final CertificateBatchIrepository _certificateBatchIrepository;
  CertificateHTMLPreviewUseCase(this._certificateBatchIrepository);
  @override
  DefaultFutureEitherType<void> call(String id) {
    return _certificateBatchIrepository.getCertificateHTMLPreview(id);
  }
}
