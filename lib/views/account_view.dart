import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/constants/routes.dart';
import 'package:diamond_painting/services/auth/auth_service.dart';
import 'package:diamond_painting/widgets/contacts_dialog.dart';
import 'package:diamond_painting/widgets/custom_button_with_icon.dart';
import 'package:diamond_painting/widgets/delete_account_dialog.dart';
import 'package:diamond_painting/widgets/log_out_dialog.dart';
import 'package:flutter/material.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
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
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text('Аккаунт'),
      ),
      body: Column(
        children: [
          CustomButtonWithIcon(
            onPressed: () async {
              await contactsDialog(context);
            },
            btnText: 'Связаться с нами',
            btnIcon: const Icon(
              Icons.support_agent,
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
            height: 29,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButtonWithIcon(
                onPressed: () async {
                  final shouldLogout =
                      await deleteAccountDialog(context, _password);
                  if (shouldLogout) {
                    await AuthService.firebase()
                        .deleteAccount(password: _password.text);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (route) => false,
                    );
                  }
                },
                btnText: 'Удалить\nаккаунт',
                btnIcon: const Icon(
                  Icons.delete,
                  color: AppColors.btnTextColor,
                  size: 30,
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
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (route) => false,
                    );
                  }
                },
                btnText: 'Выйти из\nаккаунта',
                btnIcon: const Icon(
                  Icons.door_back_door,
                  color: AppColors.btnTextColor,
                  size: 30,
                ),
                btnHeight: 45,
                btnWidth: 114,
                btnTextColor: AppColors.btnTextColor,
                btnColor: AppColors.btnBackgroundColor,
                borderRadius: 30,
              )
            ],
          ),
        ],
      ),
    );
  }
}
