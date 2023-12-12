import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/services/auth/auth_exceptions.dart';
import 'package:diamond_painting/services/auth/auth_service.dart';
import 'package:diamond_painting/utilities/show_error_dialog.dart';
import 'package:diamond_painting/widgets/custom_button.dart';
import 'package:diamond_painting/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
              'Регистрация',
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
                  await AuthService.firebase().createUser(
                    email: email,
                    password: password,
                  );
                  AuthService.firebase().sendEmailVerification();
                  context.goNamed('verifyEmail');
                } on WeakPasswordAuthException {
                  await showErrorDialog(
                    context,
                    'Пароль должен содержать минимум 6 символов',
                  );
                } on InvalidEmailRegAuthException {
                  await showErrorDialog(
                    context,
                    'Некорректный адрес эл. почты',
                  );
                } on EmailAlredyInUseAuthException {
                  await showErrorDialog(
                    context,
                    'Пользователь с таким адресом эл. почты уже существует',
                  );
                } on GenericAuthException {
                  await showErrorDialog(
                    context,
                    'Ошибка регистрации',
                  );
                }
              },
              btnText: 'Зарегистрироваться',
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36.0, right: 36.0),
            child: CustomButton(
              onPressed: () {
                context.goNamed('login');
              },
              btnText: 'Уже зарегистрированы? Войти',
            ),
          ),
        ],
      ),
    );
  }
}
