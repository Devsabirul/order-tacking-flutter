import 'package:dbordertracking/constants.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool isPassword;
  final String hinttext;
  final String validateMsg;

  const TextFormFieldWidget({
    Key? key,
    required this.controller,
    this.isPassword = false,
    required this.hinttext,
    required this.validateMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isValidate = true;
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(
        fontFamily: "Poppins",
        color: textLightColor,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        errorMaxLines: 1,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: const Color(0xffF2F2F2),
        hintText: hinttext,
        hintStyle: const TextStyle(
          fontFamily: "Poppins",
          color: textLightColor,
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.only(top: 13, bottom: 13, left: 25),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          isValidate = false;
          return validateMsg;
        }
        return null;
      },
    );
  }
}
