import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cell extends StatelessWidget {
  final double? width;
  final double? height;
  final double? paddingRight;
  final double? paddingLeft;
  final double? paddingTop;
  final double? paddingBottom;
  final Color? color;
  final String text;
  final double? textSize;
  final Color? textColor;
  final TextAlign? textAlign;
  final double? shape;
  const Cell({
    super.key,
    this.paddingRight = 4,
    this.paddingLeft = 0,
    this.paddingTop = 0,
    this.paddingBottom = 4,
    this.textSize = 14,
    this.textColor = Colors.black,
    this.color = Colors.white,
    required this.text,
    this.textAlign = TextAlign.center,
    this.width = 20,
    this.height = 20,
    this.shape = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: paddingRight!,
        left: paddingLeft!,
        top: paddingTop!,
        bottom: paddingBottom!,
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(shape!)),
            color: color,
          ),
          child: Text(
            text,
            textAlign: textAlign,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w700,
              fontSize: textSize,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
