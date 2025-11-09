import 'package:dio/dio.dart';
import 'package:flutter_dashboard/core/constants/api_endpoints.dart';
import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/wrappers/dio_client.dart';
import 'package:flutter_dashboard/features/authentication/data/model/faculty_model.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/faculty_entity.dart';

class FacultyRemoteDataSource {
  final DioClient _dioClient;
  FacultyRemoteDataSource(this._dioClient);

  Future<FacultyEntity> InsertFaculty(
    FacultyRequestModel facultyRequestModel,
  ) async {
    try {
      AppLogger.info("data source" + facultyRequestModel.facultyName);
      final response = await _dioClient.dio.post(
        ApiEndpoints.authFaculty,
        data: facultyRequestModel.toJSON(),
      );
      if (response.statusCode == 200) {
        var facultyEntityObj = facultyRequestModel.toEntity();
        AppLogger.info("data source" + facultyEntityObj.facultyName);
        return FacultyEntity.fromJSON(
          response.data['data'] as Map<String, dynamic>,
        );
      } else {
        throw Errorz(
          message: response.data['message'] ?? "Error:",
          statusCode: response.data['code'] ?? response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw ServerError(extraMsg: e.message);
    } catch (e) {
      throw Errorz(message: e.toString(), statusCode: e.hashCode);
    }
  }
}
