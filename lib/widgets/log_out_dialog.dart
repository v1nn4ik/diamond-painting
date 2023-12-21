import 'package:diamond_painting/app_colors.dart';
import 'package:flutter/material.dart';

Future<bool> logOutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Выход'),
          content: const Text('Вы уверены, что хотите выйти?'),
          backgroundColor: AppColors.backgroundColor,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    color: AppColors.btnTextColor,
                  ),
                ),
                child: const Text('Выйти')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    color: AppColors.btnTextColor,
                  ),
                ),
                child: const Text('Отмена')),
          ],
        );
      }).then((value) => value ?? false);
}
