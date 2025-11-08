class SendImageFileRequestDto {
  String imageName;
  String imageBase64;

  SendImageFileRequestDto({required this.imageName, required this.imageBase64});

  Map<String, dynamic> toJSON() {
    return {'image_name': imageName, 'image_base64': imageBase64};
  }
}
