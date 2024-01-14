import 'package:diamond_painting/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWithNumber extends StatelessWidget {
  final int number;
  final VoidCallback? onTap;
  final bool isFavorite;
  const ButtonWithNumber({
    Key? key,
    required this.number,
    this.onTap,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 10, bottom: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          fixedSize: const Size(55, 55),
          backgroundColor:
              isFavorite ? AppColors.warEnableColor : AppColors.warDisableColor,
        ),
        onPressed: onTap,
        child: Text(
          number.toString(),
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: isFavorite ? Colors.white : Colors.black54,
          ),
        ),
      ),
    );
  }
}
