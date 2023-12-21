import 'package:diamond_painting/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButtomWithImage extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? foregroundColor;
  final Color? btnColor;
  final String btnText;
  final Color? btnTextColor;
  final double? fontSize;
  final double? borderRadius;
  final Image? btnImage;
  final double? btnImageRadius;
  final FontWeight? fontWeight;
  const CustomButtomWithImage({
    super.key,
    required this.onPressed,
    this.btnColor = AppColors.btnBackgroundColor,
    required this.btnText,
    this.btnTextColor = AppColors.btnTextColor,
    this.fontSize = 20,
    this.borderRadius = 20.0,
    this.btnImage,
    this.fontWeight = FontWeight.bold,
    this.btnImageRadius = 10,
    this.foregroundColor = AppColors.btnTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: btnColor,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius!),
          ),
        ),
        maximumSize: Size.fromWidth(MediaQuery.of(context).size.width - 64),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(btnImageRadius!),
                child: btnImage,
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: Text(
                btnText,
                style: GoogleFonts.montserrat(
                  color: btnTextColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
