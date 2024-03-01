import 'package:flutter/material.dart';

class TextFieldCommon extends StatelessWidget {
  const TextFieldCommon(
      {super.key,
      required this.hinttext,
      required this.controller,
      this.suffixIcon,
      this.ontap,
      this.password = false,
      this.prefixIcon,
      this.validator,
      this.keyboard});
  final String hinttext;
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final void Function()? ontap;
  final bool password;
  final TextInputType? keyboard;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboard,
      obscureText: password,
      controller: controller,
      validator: (value) => validator!(value!),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: SizedBox(
          height: 20,
          width: 20,
          child: InkWell(
            onTap: ontap,
            child: suffixIcon,
          ),
        ),
        hintText: hinttext,
        hintStyle: const TextStyle(
            fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black),
        isDense: true,
        contentPadding: const EdgeInsets.all(12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}
