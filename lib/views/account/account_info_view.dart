import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/services/auth/auth_service.dart';
import 'package:diamond_painting/widgets/custom_button_with_icon.dart';
import 'package:diamond_painting/widgets/custom_filed_with_icon.dart';
import 'package:diamond_painting/widgets/delete_account_dialog.dart';
import 'package:diamond_painting/widgets/log_out_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountInfoView extends StatefulWidget {
  const AccountInfoView({super.key});

  @override
  State<AccountInfoView> createState() => _AccountInfoViewState();
}

class _AccountInfoViewState extends State<AccountInfoView> {
  late final TextEditingController _password;

  @override
  void initState() {
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 63.0),
        child: Column(children: [
          SvgPicture.asset('assets/icons/user_info/ava.svg'),
          Text(
            'User',
            style: GoogleFonts.montserrat(
              color: AppColors.btnTextColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          CustomFieldWithIcon(
            fieldImage: SvgPicture.asset(
              'assets/icons/user_info/email.svg',
            ),
            textTitle: 'Почта',
            text: 'vinnik-03@mail.ru',
            editButton: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/user_info/editButton.svg',
                width: 19.5,
                height: 19.5,
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          CustomFieldWithIcon(
            fieldImage: SvgPicture.asset(
              'assets/icons/user_info/phoneNumber.svg',
              width: 35,
              height: 35,
            ),
            textTitle: 'Телефон',
            text: '+7 (936) 525 28 31   ',
            editButton: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/user_info/editButton.svg',
                width: 19.5,
                height: 19.5,
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          CustomFieldWithIcon(
            fieldImage: SvgPicture.asset(
              'assets/icons/user_info/pass.svg',
              width: 35,
              height: 35,
            ),
            textTitle: 'Пароль',
            text: '*************              ',
            editButton: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/user_info/editButton.svg',
                width: 19.5,
                height: 19.5,
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          CustomButtonWithIcon(
            onPressed: () {
              context.goNamed('contacts');
            },
            btnText: 'Связаться с нами',
            btnIcon: SvgPicture.asset(
              'assets/icons/user_info/support.svg',
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
            height: 29,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButtonWithIcon(
                onPressed: () async {
                  final shouldLogout = await deleteAccountDialog(context, _password);
                  if (shouldLogout) {
                    // await AuthService.firebase().deleteAccount(password: _password.text);
                    context.goNamed('login');
                  }
                },
                btnText: 'Удалить\nаккаунт',
                btnIcon: SvgPicture.asset(
                  'assets/icons/user_info/delete.svg',
                  width: 30,
                  height: 30,
                ),
                btnHeight: 45,
                btnWidth: 114,
                btnTextColor: AppColors.btnTextColor,
                btnColor: AppColors.btnBackgroundColor,
                borderRadius: 30,
              ),
              const SizedBox(
                width: 22,
              ),
              CustomButtonWithIcon(
                onPressed: () async {
                  final shouldLogout = await logOutDialog(context);
                  if (shouldLogout) {
                    // await AuthService.firebase().logOut();
                    context.goNamed('login');
                  }
                },
                btnText: 'Выйти из\nаккаунта',
                btnIcon: SvgPicture.asset(
                  'assets/icons/user_info/exit.svg',
                  width: 30,
                  height: 30,
                ),
                btnHeight: 45,
                btnWidth: 114,
                btnTextColor: AppColors.btnTextColor,
                btnColor: AppColors.btnBackgroundColor,
                borderRadius: 30,
              )
            ],
          ),
        ]),
      ),
    );
  }
}
