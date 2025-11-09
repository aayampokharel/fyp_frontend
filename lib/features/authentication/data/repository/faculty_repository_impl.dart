// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/authentication/data/data_source/faculty_remote_data_source.dart';
import 'package:flutter_dashboard/features/authentication/data/model/faculty_model.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/faculty_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/repository/faculty_repository.dart';
import 'package:fpdart/fpdart.dart';

class FacultyRepositoryImpl implements FacultyRepository {
  final FacultyRemoteDataSource _facultyRemoteDataSource;
  FacultyRepositoryImpl(this._facultyRemoteDataSource);

  @override
  DefaultFutureEitherType<FacultyEntity> insertFaculty(
    FacultyEntity facultyEntity,
    String institutionID,
  ) async {
    try {
      FacultyRequestModel facultyRequestModel = FacultyRequestModel.fromEntity(
        facultyEntity,
      );
      AppLogger.info("faculty name" + facultyEntity.facultyName);
      AppLogger.info("faculty name" + facultyRequestModel.facultyName);
      FacultyEntity facultyEntityResponse =
          await _facultyRemoteDataSource.InsertFaculty(facultyRequestModel);
      AppLogger.info(
        "faculty name response" + facultyEntityResponse.facultyName,
      );
      return Right(facultyEntityResponse);
    } on ServerError catch (e) {
      return Left(Errorz(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(Errorz(message: e.toString(), statusCode: e.hashCode));
    }
  }
}
