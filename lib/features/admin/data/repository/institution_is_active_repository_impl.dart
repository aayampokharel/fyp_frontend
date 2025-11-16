import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/admin/data/data_source/admin_is_active_data_source.dart';
import 'package:flutter_dashboard/features/admin/domain/repository/institution_is_active_repository.dart';
import 'package:fpdart/fpdart.dart';

class InstitutionIsActiveAdminRepositoryImpl
    implements InstitutionIsActiveRepository {
  AdminRemoteDataSource _adminRemoteDataSource;

  InstitutionIsActiveAdminRepositoryImpl(this._adminRemoteDataSource);

  @override
  DefaultFutureEitherType<String> updateIsActiveForInstitution(
    String institutionID,
    bool isActive,
  ) async {
    try {
      var res = await _adminRemoteDataSource.UpdateIsActiveForInstitution(
        institutionID,
        isActive,
      );
      return Right(res);
    } on ServerError catch (e) {
      return Left(Errorz(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(Errorz(message: e.toString(), statusCode: e.hashCode));
    }
  }
}
