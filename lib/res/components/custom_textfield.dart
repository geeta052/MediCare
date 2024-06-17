import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? textcontroller;
  final Widget icon;
  final Color? textColor;
  final Color? backgroundColor;
  final validator;

  const CustomTextField({
    super.key,
    required this.hint,
    this.textcontroller,
    required this.icon,
    this.textColor,
    this.backgroundColor,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textcontroller,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: hint,
        hintStyle: TextStyle(color: textColor),
        filled: true,
        fillColor: backgroundColor,
        border: const OutlineInputBorder(borderSide: BorderSide()),
      ),
      style: TextStyle(color: textColor),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
