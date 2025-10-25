// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_dashboard/core/constants/enum.dart';
import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/authentication/data/data_source/user_account_remote_data_source.dart';
import 'package:flutter_dashboard/features/authentication/data/model/user_account_model.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/user_account_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/repository/user_account_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserAccountRepositoryImpl implements UserAccountRepository {
  final UserAccountRemoteDataSource _userAccountRemoteDataSource;
  UserAccountRepositoryImpl(this._userAccountRemoteDataSource);

  @override
  DefaultFutureEitherType<UserAccountEntity> createNewUserAccount({
    required UserAccountEntityParams params,
  }) async {
    try {
      UserAccountRequestModel userAccountRequest = UserAccountRequestModel(
        institutionID: params.institutionID,
        password: params.password,
        institutionRole: params.institutionRole,
        systemRole: systemRoletoString(params.systemRole),
        institutionLogoBase64: params.institutionLogoBase64,
        userEmail: params.email,
      );

      final UserAccountResponseModel responseModel =
          await _userAccountRemoteDataSource.createUserAccount(
            userAccountRequest,
          );

      AppLogger.info(responseModel.toString());

      UserAccountEntity userAccountEntityFromModel = responseModel.toEntity(
        params.systemRole,
        params.institutionRole,
        params.email,
      );
      AppLogger.info(userAccountEntityFromModel.toString());
      return Right(userAccountEntityFromModel);
    } on ServerError catch (e) {
      AppLogger.error(e.message);
      return Left(Errorz(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      AppLogger.error(e.toString());
      return Left(Errorz(message: e.toString(), statusCode: e.hashCode));
    }
  }
}
