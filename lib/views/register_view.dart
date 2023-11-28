import 'package:diamond_painting/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

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
      appBar: AppBar(title: const Text('Регистрация')),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Адрес эл. почты'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Пароль'),
          ),
          TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    mainRoute,
                    (route) => false,
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    devtools.log('Пароль должен содержать минимум 6 символов');
                  } else if (e.code == 'invalid-email') {
                    devtools.log('Некорректный адрес эл. почты');
                  } else if (e.code == 'email-already-in-use') {
                    devtools.log(
                        'Пользователь с таким адресом эл. почты уже существует');
                  }
                }
              },
              child: const Text('Зарегистрироваться')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute,
                  (route) => false,
                );
              },
              child: const Text('Уже зарегистрированы? Войти')),
        ],
      ),
    );
  }
}
