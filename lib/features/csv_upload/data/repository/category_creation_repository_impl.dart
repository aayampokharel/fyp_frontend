import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/entity/certificate_category_entity.dart';
import 'package:flutter_dashboard/features/csv_upload/data/data_source/category_creation_remote_data_source.dart';
import 'package:flutter_dashboard/features/csv_upload/data/data_source/certificate_list_remote_data_source.dart';
import 'package:flutter_dashboard/features/csv_upload/data/models/create_category_dto.dart';
import 'package:flutter_dashboard/features/csv_upload/data/models/minimal_certificate_data_model.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/repository/category_creation_irepository.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/repository/file_upload_irepository.dart';
import 'package:fpdart/fpdart.dart';

class CategoryCreationRepositoryImpl implements CategoryCreationIRepository {
  final CategoryCreationRemoteDataSource _categoryCreationRemoteDataSource;

  CategoryCreationRepositoryImpl(this._categoryCreationRemoteDataSource);

  @override
  DefaultFutureEitherType<CertificateCategoryEntity> categoryCreation(
    String facultyName,
    String preferredCategoryName,
    String institutionId,
    String institutionFacultyId,
  ) async {
    try {
      final response = await _categoryCreationRemoteDataSource
          .createCertificateCategory(
            CreatePDFCategoryDto(
              facultyName: facultyName,
              preferredCategoryName: preferredCategoryName,
              institutionId: institutionId,
              institutionFacultyId: institutionFacultyId,
            ),
          );
      final responseEntity = response.toEntity(
        institutionID: institutionId,
        institutionFacultyID: institutionFacultyId,
      );
      return Right(responseEntity);
    } on ServerError catch (e) {
      AppLogger.error(e.message);
      return Left(Errorz(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      AppLogger.error(e.toString());
      return Left(Errorz(message: e.toString(), statusCode: e.hashCode));
    }
  }
}
