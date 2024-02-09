import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/widgets/custom_button_with_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MosaicColorView extends StatelessWidget {
  const MosaicColorView({super.key});

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
                  'Выберите желаемое цветовое решение',
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
                storage.write(key: 'color', value: 'bw');
                context.goNamed('mosaicShape');
              },
              btnText: 'Черно-белый',
              btnImage: Image.asset('assets/images/color_type/catWB.jpg'),
            ),
            const SizedBox(
              height: 24,
            ),
            CustomButtomWithImage(
              onPressed: () {
                storage.write(key: 'color', value: 'sepia');
                context.goNamed('mosaicShape');
              },
              btnText: 'Cепия',
              btnImage: Image.asset('assets/images/color_type/catS.jpg'),
            ),
            const SizedBox(
              height: 24,
            ),
            CustomButtomWithImage(
              onPressed: () {
                storage.write(key: 'color', value: 'popart');
                context.goNamed('mosaicShape');
              },
              btnText: 'Поп-арт',
              btnImage: Image.asset('assets/images/color_type/catP.jpg'),
            ),
          ],
        ),
      ),
    );
  }
}
