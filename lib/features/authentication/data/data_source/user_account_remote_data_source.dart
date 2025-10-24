import 'package:dio/dio.dart';
import 'package:flutter_dashboard/core/constants/api_endpoints.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/wrappers/dio_client.dart';
import 'package:flutter_dashboard/features/authentication/data/model/user_account_model.dart';

class UserAccountRemoteDataSource {
  DioClient _dioClient;

  UserAccountRemoteDataSource(this._dioClient);

  Future<UserAccountResponseModel> createUserAccount(
    UserAccountRequestModel userAccountRequest,
  ) async {
    try {
      final response = await _dioClient.dio.post(
        ApiEndpoints.authUser,
        data: userAccountRequest.toJSON(),
      );

      if (response.statusCode == 200) {
        return UserAccountResponseModel.fromJSON(response.data['data']);
      } else {
        throw Errorz(
          message: response.data['message'],
          statusCode: response.data['code'] ?? response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw ServerError(extraMsg: e.message);
    } catch (e) {
      throw Errorz(statusCode: 500, message: e.toString());
    }
  }
}
