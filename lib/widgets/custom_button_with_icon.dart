import 'package:flutter/material.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final double? btnHeight;
  final double? btnWidth;
  final Color? btnColor;
  final String btnText;
  final Color? btnTextColor;
  final double? fontSize;
  final double? borderRadius;
  final Icon btnIcon;
  const CustomButtonWithIcon({
    super.key,
    required this.onPressed,
    required this.btnText,
    this.btnTextColor = Colors.white,
    this.fontSize = 10,
    this.btnHeight,
    this.btnWidth,
    this.btnColor = const Color.fromRGBO(26, 135, 192, 100),
    this.borderRadius = 10.0,
    required this.btnIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: Size(
            btnWidth ?? MediaQuery.of(context).size.width,
            btnHeight ?? MediaQuery.of(context).size.height * 0.05,
          ),
          backgroundColor: btnColor,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius!)),
          ),
          padding: const EdgeInsets.only(left: 0, right: 10)),
      icon: btnIcon,
      label: Text(
        btnText,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: btnTextColor,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
