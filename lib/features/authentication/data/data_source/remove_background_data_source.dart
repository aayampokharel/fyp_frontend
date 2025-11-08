import 'dart:typed_data';
import 'package:flutter_dashboard/core/constants/api_endpoints.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class RemoveBackgroundDataSource {
  Future<Uint8List> removeBackground(Uint8List originalImage) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.removeBackground),
      );
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          originalImage,
          filename: 'photo.png',
          contentType: MediaType('image', 'png'),
        ),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        final imgBytes = await response.stream.toBytes();

        if (imgBytes.isEmpty) {
          throw Errorz(
            statusCode: response.statusCode,
            message: "Received empty image data",
          );
        }

        try {
          Uint8List _processedImage = imgBytes;
          return _processedImage;
        } catch (e) {
          throw Errorz(
            statusCode: response.statusCode,
            message: "Invalid image data received: $e",
          );
        }
      } else {
        throw ServerError(
          extraMsg:
              "Request failed: (${response.reasonPhrase}) ${response.statusCode}",
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
