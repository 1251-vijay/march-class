import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/utlis/colors.dart';
import 'package:whatsapp/common/utlis/utlis.dart';
import 'package:whatsapp/features/auth/controllers/auth_contoller.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  static const String routeName = "user-inforamtion";
  const UserInformationScreen({super.key});

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  File? image;
  final namecontroller = TextEditingController();

  void imagePicker() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void saveDataToFireStore() {
    String name = namecontroller.text.trim();
    ref.read(authController).saveDataToFireStore(
          context,
          name,
          image!,
        );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SafeArea(
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
                    left: 75,
                    bottom: 5,
                    child: InkWell(
                        onTap: () {
                          imagePicker();
                        },
                        child: const Icon(Icons.add_a_photo)))
              ],
            ),
            Row(children: [
              Container(
                width: size.width * 0.85,
                padding: const EdgeInsets.all(30),
                child: TextField(
                  controller: namecontroller,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: greyColor)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: greyColor)),
                    hintText: "Enter your name",
                  ),
                ),
              ),
              IconButton(
                  onPressed: saveDataToFireStore, icon: const Icon(Icons.done))
            ])
          ],
        )),
      ),
    );
  }
}
