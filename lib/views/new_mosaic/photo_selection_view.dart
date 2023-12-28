import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/widgets/custom_button.dart';
import 'package:diamond_painting/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class PhotoSelectionView extends StatelessWidget {
  const PhotoSelectionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 48, right: 48),
                child: Text(
                  'Выберите понравившийся вариант',
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
            const CustomContainer(
              width: 200,
              height: 200,
              borderRadius: 15,
              shadowRadius: 20,
            ),
            Flexible(
              flex: 1,
              child: Container(),
            ),
            Container(
              height: 120,
              color: AppColors.btnBackgroundColor,
              child: const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CustomContainer(width: 95, height: 95, borderRadius: 15),
                    CustomContainer(width: 95, height: 95, borderRadius: 15),
                    CustomContainer(width: 95, height: 95, borderRadius: 15),
                    CustomContainer(width: 95, height: 95, borderRadius: 15),
                    CustomContainer(width: 95, height: 95, borderRadius: 15),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(),
            ),
            Flexible(
              flex: 1,
              child: CustomButton(
                onPressed: () {
                  context.goNamed('code');
                },
                btnText: 'Далее',
                btnWidth: 164,
                borderRadius: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
