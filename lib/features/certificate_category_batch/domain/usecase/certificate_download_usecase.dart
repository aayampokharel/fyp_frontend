import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/repository/certificate_batch_iresponsibility.dart';

class CertificateDownloadPDFUseCaseParams {
  String categoryName;
  String categoryID;
  String fileID;
  bool isDownloadAll;

  CertificateDownloadPDFUseCaseParams({
    required this.categoryName,
    required this.categoryID,
    required this.fileID,
    required this.isDownloadAll,
  });
}

class CertificateDownloadPDFUseCase
    implements UseCase<void, CertificateDownloadPDFUseCaseParams> {
  final CertificateBatchIrepository _certificateBatchIrepository;
  CertificateDownloadPDFUseCase(this._certificateBatchIrepository);
  @override
  DefaultFutureEitherType<void> call(
    CertificateDownloadPDFUseCaseParams params,
  ) {
    AppLogger.info("CertificateDownloadPDFUseCase");
    return _certificateBatchIrepository.getCertificatePDFOrZip(
      params.categoryName,
      params.fileID,
      params.categoryID,
      params.isDownloadAll,
    );
  }
}
