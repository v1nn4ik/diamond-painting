import 'package:diamond_painting/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback onPressed;
  final double? btnHeight;
  final double? btnWidth;
  final Color? btnColor;
  final String btnText;
  final Color? btnTextColor;
  final double? fontSize;
  final double? borderRadius;
  final FontWeight? fontWeight;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.btnText,
    this.btnTextColor = AppColors.warEnableTextColor,
    this.fontSize = 16,
    this.btnHeight,
    this.btnWidth,
    this.btnColor = AppColors.warEnableColor,
    this.borderRadius = 10.0,
    this.fontWeight = FontWeight.w600,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          widget.btnWidth ?? MediaQuery.of(context).size.width,
          widget.btnHeight ?? MediaQuery.of(context).size.height * 0.05,
        ),
        backgroundColor: widget.btnColor,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius!)),
        ),
        maximumSize: Size(
          widget.btnWidth ?? MediaQuery.of(context).size.width,
          widget.btnHeight ?? MediaQuery.of(context).size.height * 0.05,
        ),
      ),
      child: Text(
        widget.btnText,
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          color: widget.btnTextColor,
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
        ),
      ),
    );
  }
}
