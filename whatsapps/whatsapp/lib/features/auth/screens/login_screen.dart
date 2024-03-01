import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/utils/colors.dart';
import 'package:whatsapp/common/utils/widgets/custom_button.dart';
import 'package:whatsapp/features/controller/auth_controller.dart';

import '../../../common/utils/utlis.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routename = "login-screen";
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phonecontroller = TextEditingController();
  Country? country;
  @override
  void dispose() {
    phonecontroller.dispose();
    super.dispose();
  }

  void pickcountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          country = _country;
          setState(() {});
        });
  }

  void signPhoneNumber() {
    String phoneNumber = phonecontroller.text.trim();
    if (phoneNumber.isNotEmpty && country != null) {
      ref
          .read(authControllerProvider)
          .signInwithPhoneNumber(context, "+${country!.phoneCode}$phoneNumber");
    } else {
      showSnackBar(context: context, content: "please Enter your number");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text("Enter your phone number"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("WhatsApp will need to verify phone number"),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    pickcountry();
                  },
                  child: const Text("Pick Countery")),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  if (country != null) Text(" +${country!.phoneCode}"),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                      cursorColor: greyColor,
                      controller: phonecontroller,
                      decoration: const InputDecoration(
                        hintText: "phonenumber",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: greyColor),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.6,
              ),
              SizedBox(
                width: 90,
                child: CustomButton(text: 'Next', onpressed: signPhoneNumber),
              )
            ],
          ),
        ),
      ),
    );
  }
}
