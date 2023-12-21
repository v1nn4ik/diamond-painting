import 'package:diamond_painting/services/auth/auth_service.dart';
import 'package:diamond_painting/views/account/account_info_view.dart';
import 'package:diamond_painting/views/authorization/login_view.dart';
import 'package:diamond_painting/views/authorization/verify_email_view.dart';
import 'package:flutter/material.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    final user = AuthService.firebase().currentUser;
    if (user != null) {
      if (user.isEmailVerified) {
        return const AccountInfoView();
      } else {
        return const VerifyEmailView();
      }
    } else {
      return const LoginView();
    }
  }
}
