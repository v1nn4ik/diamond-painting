import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/widgets/custom_button_with_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MosaicShapeView extends StatelessWidget {
  const MosaicShapeView({super.key});

  @override
  Widget build(BuildContext context) {
    const FlutterSecureStorage storage = FlutterSecureStorage();

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
                  'Выберите желаемую форму алмаза',
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
                storage.write(key: 'shape', value: 'square');
                context.goNamed('mosaicSize');
              },
              btnText: 'Квадратная',
              btnSvgImage: SvgPicture.asset(
                'assets/icons/mosaic_settings/squareDiamond.svg',
                width: 60,
                height: 60,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            CustomButtomWithImage(
              onPressed: () {
                storage.write(key: 'shape', value: 'circle');
                context.goNamed('mosaicSize');
              },
              btnText: 'Круглая',
              btnSvgImage: SvgPicture.asset(
                'assets/icons/mosaic_settings/circleDiamond.svg',
                width: 50,
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
