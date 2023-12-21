import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/widgets/card_widget.dart';
import 'package:diamond_painting/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WorksRecView extends StatefulWidget {
  const WorksRecView({super.key});

  @override
  State<WorksRecView> createState() => _WorksRecViewState();
}

class _WorksRecViewState extends State<WorksRecView> {
  Color _btnColor1 = AppColors.warEnableColor;
  Color _btnColor2 = AppColors.warDisableColor;
  Color _btnTextColor1 = AppColors.warEnableTextColor;
  Color _btnTextColor2 = AppColors.warDisableTextColor;

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
    const CardWidget(
      cardImageUrl: 'assets/images/image1.jpg',
      mosaicSize: 'A2',
      diamondTypeCircle: true,
    ),
    const CardWidget(
      cardImageUrl: 'assets/images/image1.jpg',
      mosaicSize: 'A4',
      diamondTypeCircle: true,
    )
  ];

  @override
  Widget build(BuildContext context) {
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
          const Row(
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
