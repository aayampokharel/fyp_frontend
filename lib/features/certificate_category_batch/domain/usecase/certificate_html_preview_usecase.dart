import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/entity/certificate_category_entity.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/repository/category_batch_irepository.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/repository/certificate_batch_iresponsibility.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';

class CertificateHTMLPreviewUseCaseParams {
  final String id;
  final String certificateHash;
  CertificateHTMLPreviewUseCaseParams({
    required this.id,
    required this.certificateHash,
  });
}

class CertificateHTMLPreviewUseCase
    implements UseCase<void, CertificateHTMLPreviewUseCaseParams> {
  final CertificateBatchIrepository _certificateBatchIrepository;
  CertificateHTMLPreviewUseCase(this._certificateBatchIrepository);
  @override
  DefaultFutureEitherType<void> call(
    CertificateHTMLPreviewUseCaseParams params,
  ) {
    return _certificateBatchIrepository.getCertificateHTMLPreview(
      params.id,
      params.certificateHash,
    );
  }
}
