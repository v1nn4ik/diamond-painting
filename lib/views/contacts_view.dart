import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/widgets/custom_button_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({super.key});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        automaticallyImplyLeading: false,
        title: const Text('Наши контакты'),
      ),
      body: Column(
        children: [
          CustomButtonWithIcon(
            onPressed: () => context.pop(),
            btnText: 'Вернуться к аккаунту',
            btnIcon: const Icon(
              Icons.undo,
              color: AppColors.btnTextColor,
              size: 30,
            ),
            fontSize: 16,
            btnHeight: 45,
            btnWidth: 252,
            btnTextColor: AppColors.btnTextColor,
            btnColor: AppColors.btnBackgroundColor,
            borderRadius: 30,
          ),
        ],
      ),
    );
  }
}