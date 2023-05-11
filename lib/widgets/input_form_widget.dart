import 'package:flutter/material.dart';

class InputFormWidget extends StatelessWidget {
  const InputFormWidget({
    Key? key,
    required this.controller,
    required this.formEmpty,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  final TextEditingController controller;
  final String formEmpty;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      validator: (value) {
        return (value!.isEmpty) ? formEmpty : null;
      },
      decoration: InputDecoration(hintText: hintText),
    );
  }
}
