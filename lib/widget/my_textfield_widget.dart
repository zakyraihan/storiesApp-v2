// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyTextFieldWidget extends StatelessWidget {
  MyTextFieldWidget({
    super.key,
    required this.label,
    this.suffixIcon,
    this.controller,
    this.obscureText,
  });

  final String label;
  Widget? suffixIcon;
  TextEditingController? controller;
  bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      obscureText: obscureText ?? false,
    );
  }
}
