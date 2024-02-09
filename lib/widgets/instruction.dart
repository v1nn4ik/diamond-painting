import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/widgets/cell.dart';
import 'package:flutter/material.dart';

class Instruction extends StatefulWidget {
  final int width;
  final int height;
  final String value;
  const Instruction({
    super.key,
    required this.value,
    required this.width,
    required this.height,
  });

  @override
  State<Instruction> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Instruction> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 1; i <= widget.width; i++)
              Cell(
                text: i.toString(),
                textColor: AppColors.btnTextColor,
                paddingBottom: 4,
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
                for (int i = 1; i <= widget.height; i++)
                  Cell(
                    text: i.toString(),
                    textColor: AppColors.btnTextColor,
                    textSize: 16,
                    paddingBottom: 4,
                    textAlign: TextAlign.end,
                  ),
              ],
            ),
            SizedBox(
              width: widget.width * 25,
              height: widget.height * 25,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: AppColors.btnBackgroundColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: Row(
                    children: [
                      for (int i = 0; i < widget.width; i++)
                        Column(
                          children: [
                            for (int i = 0; i < widget.height; i++)
                              Cell(
                                text: widget.value,
                                color: Colors.white,
                                paddingBottom: 4,
                                paddingRight: 4,
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
                for (int i = 1; i <= widget.height; i++)
                  Cell(
                    text: i.toString(),
                    textColor: AppColors.btnTextColor,
                    textSize: 16,
                    paddingBottom: 4,
                    textAlign: TextAlign.start,
                  ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 1; i <= widget.width; i++)
              Cell(
                text: i.toString(),
                textColor: AppColors.btnTextColor,
                textSize: 16,
              ),
          ],
        ),
      ],
    );
  }
}
