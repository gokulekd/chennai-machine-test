
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommenTextField extends StatelessWidget {
  String hinttext;
  TextEditingController controller;
   CommenTextField({
    Key? key,required this.hinttext,required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hinttext,
        filled: true,
        fillColor: Colors.grey.withOpacity(0.7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
