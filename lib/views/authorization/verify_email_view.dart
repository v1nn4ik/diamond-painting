import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/services/auth/auth_service.dart';
import 'package:diamond_painting/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 36.0, right: 36.0),
            child: Text(
              'Подтверждение адреса \n эл. почты',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 36.0, right: 36.0),
            child: Text(
              'Мы отправили ссылку для подтверждения на ваш адрес эл. почты. Откройте его, чтобы подтвердить ваш аккаунт',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36.0, right: 36.0),
            child: CustomButton(
              onPressed: () async {
                await AuthService.firebase().logOut();
                context.goNamed('login');
              },
              btnText: 'Готово, войти',
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36.0, right: 36.0),
            child: CustomButton(
              onPressed: () async {
                AuthService.firebase().sendEmailVerification();
              },
              btnText: 'Отправить письмо еще раз',
            ),
          ),
          const SizedBox(
            height: 6,
          ),
        ],
      ),
    );
  }
}
