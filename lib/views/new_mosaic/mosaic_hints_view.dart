import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MosaicHintsView extends StatelessWidget {
  const MosaicHintsView({super.key});

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
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Text(
                'Максимально приближайте крупные объекты, избегайте однотонный фон',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/card1.jpg',
                width: 150,
                height: 150,
              ),
              const SizedBox(
                width: 24,
              ),
              Image.asset(
                'assets/images/card2.jpg',
                width: 150,
                height: 150,
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/card3.jpg',
                width: 150,
                height: 150,
              ),
              const SizedBox(
                width: 24,
              ),
              Image.asset(
                'assets/images/card4.jpg',
                width: 150,
                height: 150,
              ),
            ],
          ),
          Flexible(
            flex: 1,
            child: Container(),
          ),
          Flexible(
            flex: 2,
            child: CustomButton(
              onPressed: () {
                context.goNamed('photoUpload');
              },
              btnText: 'Далее',
              borderRadius: 20,
              btnWidth: 164,
              btnHeight: 45,
            ),
          ),
        ],
      )),
    );
  }
}
