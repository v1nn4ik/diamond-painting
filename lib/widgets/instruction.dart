import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/widgets/cell/cell.dart';
import 'package:diamond_painting/widgets/cell/cell_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Instruction extends StatefulWidget {
  const Instruction({
    super.key,
  });

  @override
  State<Instruction> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Instruction> {
  int width = 0;
  int height = 0;
  double shape = 0;
  List<Color> cellsColor = List.empty();

  @override
  void initState() {
    takeInfoForMosaic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              height: height * 25,
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

  void takeInfoForMosaic() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    String tempColor = await storage.read(key: 'color') ?? '';
    String tempShape = await storage.read(key: 'shape') ?? '';
    String tempSize = await storage.read(key: 'size') ?? '';

    if (tempSize == 'a2') {
      setState(() {
        width = 13;
        height = 12;
      });
    } else if (tempSize == 'a3') {
      setState(() {
        width = 10;
        height = 13;
      });
    } else {
      setState(() {
        width = 9;
        height = 13;
      });
    }

    if (tempShape == 'square') {
      setState(() {
        shape = 5;
      });
    } else {
      setState(() {
        shape = 10;
      });
    }

    if (tempColor == 'bw') {
      setState(() {
        cellsColor = CellColors.bw;
      });
    } else if (tempColor == 'sepia') {
      setState(() {
        cellsColor = CellColors.sepia;
      });
    } else {
      setState(() {
        cellsColor = CellColors.popart;
      });
    }
  }
}
