import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/utilities/takeInfoForInstruction.dart';
import 'package:diamond_painting/widgets/cell/cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';

class Instruction extends StatefulWidget {
  const Instruction({
    super.key,
  });

  @override
  State<Instruction> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Instruction> {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  int width = 0;
  int height = 0;
  double shape = 0;
  List<Color> cellsColor = List.empty();
  List<dynamic> mosaicData = List.empty();
  bool isNew = false;
  bool hasMos = false;
  bool _progressBarActive = false;

  @override
  Widget build(BuildContext context) {
    int rows = 0;
    int columns = 0;

    checkIsNewMosaicAndFirst();
    if (isNew == true || hasMos == false) {
      setState(() {
        hasMos = true;
        isNew = false;
      });
      storage.write(key: 'isNew', value: 'false');
      takeInfo();
    }

    return _progressBarActive
        ? Center(
            child: Lottie.asset(
              'assets/wait.json',
              fit: BoxFit.cover,
            ),
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
                        child: Row(
                          children: [
                            for (int i = 0; i < width; i++)
                              Column(
                                children: [
                                  for (int j = 0; j < height; j++)
                                    Cell(
                                      text: '1',
                                      paddingRight: 4,
                                      shape: shape,
                                      color: cellsColor[1],
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
            ],
          );
  }

  void checkIsNewMosaicAndFirst() async {
    if (await storage.read(key: 'isNew') == 'true') {
      setState(() {
        isNew = true;
      });
    }
    if (await storage.read(key: 'hasMosaic') == 'true') {
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
    List<dynamic> data = await TakeInfoForInstruction().data();

    print('data big cells: ${data.length}');
    print('data cell: ${data[0][0].toString()}');

    width = sizeShapeColor[0];
    height = sizeShapeColor[1];
    shape = sizeShapeColor[2];
    cellsColor = sizeShapeColor[3];

    setState(() {
      _progressBarActive = false;
    });
  }
}
