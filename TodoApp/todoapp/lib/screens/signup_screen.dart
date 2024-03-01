import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todoapp/screens/home_screen.dart';
import 'package:todoapp/sevices/auth.dart';
import 'package:todoapp/utlis/image_picker.dart';
import 'package:todoapp/widgets/common.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController emailnamecontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  bool showpassword = false;
  Uint8List? image;
  bool isloading = false;

  void selectedImage() async {
    Uint8List im = await imagePicker(ImageSource.gallery);
    setState(() {
      image = im;
    });
  }

  void signup() async {
    setState(() {
      isloading = true;
    });
    String res = await Auth().signup(
        username: usernamecontroller.text.trim(),
        email: emailnamecontroller.text.trim(),
        phonenumber: phonecontroller.text.trim(),
        password: passwordcontroller.text.trim());
    if (res == 'Success') {
      setState(() {
        isloading = false;
      });
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 16, 57, 194),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 105),
                  ),
                ),
              ),
              Column(
                children: [
                  const SafeArea(
                    child: Text(
                      "SignUp",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text(
                    "Login to account ",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 50),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 5,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  selectedImage();
                                },
                                child: image == null
                                    ? const CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(
                                            'https://i.stack.imgur.com/l60Hf.png'),
                                      )
                                    : CircleAvatar(
                                        radius: 50,
                                        backgroundImage: MemoryImage(image!),
                                      )),
                            const SizedBox(
                              height: 12,
                            ),
                            TextFieldCommon(
                              hinttext: "Username",
                              controller: usernamecontroller,
                              prefixIcon: const Icon(
                                Icons.person,
                                size: 23,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            TextFieldCommon(
                              hinttext: "Phonenumber",
                              keyboard: TextInputType.phone,
                              controller: phonecontroller,
                              prefixIcon: const Icon(Icons.phone_iphone_rounded,
                                  size: 23),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            TextFieldCommon(
                              hinttext: "Email",
                              controller: emailnamecontroller,
                              prefixIcon: const Icon(Icons.email, size: 23),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            TextFieldCommon(
                              ontap: () {
                                setState(() {
                                  showpassword = !showpassword;
                                });
                              },
                              hinttext: "Password",
                              password: showpassword,
                              controller: passwordcontroller,
                              suffixIcon: showpassword
                                  ? const Icon(
                                      Icons.visibility_off,
                                      size: 23,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      size: 23,
                                    ),
                              prefixIcon: const Icon(Icons.password, size: 23),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            GestureDetector(
                              onTap: () {
                                signup();
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.green[400],
                                    borderRadius: BorderRadius.circular(10)),
                                child: isloading
                                    ? const CircularProgressIndicator(
                                        color: Colors.blue,
                                      )
                                    : const Center(
                                        child: Text(
                                        "SignUp",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
