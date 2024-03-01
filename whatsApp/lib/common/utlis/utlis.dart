// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final commonAuthRepository = Provider(
    (ref) => CommonAuthRepository(firebaseStorage: FirebaseStorage.instance));

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickimage != null) {
      image = File(pickimage.path);
    }
  } catch (e) {
    // ignore: use_build_context_synchronously
    showSnackBar(context, e.toString());
  }
  return image;
}

class CommonAuthRepository {
  final FirebaseStorage firebaseStorage;
  CommonAuthRepository({
    required this.firebaseStorage,
  });

  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadurl = await snapshot.ref.getDownloadURL();
    return downloadurl;
  }
}

Future<File?> pickedVideoFromGallery() async {
  File? video;
  final pickedVideo =
      await ImagePicker().pickVideo(source: ImageSource.gallery);
  if (pickedVideo != null) {
    video = File(pickedVideo.path);
  }
  return video;
}
