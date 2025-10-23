import 'package:flutter_dashboard/core/constants/api_endpoints.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/wrappers/dio_client.dart';
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
        ApiEndpoints.institution,
        data: institutionJSON,
      );

      if (response.statusCode == 200) {
        print(response.data);
        return InstitutionResponseModel.fromJson(response.data);
      } else {
        throw Errorz(
          message: response.data['message'],
          code: response.data['code'] ?? response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw ServerError(extraMsg: e.message);
    } catch (e) {
      throw Errorz(message: e.toString(), code: e.hashCode);
    }
  }
}
