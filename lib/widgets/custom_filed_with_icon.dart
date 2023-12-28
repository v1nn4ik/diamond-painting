import 'package:diamond_painting/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFieldWithIcon extends StatelessWidget {
  final SvgPicture fieldImage;
  final String textTitle;
  final String text;
  final IconButton? editButton;
  const CustomFieldWithIcon({
    super.key,
    required this.fieldImage,
    required this.textTitle,
    required this.text,
    this.editButton,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        fieldImage,
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              textTitle,
              style: GoogleFonts.montserrat(
                  color: AppColors.btnTextColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w300),
            ),
            Text(
              text,
              style: GoogleFonts.montserrat(
                  color: AppColors.btnTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
          ],
        ),
        const SizedBox(
          width: 12,
        ),
        Container(
          child: editButton,
        ),
      ],
    );
  }
}
