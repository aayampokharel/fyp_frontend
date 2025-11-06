import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/authentication/data/data_source/institution_remote_data_source.dart';
import 'package:flutter_dashboard/features/authentication/data/model/institute_account_model.dart';
import 'package:flutter_dashboard/features/authentication/data/model/institution_model.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institute_account_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/repository/institution_repository.dart';
import 'package:fpdart/src/either.dart';

class InstitutionRepositoryImpl implements InstitutionRepository {
  final InstitutionRemoteDataSource _institutionRemoteDataSource;

  InstitutionRepositoryImpl(this._institutionRemoteDataSource);
  @override
  DefaultFutureEitherType<InstitutionEntity> sendInstitutionInfo(
    String institutionName,
    int wardNumber,
    String toleAddress,
    String districtAddress,
  ) async {
    try {
      InstitutionRequestModel institutionRequestModel = InstitutionRequestModel(
        institutionName: institutionName,
        wardNumber: wardNumber,
        toleAddress: toleAddress,
        districtAddress: districtAddress,
      );

      InstitutionResponseModel institutionResponseModel =
          await _institutionRemoteDataSource.createInstitutionInfo(
            institutionRequestModel,
          );

      AppLogger.info(institutionResponseModel.toString());
      InstitutionEntity institutionEntity = institutionResponseModel.toEntity(
        institutionName,
        wardNumber,
        toleAddress,
        districtAddress,
      );
      AppLogger.info(institutionEntity.toString());
      return Right(institutionEntity);
    } on ServerError catch (e) {
      AppLogger.error(e.message);
      return Left(Errorz(message: e.message, statusCode: e.statusCode));
    } on WarnError catch (e) {
      AppLogger.error(e.message);
      return Left(Errorz(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      AppLogger.error(e.toString());
      return Left(Errorz(message: e.toString(), statusCode: e.hashCode));
    }
  }

  @override
  DefaultFutureEitherType<InstituteAccountEntity> instituteLogin({
    required String email,
    required String password,
  }) async {
    try {
      InstituteAccountRequestModel userAccountRequest =
          InstituteAccountRequestModel(password: password, email: email);

      final InstituteAccountResponseModel responseModel =
          await _institutionRemoteDataSource.verifyAdminLogin(
            userAccountRequest,
          );

      AppLogger.info(responseModel.toString());

      InstituteAccountEntity instituteAccountEntityFromModel = responseModel
          .toEntity(email);

      AppLogger.info(instituteAccountEntityFromModel.toString());
      return Right(instituteAccountEntityFromModel);
    } on ServerError catch (e) {
      AppLogger.error(e.message);
      return Left(Errorz(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      AppLogger.error(e.toString());
      return Left(Errorz(message: e.toString(), statusCode: e.hashCode));
    }
  }
}
