import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double? btnHeight;
  final double? btnWidth;
  final Color? btnColor;
  final String btnText;
  final Color? btnTextColor;
  final double? fontSize;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.btnText,
    this.btnTextColor = Colors.white,
    this.fontSize = 16,
    this.btnHeight,
    this.btnWidth,
    this.btnColor = const Color.fromRGBO(26, 135, 192, 100),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          btnWidth ?? MediaQuery.of(context).size.width,
          btnHeight ?? MediaQuery.of(context).size.height * 0.05,
        ),
        backgroundColor: btnColor,
        elevation: 1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      child: Center(
        child: Text(
          btnText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: btnTextColor,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
