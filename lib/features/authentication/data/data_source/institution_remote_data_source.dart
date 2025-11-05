import 'package:flutter_dashboard/core/constants/api_endpoints.dart';
import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/wrappers/dio_client.dart';
import 'package:flutter_dashboard/features/authentication/data/model/institute_account_model.dart';
import 'package:flutter_dashboard/features/authentication/data/model/institution_model.dart';
import 'package:dio/dio.dart';

class InstitutionRemoteDataSource {
  final DioClient _dioClient;

  InstitutionRemoteDataSource(this._dioClient);
  Future<InstitutionResponseModel> createInstitutionInfo(
    InstitutionRequestModel institutionRequestModel,
  ) async {
    Map<String, dynamic> institutionJSON = institutionRequestModel.toJSON();
    try {
      var response = await _dioClient.dio.post(
        ApiEndpoints.authInstitution,
        data: institutionJSON,
      );

      if (response.statusCode == 200) {
        AppLogger.info(response.data);
        return InstitutionResponseModel.fromJson(response.data['data']);
      } else {
        AppLogger.apiError(
          ApiEndpoints.authInstitution,
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
      throw Errorz(message: e.toString(), statusCode: e.hashCode);
    }
  }

  Future<InstituteAccountResponseModel> verifyAdminLogin(
    InstituteAccountRequestModel instituteAccount,
  ) async {
    try {
      AppLogger.info(instituteAccount);
      final response = await _dioClient.dio.post(
        ApiEndpoints.authInstitutionLogin,
        data: instituteAccount.toJSON(),
        options: Options(
          validateStatus: (status) {
            return status! < 600;
          },
        ),
      );

      if (response.statusCode == 200) {
        AppLogger.info(response.data);
        return InstituteAccountResponseModel.fromJSON(response.data['data']);
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

  Future<InstituteAccountResponseModel> verifyInstituteLogin(
    InstituteAccountRequestModel instituteAccount,
  ) async {
    try {
      AppLogger.info(instituteAccount);
      final response = await _dioClient.dio.post(
        ApiEndpoints.authInstitutionLogin,
        data: instituteAccount.toJSON(),
        options: Options(
          validateStatus: (status) {
            return status! < 600;
          },
        ),
      );

      if (response.statusCode == 200) {
        AppLogger.info(response.data);
        return InstituteAccountResponseModel.fromJSON(response.data['data']);
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
