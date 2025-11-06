import 'package:dio/dio.dart';
import 'package:flutter_dashboard/core/constants/api_endpoints.dart';
import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/wrappers/dio_client.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/faculty_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_faculty_entity.dart';
import 'package:flutter_dashboard/features/csv_upload/data/models/create_certificate_data_request.dart';
import 'package:flutter_dashboard/features/csv_upload/data/models/minimal_certificate_data_model.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/usecase/check_institution_is_active_usecase.dart';

class InstitutionIsActiveRemoteDataSource {
  final DioClient _dioClient;
  InstitutionIsActiveRemoteDataSource(this._dioClient);

  Future<InstitutionWithFacultiesEntity> CheckInstitutionIsActive(
    String instituitonID,
  ) async {
    try {
      var response = await _dioClient.dio.get(
        ApiEndpoints.baseUrl + ApiEndpoints.authVerifyInstitution,
        queryParameters: {ApiEndpoints.institutionIDQuery: instituitonID},
      );
      AppLogger.info(response.data.toString());
      if (response.statusCode != 200) {
        AppLogger.error(response.data.toString());
        throw Errorz(
          message: response.data['message'],
          statusCode: response.data['code'] ?? response.statusCode,
        );
      } else {
        AppLogger.info(response.data['data'].toString());
        final data = response.data['data'] as Map<String, dynamic>;
        final institution = InstitutionEntity.fromJSON(data);
        final facultiesList = (data['faculties_list'] as List)
            .map((facultyJson) => FacultyEntity.fromJSON(facultyJson))
            .toList();

        return InstitutionWithFacultiesEntity(
          institution: institution,
          faculties: facultiesList,
        );
      }
    } on DioException catch (e) {
      throw ServerError(extraMsg: e.message);
    } catch (e) {
      throw Errorz(message: e.toString(), statusCode: e.hashCode);
    }
  }
}
