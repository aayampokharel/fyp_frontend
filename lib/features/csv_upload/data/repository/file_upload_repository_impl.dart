import 'package:dio/dio.dart';
import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/csv_upload/data/data_source/certificate_list_remote_data_source.dart';
import 'package:flutter_dashboard/features/csv_upload/data/models/minimal_certificate_data_model.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/repository/file_upload_irepository.dart';
import 'package:fpdart/fpdart.dart';

class FileUploadRepositoryImpl implements FileUploadIrepository {
  CertificateListRemoteDataSource _certificateListRemoteDataSource;

  FileUploadRepositoryImpl(this._certificateListRemoteDataSource);

  @override
  DefaultFutureEitherType<String> uploadCSVFileAsEntityList(
    List<CertificateDataEntity> certificateDataList,
    String instituitonID,
    String institutionFacultyID,
    String institutionFacultyName,
    String categoryID,
    String categoryName,
  ) async {
    try {
      List<MinimalCertificateDataModel> minimalCertificateDataModelList =
          certificateDataList.map((element) => element.toModel()).toList();

      final response = await _certificateListRemoteDataSource
          .uploadCertificateListEntity(
            minimalCertificateDataModelList,
            instituitonID,
            institutionFacultyID,
            institutionFacultyName,
            categoryID,
            categoryName,
          );
      return Right(response);
    } on ServerError catch (e) {
      AppLogger.error(e.message);
      return Left(Errorz(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      AppLogger.error(e.toString());
      return Left(Errorz(message: e.toString(), statusCode: e.hashCode));
    }
  }
}
