import 'package:dio/dio.dart';
import 'package:flutter_dashboard/core/constants/api_endpoints.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/wrappers/dio_client.dart';
import 'package:flutter_dashboard/features/admin/data/dto/institution_is_active_dto.dart';
import 'package:flutter_dashboard/features/authentication/data/model/Admin_account_model.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';

import '../../../../core/errors/app_logger.dart' show AppLogger;

class AdminRemoteDataSource {
  final DioClient _dioClient;

  AdminRemoteDataSource(this._dioClient);

  Future<String> UpdateIsActiveForInstitution(
    String institutionID,
    bool isActive,
  ) async {
    try {
      final response = await _dioClient.dio.put(
        ApiEndpoints.adminInstitution,
        data: InstitutionActiveDto(
          institutionId: institutionID,
          isActive: isActive,
        ).toJson(),
        options: Options(
          validateStatus: (status) {
            return status! < 600;
          },
        ),
      );

      if (response.statusCode == 200) {
        return "Institution Updated Successfully!";
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
