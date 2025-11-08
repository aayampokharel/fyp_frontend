import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
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

  final FilePicker _picker = FilePicker.platform;
  // final String apiUrl = "http://localhost:8080/remove-bg";

  Future<FilePickerResult?> pickImage() async {
    final picked = await _picker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'webp'],
      compressionQuality: 50,
      withData: true,
    );
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
          return imageContainer(
            child: Image.memory(
              state.imageIntList,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Text("Failed to load image"));
              },
            ),
          );
        } else if (state is SendImageForBackgroundRemovalLoadingState) {
          return imageContainer(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return imageContainer(child: Center(child: Text("no image selected!")));
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

          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is SendImageForBackgroundRemovalLoadingState) {
                return elevatedContainerState(onTap: null);
              }
              return elevatedContainerState(
                onTap: () {
                  pickImage().then((val) {
                    if (val != null && val.files.isNotEmpty) {
                      context.read<AuthenticationBloc>().add(
                        SendImageForBackgroundRemovalEvent(
                          pickerImageFile: val.files.first,
                        ),
                      );
                    }
                  });
                },
              );
            },
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget imageContainer({required Widget child}) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }

  Widget elevatedContainerState({required void Function()? onTap}) {
    return ElevatedButton(onPressed: onTap, child: Text("Pick Image"));
  }
}
