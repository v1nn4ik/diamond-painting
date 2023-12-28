import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/widgets/custom_button_with_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MosaicSizeView extends StatelessWidget {
  const MosaicSizeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Center(
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 48, right: 48),
                child: Text(
                  'Выберите желаемый размер мозаики',
                  style: GoogleFonts.montserrat(
                    color: AppColors.btnTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(),
            ),
            CustomButtomWithImage(
              onPressed: () {
                context.goNamed('mosaicHints');
              },
              btnText: 'A2',
              btnSvgImage: SvgPicture.asset(
                'assets/images/a2.svg',
                width: 63,
                height: 90,
              ),
              btnImageRadius: 0,
            ),
            const SizedBox(
              height: 24,
            ),
            CustomButtomWithImage(
              onPressed: () {
                context.goNamed('mosaicHints');
              },
              btnText: 'A3',
              btnSvgImage: SvgPicture.asset(
                'assets/images/a2.svg',
                width: 45,
                height: 64,
              ),
              customWidth: 14,
              btnImageRadius: 0,
            ),
            const SizedBox(
              height: 24,
            ),
            CustomButtomWithImage(
              onPressed: () {
                context.goNamed('mosaicHints');
              },
              btnText: 'A4',
              btnSvgImage: SvgPicture.asset(
                'assets/images/a2.svg',
                width: 32,
                height: 46,
              ),
              customWidth: 24,
              btnImageRadius: 0,
            ),
          ],
        ),
      ),
    );
  }
}
