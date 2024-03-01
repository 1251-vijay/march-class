import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/utils/colors.dart';
import 'package:whatsapp/common/utils/utlis.dart';
import 'package:whatsapp/features/controller/auth_controller.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  static const String routeName = "user-screen";
  const UserInformationScreen({super.key});

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final namecontroller = TextEditingController();
  File? image;
  void pickedimage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void saveDataToFireStore() {
    String name = namecontroller.text.trim();
    ref
        .read(authControllerProvider)
        .saveUserDataToFireStore(context, name, image!);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
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
                    bottom: -10,
                    left: 50,
                    child: IconButton(
                      onPressed: pickedimage,
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: size.width * 0.85,
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: namecontroller,
                      cursorColor: greyColor,
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: greyColor)),
                        hintText: 'Enter Name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: IconButton(
                        onPressed: saveDataToFireStore,
                        icon: const Icon(Icons.done)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
