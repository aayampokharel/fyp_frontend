import 'package:dio/dio.dart';
import 'package:flutter_dashboard/core/constants/api_endpoints.dart';
import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/wrappers/dio_client.dart';
import 'package:flutter_dashboard/features/csv_upload/data/models/create_certificate_data_request.dart';
import 'package:flutter_dashboard/features/csv_upload/data/models/minimal_certificate_data_model.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';

class CertificateListRemoteDataSource {
  final DioClient _dioClient;
  CertificateListRemoteDataSource(this._dioClient);

  Future<String> uploadCertificateListEntity(
    List<MinimalCertificateDataModel> certificateDataList,
    String instituitonID,
    String institutionFacultyID,
    String institutionFacultyName,
    String categoryID,
    String categoryName,
  ) async {
    try {
      AppLogger.info("to be sent");
      var response = await _dioClient.dio.post(
        ApiEndpoints.certificatesupload,
        data: CreateCertificateDataRequest(
          institutionId: instituitonID,
          institutionFacultyId: institutionFacultyID,
          institutionFacultyName: institutionFacultyName,
          categoryId: categoryID,
          categoryName: categoryName,
          certificateData: certificateDataList,
        ).toJson(),
      );

      if (response.statusCode != 200) {
        throw Errorz(
          message: response.data['message'],
          statusCode: response.data['code'] ?? response.statusCode,
        );
      } else {
        return (response.data['data'] as Map<String, dynamic>)['message'];
      }
    } on DioException catch (e) {
      throw ServerError(extraMsg: e.message);
    } catch (e) {
      throw Errorz(message: e.toString(), statusCode: e.hashCode);
    }
  }
}
