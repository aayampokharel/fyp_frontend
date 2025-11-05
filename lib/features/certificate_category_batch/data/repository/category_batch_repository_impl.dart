import 'package:flutter/foundation.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/data/data_source/category_batch_remote_data_source.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/entity/certificate_category_entity.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/repository/category_batch_irepository.dart';
import 'package:fpdart/fpdart.dart';

class CategoryBatchRepositoryImpl implements CategoryBatchIrepository {
  CategoryBatchRemoteDataSource _categoryBatchRemoteDataSource;

  CategoryBatchRepositoryImpl(this._categoryBatchRemoteDataSource);
  @override
  DefaultFutureEitherType<List<CertificateCategoryEntity>> getCategoryBatch(
    String institutionID,
    String institutionFacultyID,
  ) async {
    try {
      final response = await _categoryBatchRemoteDataSource.getCategoryBatch(
        institutionID,
        institutionFacultyID,
      );
      return Right(response);
    } on ServerError catch (e) {
      return Left(Errorz(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(Errorz(message: e.toString(), statusCode: e.hashCode));
    }
  }
}
