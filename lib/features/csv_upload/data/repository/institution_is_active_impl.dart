import 'package:dio/dio.dart';
import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';
import 'package:flutter_dashboard/features/csv_upload/data/data_source/certificate_list_remote_data_source.dart';
import 'package:flutter_dashboard/features/csv_upload/data/data_source/institution_is_active_data_source.dart';
import 'package:flutter_dashboard/features/csv_upload/data/models/minimal_certificate_data_model.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/repository/file_upload_irepository.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/repository/institution_is_active_irepository.dart';
import 'package:fpdart/fpdart.dart';

class InstitutionIsActiveRepositoryImpl
    implements InstitutionIsActiveIrepository {
  final InstitutionIsActiveRemoteDataSource
  _institutionIsActiveRemoteDataSource;

  InstitutionIsActiveRepositoryImpl(this._institutionIsActiveRemoteDataSource);

  @override
  DefaultFutureEitherType<InstitutionEntity> checkIsActiveForCurrentInstitution(
    String instituitonID,
  ) async {
    try {
      final response =
          await _institutionIsActiveRemoteDataSource.CheckInstitutionIsActive(
            instituitonID,
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
