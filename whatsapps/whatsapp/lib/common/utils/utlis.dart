// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final commonFireBaseStorageRepository = Provider((ref) =>
    CommonFireBaseStorageRepository(firebaseStorage: FirebaseStorage.instance));

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      image = File(pickImage.path);
    }
  } catch (e) {
    // ignore: use_build_context_synchronously
    showSnackBar(context: context, content: e.toString());
  }
  return image;
}

class CommonFireBaseStorageRepository {
  final FirebaseStorage firebaseStorage;
  CommonFireBaseStorageRepository({
    required this.firebaseStorage,
  });
  Future<String> storeFileToFirebase(
      {required BuildContext context,
      required String ref,
      required File profilePic}) async {
    UploadTask uploadTask =
        firebaseStorage.ref().child(ref).putFile(profilePic);
    TaskSnapshot snap = await uploadTask;
    String downlaodUrl = await snap.ref.getDownloadURL();
    return downlaodUrl;
  }
}
