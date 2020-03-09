import 'package:image_picker/image_picker.dart';
import 'package:zefyr/zefyr.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class CustomImageDelegate implements ZefyrImageDelegate<ImageSource> {
  @override
  ImageSource get cameraSource => ImageSource.camera;

  @override
  ImageSource get gallerySource => ImageSource.gallery;

  @override
  Future<String> pickImage(ImageSource source) async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
    print("mod-writer, image found: ${file.uri.toString()}");
    if (file == null) return null;
    return file.uri.toString();
  }

  @override
  Widget buildImage(BuildContext context, String key) {
    print("mod-writer, buildImage: ${key}");
    // We use custom "asset" scheme to distinguish asset images from other files.
    if (key.startsWith('asset://')) {
      final asset = AssetImage(key.replaceFirst('asset://', ''));
      return Image(image: asset);
    } else {
      // Otherwise assume this is a file stored locally on user's device.
      final file = File.fromUri(Uri.parse(key));
      final image = FileImage(file);
      return Image(image: image);
    }
  }
}
