import 'package:diamond_painting/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CardWidget extends StatelessWidget {
  final double? borderRadius;
  final String cardImageUrl;
  final bool diamondTypeCircle;
  final String mosaicSize;
  const CardWidget({
    super.key,
    this.borderRadius = 20,
    required this.cardImageUrl,
    required this.diamondTypeCircle,
    required this.mosaicSize,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.warEnableTextColor,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius!)),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius!),
            child: Image.asset(
              cardImageUrl,
              height: 210,
              width: 150,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 4),
            child: Row(
              children: [
                diamondTypeCircle
                    ? SvgPicture.asset('assets/images/circleDiamond.svg')
                    : SvgPicture.asset('assets/images/squareDiamond.svg'),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  mosaicSize,
                  style: GoogleFonts.montserrat(
                      fontSize: 13, fontWeight: FontWeight.w300),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
