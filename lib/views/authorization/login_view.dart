import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/services/auth/auth_exceptions.dart';
import 'package:diamond_painting/services/auth/auth_service.dart';
import 'package:diamond_painting/utilities/show_error_dialog.dart';
import 'package:diamond_painting/widgets/custom_button.dart';
import 'package:diamond_painting/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

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
              'Авторизация',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36.0, right: 36.0),
            child: CustomTextField(
              controller: _email,
              hintText: 'Адрес эл. почты',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email_outlined),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36.0, right: 36.0),
            child: CustomTextField(
              controller: _password,
              hintText: 'Пароль',
              keyboardType: TextInputType.visiblePassword,
              isPassword: true,
              prefixIcon: const Icon(Icons.lock_outline),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36.0, right: 36.0),
            child: CustomButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  await AuthService.firebase().logIn(
                    email: email,
                    password: password,
                  );
                  final user = AuthService.firebase().currentUser;
                  if (user?.isEmailVerified ?? false) {
                    context.goNamed('info');
                  } else {
                    context.goNamed('verifyEmail');
                  }
                } on InvalidLoginCredentialsAuthException {
                  await showErrorDialog(
                    context,
                    'Неправильный адрес эл. почты или пароль',
                  );
                } on InvalidEmailAuthException {
                  await showErrorDialog(
                    context,
                    'Неверный формат эл. почты',
                  );
                } on WrongPasswordAuthException {
                  await showErrorDialog(
                    context,
                    'Неправильный пароль',
                  );
                } on GenericAuthException {
                  await showErrorDialog(
                    context,
                    'Ошибка аутоидентификации',
                  );
                }
              },
              btnText: 'Войти',
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36.0, right: 36.0),
            child: CustomButton(
              onPressed: () {
                context.goNamed('register');
              },
              btnText: 'Нет аккаунта? Зарегистрируйтесь',
            ),
          ),
        ],
      ),
    );
  }
}
