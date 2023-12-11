import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/widgets/custom_button_with_icon.dart';
import 'package:flutter/material.dart';

Future<bool> contactsDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: Text('Наши контакты')),
          content: const Text('dfgdfgdfggd'),
          actions: [
            CustomButtonWithIcon(
              onPressed: () {
                Navigator.of(context).pop();
              },
              btnText: 'Вернуться к аккаунту',
              btnIcon: const Icon(
                Icons.undo,
                size: 30,
                color: AppColors.btnTextColor,
              ),
              btnHeight: 45,
              btnWidth: 252,
              fontSize: 15,
              btnTextColor: AppColors.btnTextColor,
              btnColor: AppColors.btnBackgroundColor,
              borderRadius: 30,
            )
          ],
        );
      }).then((value) => value ?? false);
}
