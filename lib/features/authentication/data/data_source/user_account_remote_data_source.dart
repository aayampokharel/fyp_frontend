import 'package:dio/dio.dart';
import 'package:flutter_dashboard/core/constants/api_endpoints.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/wrappers/dio_client.dart';
import 'package:flutter_dashboard/features/authentication/data/model/user_account_model.dart';

import '../../../../core/errors/app_logger.dart' show AppLogger;

class UserAccountRemoteDataSource {
  final DioClient _dioClient;

  UserAccountRemoteDataSource(this._dioClient);

  Future<UserAccountResponseModel> createUserAccount(
    UserAccountRequestModel userAccountRequest,
  ) async {
    try {
      AppLogger.info(userAccountRequest.toJSON());
      final response = await _dioClient.dio.post(
        ApiEndpoints.authUser,
        data: userAccountRequest.toJSON(),
        options: Options(
          validateStatus: (status) {
            return status! < 600;
          },
        ),
      );

      if (response.statusCode == 200) {
        AppLogger.info(response.data);
        return UserAccountResponseModel.fromJSON(response.data['data']);
      } else {
        AppLogger.apiError(
          ApiEndpoints.authUser,
          response.data['code'] ?? response.statusCode,
          response.data['message'],
        );
        throw Errorz(
          message: response.data['message'],
          statusCode: response.data['code'] ?? response.statusCode,
        );
      }
    } on DioException catch (e) {
      AppLogger.error("Dio Exception: ${e.message}");
      throw ServerError(extraMsg: e.message);
    } catch (e) {
      AppLogger.error("Other Exception: ${e.toString()}");
      throw Errorz(statusCode: 500, message: e.toString());
    }
  }
}
