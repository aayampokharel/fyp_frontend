import 'package:dio/dio.dart';
import 'package:flutter_dashboard/core/constants/api_endpoints.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/wrappers/dio_client.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/entity/certificate_category_entity.dart';
import 'package:flutter_dashboard/features/csv_upload/data/models/create_category_dto.dart';

class CategoryCreationRemoteDataSource {
  final DioClient _dioClient;
  CategoryCreationRemoteDataSource(this._dioClient);

  Future<CreatePDFCategoryResponseDto> createCertificateCategory(
    CreatePDFCategoryDto request,
  ) async {
    try {
      var response = await _dioClient.dio.post(
        ApiEndpoints.baseUrl + ApiEndpoints.postcategory,
        data: request.toJson(),
      );

      if (response.statusCode != 200) {
        throw Errorz(
          message: response.data['message'],
          statusCode: response.data['code'] ?? response.statusCode,
        );
      } else {
        return CreatePDFCategoryResponseDto.fromJson(response.data['data']);
      }
    } on DioException catch (e) {
      throw ServerError(extraMsg: e.message);
    } catch (e) {
      throw Errorz(message: e.toString(), statusCode: e.hashCode);
    }
  }
}
