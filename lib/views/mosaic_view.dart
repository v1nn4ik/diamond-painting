import 'package:diamond_painting/app_colors.dart';
import 'package:flutter/material.dart';

class MosaicView extends StatelessWidget {
  const MosaicView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text('Мозаика'),
      ),
    );
  }
}
