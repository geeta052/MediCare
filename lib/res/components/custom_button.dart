import 'package:flutter/material.dart';
import 'package:medicare/consts/consts.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;

  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    required String title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      height: 44,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(), backgroundColor: Colors.teal[800], 
        ),
        onPressed: onTap,
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
