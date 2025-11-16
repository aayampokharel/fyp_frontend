import 'package:flutter/foundation.dart';
import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/data/data_source/category_batch_remote_data_source.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/data/data_source/certificate_batch_remote_data_source.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/entity/certificate_category_entity.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/repository/category_batch_irepository.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/repository/certificate_batch_iresponsibility.dart';
import 'package:flutter_dashboard/features/csv_upload/data/data_source/certificate_list_remote_data_source.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';
import 'package:fpdart/fpdart.dart';

class CertificateBatchRepositoryImpl implements CertificateBatchIrepository {
  final CertificateBatchRemoteDataSource _certificateBatchRemoteDataSource;

  CertificateBatchRepositoryImpl(this._certificateBatchRemoteDataSource);

  @override
  DefaultFutureEitherType<List<CertificateDataEntity>>
  getCertificateBatchForCategoryID(
    String institutionID,
    String institutionFacultyID,
    String categoryID,
  ) async {
    try {
      final response = await _certificateBatchRemoteDataSource
          .getCertificateBatch(institutionID, institutionFacultyID, categoryID);
      return Right(response);
    } on ServerError catch (e) {
      return Left(Errorz(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(Errorz(message: e.toString(), statusCode: e.hashCode));
    }
  }

  @override
  DefaultFutureEitherType<void> getCertificatePDFOrZip(
    String categoryName,
    String fileID,
    String categoryID,
    bool downloadAll,
  ) async {
    try {
      AppLogger.debug(
        "categoryName: $categoryName, fileID: $fileID, categoryID: $categoryID, downloadAll: $downloadAll",
      );
      final response = await _certificateBatchRemoteDataSource
          .downloadCertificatePDFOrZip(
            categoryName,
            categoryID,
            fileID,
            downloadAll,
          );
      return Right(response);
    } on ServerError catch (e) {
      return Left(Errorz(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(Errorz(message: e.toString(), statusCode: e.hashCode));
    }
  }

  @override
  DefaultFutureEitherType<void> getCertificateHTMLPreview(
    String id,
    String hash,
  ) async {
    try {
      AppLogger.debug("id: $id");
      final response = await _certificateBatchRemoteDataSource
          .getCertificateHTMLPreview(id, hash);
      return Right(response);
    } on ServerError catch (e) {
      return Left(Errorz(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(Errorz(message: e.toString(), statusCode: e.hashCode));
    }
  }
}
