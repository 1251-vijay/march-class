import 'dart:io';

import 'package:chating_app/common/utlis/utlis.dart';
import 'package:chating_app/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  static const routeName = 'user-info';
  const UserInformationScreen({super.key});

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final usernameController = TextEditingController();
  File? image;

  void pickedImage() async {
    image = await pickImageFromGallery(context);

    setState(() {});
  }

  void saveUserDataFireStore() {
    String name = usernameController.text.trim();
    ref
        .read(authControllerProvider)
        .saveUserDataFireStore(context, name, image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              image == null
                  ? const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          "https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png"),
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(image!),
                    ),
              Positioned(
                bottom: 0,
                right: 2,
                top: 65,
                left: 60,
                child: IconButton(
                    onPressed: pickedImage,
                    icon: const Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    )),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                // margin: EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    hintText: "Username",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: saveUserDataFireStore,
                  icon: const Icon(Icons.done))
            ],
          )
        ],
      )),
    );
  }
}
