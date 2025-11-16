// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/authentication/data/data_source/admin_remote_data_source.dart';
import 'package:flutter_dashboard/features/authentication/data/model/Admin_account_model.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/admin_account_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/repository/admin_repository.dart';
import 'package:fpdart/fpdart.dart';

class AdminAccountRepositoryImpl implements AdminAccountRepository {
  final AdminAccountRemoteDataSource _adminAccountRemoteDataSource;
  AdminAccountRepositoryImpl(this._adminAccountRemoteDataSource);

  @override
  DefaultFutureEitherType<AdminDashboardCountsEntity> adminLogin({
    required String email,
    required String password,
  }) async {
    try {
      AdminAccountRequestModel userAccountRequest = AdminAccountRequestModel(
        password: password,
        email: email,
      );

      final AdminDashboardCountsResponseModel responseModel =
          await _adminAccountRemoteDataSource.verifyAdminLogin(
            userAccountRequest,
          );

      AppLogger.info(responseModel.toString());

      AdminDashboardCountsEntity adminAccountEntityFromModel = responseModel
          .toEntity();

      AppLogger.info(adminAccountEntityFromModel.toString());
      return Right(adminAccountEntityFromModel);
    } on ServerError catch (e) {
      AppLogger.error(e.message);
      return Left(Errorz(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      AppLogger.error(e.toString());
      return Left(Errorz(message: e.toString(), statusCode: e.hashCode));
    }
  }
}
