import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_dashboard/core/constants/api_endpoints.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/wrappers/dio_client.dart';
import 'package:flutter_dashboard/features/authentication/data/model/send_image_file_request_dto.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class RemoveBackgroundDataSource {
  DioClient _dioClient;

  RemoveBackgroundDataSource(this._dioClient);
  Future<Uint8List> removeBackground(Uint8List originalImage) async {
    try {
      final response = await _dioClient.dio.post(
        ApiEndpoints.removeBackground,
        data: SendImageFileRequestDto(
          imageName: "photo.png",
          imageBase64: base64Encode(originalImage),
        ).toJSON(),
        options: Options(
          responseType: ResponseType.bytes,
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
        ),
      );

      if (response.statusCode == 200) {
        final imgasListInt = await response.data;

        if (imgasListInt.isEmpty) {
          throw Errorz(
            statusCode: response.statusCode ?? 500,
            message: "Received empty image data",
          );
        }

        try {
          Uint8List processedImage = Uint8List.fromList(imgasListInt);
          return processedImage;
        } catch (e) {
          throw Errorz(
            statusCode: response.statusCode ?? 500,
            message: "Invalid image data received: $e",
          );
        }
      } else {
        throw ServerError(
          extraMsg:
              "Request failed: (${response.statusMessage ?? "Unknown"}) ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Errorz(
        message: "Request failed: (${e.toString()})",
        statusCode: e.hashCode,
      );
    }
  }
}
