import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/widgets/card_widget.dart';
import 'package:diamond_painting/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class WorksRecView extends StatefulWidget {
  const WorksRecView({super.key});

  @override
  State<WorksRecView> createState() => _WorksRecViewState();
}

class _WorksRecViewState extends State<WorksRecView> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  Color _btnColor1 = AppColors.warEnableColor;
  Color _btnColor2 = AppColors.warDisableColor;
  Color _btnTextColor1 = AppColors.warEnableTextColor;
  Color _btnTextColor2 = AppColors.warDisableTextColor;
  bool? hasMosaic = false;

  final cards = <CardWidget>[
    const CardWidget(
      cardImageUrl: 'assets/images/image1.jpg',
      mosaicSize: 'A3',
      diamondTypeCircle: false,
    ),
    const CardWidget(
      cardImageUrl: 'assets/images/image1.jpg',
      mosaicSize: 'A4',
      diamondTypeCircle: false,
    ),
  ];

  void checkMosaic() async {
    String value = await storage.read(key: 'hasMosaic') ?? '';
    if (value == 'true') {
      setState(() {
        hasMosaic = true;
      });
    } else {
      setState(() {
        hasMosaic = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (hasMosaic == false) {
      checkMosaic();
    }
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 63, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onPressed: () {
                    setState(() {
                      _btnColor1 = AppColors.warEnableColor;
                      _btnColor2 = AppColors.warDisableColor;
                      _btnTextColor1 = AppColors.warEnableTextColor;
                      _btnTextColor2 = AppColors.warDisableTextColor;
                    });
                  },
                  btnColor: _btnColor1,
                  btnTextColor: _btnTextColor1,
                  btnWidth: 180,
                  btnHeight: 37,
                  btnText: 'Мои работы',
                ),
                const SizedBox(
                  width: 12,
                ),
                CustomButton(
                  onPressed: () {
                    setState(() {
                      _btnColor1 = AppColors.warDisableColor;
                      _btnColor2 = AppColors.warEnableColor;
                      _btnTextColor1 = AppColors.warDisableTextColor;
                      _btnTextColor2 = AppColors.warEnableTextColor;
                    });
                  },
                  btnColor: _btnColor2,
                  btnTextColor: _btnTextColor2,
                  btnWidth: 180,
                  btnHeight: 37,
                  btnText: 'Рекомендации',
                ),
              ],
            ),
          ),
          hasMosaic == true
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CardWidget(
                      cardImageUrl: 'assets/images/image1.jpg',
                      mosaicSize: 'A4',
                      diamondTypeCircle: false,
                    ),
                    SizedBox(
                      width: 32,
                    ),
                    CardWidget(
                      cardImageUrl: 'assets/images/image1.jpg',
                      mosaicSize: 'A3',
                      diamondTypeCircle: true,
                    )
                  ],
                )
              : Text(
                  'Нажмите “+” чтобы начать',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color: AppColors.btnTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 48,
        height: 48,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            context.goNamed('mosaicColor');
          },
          backgroundColor: AppColors.warEnableColor,
          child: const Icon(
            Icons.add,
            color: AppColors.warEnableTextColor,
          ),
        ),
      ),
    );
  }
}
