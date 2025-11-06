import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/repository/certificate_batch_iresponsibility.dart';

class IndividualCertificateDownloadPDFUseCaseParams {
  String categoryName;
  String categoryID;
  String fileID;

  IndividualCertificateDownloadPDFUseCaseParams({
    required this.categoryName,
    required this.categoryID,
    required this.fileID,
  });
}

class IndividualCertificateDownloadPDFUseCase
    implements UseCase<void, IndividualCertificateDownloadPDFUseCaseParams> {
  final CertificateBatchIrepository _certificateBatchIrepository;
  IndividualCertificateDownloadPDFUseCase(this._certificateBatchIrepository);
  @override
  DefaultFutureEitherType<void> call(
    IndividualCertificateDownloadPDFUseCaseParams params,
  ) {
    AppLogger.info("IndividualCertificateDownloadPDFUseCase");
    return _certificateBatchIrepository.getIndividualCertificatePDF(
      params.categoryName,
      params.fileID,
      params.categoryID,
    );
  }
}
