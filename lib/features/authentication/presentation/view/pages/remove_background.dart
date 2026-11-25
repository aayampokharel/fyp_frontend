import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class RemoveBgDemo extends StatefulWidget {
  @override
  _RemoveBgDemoState createState() => _RemoveBgDemoState();
}

class _RemoveBgDemoState extends State<RemoveBgDemo> {
  Uint8List? _originalImage;
  Uint8List? _processedImage;
  bool _loading = false;
  String? _error;

  final ImagePicker _picker = ImagePicker();
  // For web: use localhost or your actual server IP
  final String apiUrl = "http://localhost:8080/remove-bg";

  Future<void> pickImage() async {
    try {
      final picked = await _picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        final bytes = await picked.readAsBytes();
        setState(() {
          _originalImage = bytes;
          _processedImage = null;
          _error = null;
        });
      }
    } catch (e) {
      setState(() => _error = "Failed to pick image: $e");
    }
  }

  Future<void> removeBackground() async {
    if (_originalImage == null) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          _originalImage!,
          filename: 'photo.png',
          contentType: MediaType('image', 'png'),
        ),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        final imgBytes = await response.stream.toBytes();

        // Verify we actually got image data
        if (imgBytes.isEmpty) {
          setState(() => _error = "Received empty image data");
          return;
        }

        // Try to create an image from the bytes to verify it's valid
        try {
          final image = Image.memory(imgBytes);
          setState(() => _processedImage = imgBytes);
        } catch (e) {
          setState(() => _error = "Invalid image data received: $e");
        }
      } else {
        setState(() => _error = "Server error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => _error = "Request failed: $e");
      print("Full error: $e");
    }

    setState(() => _loading = false);
  }

  Widget imageBox(Uint8List? img, String label) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: img != null
          ? Image.memory(
              img,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Text("Failed to load image"));
              },
            )
          : Center(child: Text(label)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Remove BG Demo")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_error != null)
              Container(
                padding: EdgeInsets.all(8),
                color: Colors.red[100],
                child: Text(_error!, style: TextStyle(color: Colors.red)),
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Original",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    imageBox(_originalImage, "No Image"),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Processed",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    imageBox(_processedImage, "No Result"),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: pickImage, child: Text("Pick Image")),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _originalImage != null && !_loading
                      ? removeBackground
                      : null,
                  child: _loading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : Text("Remove Background"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
