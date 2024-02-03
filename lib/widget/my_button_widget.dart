// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyButtonWidget extends StatelessWidget {
  MyButtonWidget({
    super.key,
    required this.width,
    required this.height,
    this.onPressed,
    this.child,
  });

  final double width;
  final double height;
  void Function()? onPressed;

  Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ElevatedButton(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.black),
        ),
        onPressed: () {},
        child: child,
      ),
    );
  }
}
