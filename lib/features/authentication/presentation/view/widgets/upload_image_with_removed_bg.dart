import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard/features/authentication/presentation/view_model/authentication_bloc.dart';
import 'package:flutter_dashboard/features/authentication/presentation/view_model/authentication_event.dart';
import 'package:flutter_dashboard/features/authentication/presentation/view_model/authentication_state.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageWithRemovedBg extends StatefulWidget {
  final String labelName;
  const UploadImageWithRemovedBg({super.key, required this.labelName});

  @override
  State<UploadImageWithRemovedBg> createState() =>
      _UploadImageWithRemovedBgState();
}

class _UploadImageWithRemovedBgState extends State<UploadImageWithRemovedBg> {
  Uint8List? _originalImage;
  Uint8List? _processedImage;
  bool _loading = false;
  String? _error;

  final ImagePicker _picker = ImagePicker();
  // final String apiUrl = "http://localhost:8080/remove-bg";

  Future<XFile?> pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      return picked;
    } else {
      return null;
    }
  }

  Widget imageBox(Uint8List? img, String label) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is SendImageForBackgroundRemovalFailureState) {
          return Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Text(state.errorMsg)),
          );
        } else if (state is SendImageForBackgroundRemovalSuccessState) {
          return Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.memory(
              state.imageIntList,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Text("Failed to load image"));
              },
            ),
          );
        } else if (state is SendImageForBackgroundRemovalLoadingState) {
          return Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(child: Text("no image selected!")),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          if (_error != null)
            Container(
              padding: EdgeInsets.all(8),
              color: Colors.red[100],
              child: Text(_error!, style: TextStyle(color: Colors.red)),
            ),

          Column(
            children: [
              Text(
                widget.labelName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              imageBox(_processedImage, "No Result"),
            ],
          ),

          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              pickImage().then((val) {
                context.read<AuthenticationBloc>().add(
                  SendImageForBackgroundRemovalEvent(pickerImageFile: val),
                );
              });
            },
            child: Text("Pick Image"),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
