import 'package:chating_app/common/utlis/utlis.dart';
import 'package:chating_app/features/auth/controller/auth_controller.dart';
import 'package:chating_app/wigets/custom_button.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = "login-screen";
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneNumberController = TextEditingController();
  Country? country;

  void selectedCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  void signWithPhone() {
    String phonenumber = phoneNumberController.text.trim();
    if (phonenumber.isNotEmpty && country != null) {
      ref
          .read(authControllerProvider)
          .signWithPhone(context, "+${country!.phoneCode}$phonenumber");
    } else {
      showSnackBar(context, "please fill the details");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 75,
                child: Image.asset(
                  "assets/image2.png",
                  height: 300,
                  width: 300,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "WhatsApp will need to verify phone number",
                // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              TextButton(
                  onPressed: selectedCountry,
                  child: const Text("pick Country")),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    if (country != null)
                      Text(
                        "+${country!.phoneCode}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    const SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        onChanged: (val) {
                          setState(() {
                            phoneNumberController.text = val;
                          });
                        },
                        keyboardType: TextInputType.phone,
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                            hintText: "Phone Number",
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            suffixIcon: phoneNumberController.text.length > 9
                                ? const Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  )
                                : null),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
              ),
              SizedBox(
                width: 100,
                child: CustomButton(text: "Next", onpressed: signWithPhone),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
