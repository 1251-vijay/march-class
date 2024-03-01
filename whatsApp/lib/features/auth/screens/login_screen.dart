import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/utlis/colors.dart';
import 'package:whatsapp/common/widgets/custom_button.dart';
import 'package:whatsapp/features/auth/controllers/auth_contoller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String routeName = "login-screen";
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phonenumbercontroller = TextEditingController();
  Country? country;

  void countrypicker() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  void signWithPhone() {
    String phoneNumber = phonenumbercontroller.text.trim();
    if (phoneNumber.isNotEmpty && country != null) {
      ref
          .read(authController)
          .signWithPhone(context, "+${country!.phoneCode}$phoneNumber");
    }
  }

  @override
  Widget build(BuildContext context) {
    phonenumbercontroller.selection = TextSelection.fromPosition(
        TextPosition(offset: phonenumbercontroller.text.length));
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text("Enter your phone number"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'WhatsApp will need to verify your phone number.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: countrypicker,
              child: const Text('Pick Country'),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  // ignore: unnecessary_string_interpolations
                  if (country != null) Text("+${country?.phoneCode}"),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          phonenumbercontroller.text = value;
                        });
                      },
                      keyboardType: TextInputType.phone,
                      controller: phonenumbercontroller,
                      decoration: InputDecoration(
                        suffixIcon: phonenumbercontroller.text.length > 9
                            ? Container(
                                width: 10,
                                height: 10,
                                child: const Icon(Icons.done),
                              )
                            : null,
                        hintText: "Phone Number",
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: greyColor)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: greyColor)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.5,
            ),
            SizedBox(
                width: 100,
                child: CustomButton(text: "NEXT", onpressed: signWithPhone)),
          ],
        ),
      ),
    );
  }
}
