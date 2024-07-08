import 'dart:convert';

import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/utilities/takeInfoForInstruction.dart';
import 'package:diamond_painting/widgets/button_list.dart';
import 'package:diamond_painting/widgets/button_with_number.dart';
import 'package:diamond_painting/widgets/cell/cell.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';

class Instruction extends StatefulWidget {
  const Instruction({
    super.key,
  });

  @override
  State<Instruction> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Instruction> {
  final userBox = Hive.box('userbox');

  int width = 0;
  int height = 0;
  double shape = 0;
  List<Color> cellsColor = List.empty();
  List<dynamic> mosaicData = List.empty();
  bool isNew = false;
  bool hasMos = false;
  int currentIndex = 0;
  bool _progressBarActive = true;

  @override
  Widget build(BuildContext context) {
    checkIsNewMosaicAndFirst();
    if (isNew == true || hasMos == false) {
      setState(() {
        hasMos = true;
        isNew = false;
      });
      userBox.put('isNew', 'false');
      takeInfo();
    }

    return _progressBarActive
        ? Column(
            children: [
              Lottie.asset(
                'assets/wait.json',
                fit: BoxFit.cover,
              ),
              Text(
                'Создаем для вас инструкцию',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.btnTextColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 1; i <= width; i++)
                    Cell(
                      text: i.toString(),
                      textColor: AppColors.btnTextColor,
                      color: Colors.transparent,
                      textSize: 16,
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      for (int i = 1; i <= height; i++)
                        Cell(
                          text: i.toString(),
                          textColor: AppColors.btnTextColor,
                          color: Colors.transparent,
                          textSize: 16,
                          textAlign: TextAlign.end,
                        ),
                    ],
                  ),
                  SizedBox(
                    width: width == 9
                        ? width * 25 + 4
                        : width == 10
                            ? width * 25 + 2
                            : width == 13
                                ? width * 25
                                : width * 25,
                    height: height == 9
                        ? height * 25 + 4
                        : height == 12
                            ? height * 25 + 2
                            : height == 13
                                ? height * 25
                                : height * 25,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: AppColors.btnBackgroundColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8),
                        child: Column(
                          children: [
                            for (int i = 0; i < height; i++)
                              Row(
                                children: [
                                  for (int j = 0; j < width; j++)
                                    Cell(
                                      text: mosaicData[currentIndex][i][j]['text'],
                                      textColor: Color.fromRGBO(
                                        mosaicData[currentIndex][i][j]['text_color'][0],
                                        mosaicData[currentIndex][i][j]['text_color'][1],
                                        mosaicData[currentIndex][i][j]['text_color'][2],
                                        100,
                                      ),
                                      paddingRight: 4,
                                      shape: shape,
                                      color: Color.fromRGBO(
                                        mosaicData[currentIndex][i][j]['color'][0],
                                        mosaicData[currentIndex][i][j]['color'][1],
                                        mosaicData[currentIndex][i][j]['color'][2],
                                        100,
                                      ),
                                    ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 1; i <= height; i++)
                        Cell(
                          text: i.toString(),
                          textColor: AppColors.btnTextColor,
                          textSize: 16,
                          color: Colors.transparent,
                          textAlign: TextAlign.start,
                        ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 1; i <= width; i++)
                    Cell(
                      text: i.toString(),
                      textColor: AppColors.btnTextColor,
                      color: Colors.transparent,
                      textSize: 16,
                      paddingBottom: 0,
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 33),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ButtonList(
                      buttons: [
                        for (int i = 0; i < mosaicData.length; i++)
                          ButtonWithNumber(
                            number: i + 1,
                            isFavorite: i == 0 ? true : false,
                            onTap: () {
                              buttonClicked(i);
                            },
                          ),
                      ],
                    )),
              ),
            ],
          );
  }

  void checkIsNewMosaicAndFirst() async {
    if (userBox.get('isNew') == 'true') {
      setState(() {
        isNew = true;
      });
    }
    if (userBox.get('hasMosaic') == 'true') {
      setState(() {
        hasMos = true;
      });
    }
  }

  void takeInfo() async {
    setState(() {
      _progressBarActive = true;
    });

    List<dynamic> sizeShapeColor = await TakeInfoForInstruction().sizeShapeColor();
    mosaicData = await TakeInfoForInstruction().data();

    width = sizeShapeColor[0];
    height = sizeShapeColor[1];
    shape = sizeShapeColor[2];
    cellsColor = sizeShapeColor[3];

    setState(() {
      _progressBarActive = false;
    });
  }

  void buttonClicked(int number) {
    setState(() {
      currentIndex = number;
    });
  }
}
