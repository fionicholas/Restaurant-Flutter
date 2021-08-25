import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.btnColor,
      required this.textColor,
      required this.textButton,
      required this.onPressed})
      : super(key: key);

  final Color btnColor;
  final Color textColor;
  final String textButton;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0.0,
      highlightElevation: 0.0,
      color: btnColor,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      onPressed: onPressed,
      child: Text(
        textButton,
        style: TextStyle(
            color: textColor, fontSize: 10, fontWeight: FontWeight.w700),
      ),
    );
  }
}
