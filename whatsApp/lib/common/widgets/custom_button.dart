import 'package:flutter/material.dart';
import 'package:whatsapp/common/utlis/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onpressed});
  final String text;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: tabColor, minimumSize: const Size(double.infinity, 50)),
        onPressed: onpressed,
        child: Text(
          text,
          style: const TextStyle(
            color: blackColor,
          ),
        ));
  }
}
