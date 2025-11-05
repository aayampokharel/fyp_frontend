import 'package:dio/dio.dart';
import 'package:flutter_dashboard/core/constants/api_endpoints.dart';
import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/wrappers/dio_client.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';
import 'package:flutter_dashboard/features/csv_upload/data/models/create_certificate_data_request.dart';
import 'package:flutter_dashboard/features/csv_upload/data/models/minimal_certificate_data_model.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/usecase/check_institution_is_active_usecase.dart';

class InstitutionIsActiveRemoteDataSource {
  DioClient _dioClient;
  InstitutionIsActiveRemoteDataSource(this._dioClient);

  Future<InstitutionEntity> CheckInstitutionIsActive(
    String instituitonID,
  ) async {
    try {
      var response = await _dioClient.dio.get(
        ApiEndpoints.baseUrl + ApiEndpoints.authVerifyInstitution,
        queryParameters: {ApiEndpoints.institutionIDQuery: instituitonID},
      );
      AppLogger.error(response.data.toString());
      if (response.statusCode != 200) {
        AppLogger.error(response.data.toString());
        throw Errorz(
          message: response.data['message'],
          statusCode: response.data['code'] ?? response.statusCode,
        );
      } else {
        AppLogger.error(response.data['data'].toString());
        return InstitutionEntity.fromJSON(
          response.data['data'] as Map<String, dynamic>,
        );
      }
    } on DioException catch (e) {
      throw ServerError(extraMsg: e.message);
    } catch (e) {
      throw Errorz(message: e.toString(), statusCode: e.hashCode);
    }
  }
}
