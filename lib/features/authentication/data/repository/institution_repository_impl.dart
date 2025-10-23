import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/authentication/data/data_source/institution_remote_data_source.dart';
import 'package:flutter_dashboard/features/authentication/data/model/institution_model.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/repository/institution_repository.dart';
import 'package:fpdart/src/either.dart';

class InstitutionRepositoryImpl implements InstitutionRepository {
  InstitutionRemoteDataSource _institutionRemoteDataSource;

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
      InstitutionEntity institutionEntity = institutionResponseModel.toEntity(
        institutionName,
        wardNumber,
        toleAddress,
        districtAddress,
      );
      return Right(institutionEntity);
    } on ServerError catch (e) {
      return Left(Errorz(message: e.message, code: e.code));
    } on WarnError catch (e) {
      // print(e.toString());
      return Left(Errorz(message: e.message, code: e.code));
    } catch (e) {
      return Left(Errorz(message: e.toString(), code: e.hashCode));
    }
  }
}
