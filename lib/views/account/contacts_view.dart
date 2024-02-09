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
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 48, right: 48, top: 60),
              child: Text(
                'Наши контакты',
                style: GoogleFonts.montserrat(
                  color: AppColors.btnTextColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            CustomFieldWithIcon(
              fieldImage: SvgPicture.asset('assets/icons/user_info/email.svg'),
              textTitle: 'Почта',
              text: 'DSupport@yandex.ru',
            ),
            const SizedBox(
              height: 32,
            ),
            CustomFieldWithIcon(
              fieldImage: SvgPicture.asset('assets/icons/social_media/tg.svg'),
              textTitle: 'Телеграм',
              text: '@DSupport                  ',
            ),
            const SizedBox(
              height: 32,
            ),
            CustomFieldWithIcon(
              fieldImage: SvgPicture.asset('assets/icons/social_media/vk.svg'),
              textTitle: 'Вконтакте',
              text: '@DSupport                  ',
            ),
            const SizedBox(
              height: 32,
            ),
            CustomButtonWithIcon(
              onPressed: () => context.goNamed('info'),
              btnText: 'Вернуться к аккаунту',
              btnIcon: SvgPicture.asset(
                  'assets/icons/user_info/back.svg',
                  width: 30,
                  height: 30,
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
            SvgPicture.asset('assets/icons/logo.svg')
          ],
        ),
      ),
    );
  }
}
