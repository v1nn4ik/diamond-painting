import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

Future<bool> deleteAccountDialog(
    BuildContext context, TextEditingController pass) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Удаление аккаунта'),
          content: const Text(
              'Вы уверены, что хотите удалить аккаунт? Все ваши работы и прогресс будут утеряны'),
          backgroundColor: AppColors.backgroundColor,
          actions: [
            CustomTextField(
              controller: pass,
              hintText: 'Пароль',
              keyboardType: TextInputType.visiblePassword,
              isPassword: true,
              prefixIcon: const Icon(Icons.lock_outline),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        color: AppColors.btnTextColor,
                      ),
                    ),
                    child: const Text('Удалить')),
                const SizedBox(
                  width: 20,
                ),
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
            )
          ],
        );
      }).then((value) => value ?? false);
}
