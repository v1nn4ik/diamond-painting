import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/widgets/custom_button_with_icon.dart';
import 'package:diamond_painting/widgets/custom_filed_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

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
        titleTextStyle: GoogleFonts.montserrat(
          color: AppColors.btnTextColor,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        title: const Text('Наши контакты'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 48,
            ),
            CustomFieldWithIcon(
              fieldImage: SvgPicture.asset('assets/images/email.svg'),
              textTitle: 'Почта',
              text: 'DSupport@yandex.ru',
            ),
            const SizedBox(
              height: 32,
            ),
            CustomFieldWithIcon(
              fieldImage: SvgPicture.asset('assets/images/tg.svg'),
              textTitle: 'Телеграм',
              text: '@DSupport                  ',
            ),
            const SizedBox(
              height: 32,
            ),
            CustomFieldWithIcon(
              fieldImage: SvgPicture.asset('assets/images/vk.svg'),
              textTitle: 'Вконтакте',
              text: '@DSupport                  ',
            ),
            const SizedBox(
              height: 32,
            ),
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
            const SizedBox(
              height: 32,
            ),
            SvgPicture.asset('assets/images/logo.svg')
          ],
        ),
      ),
    );
  }
}
