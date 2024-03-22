import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CodeView extends StatefulWidget {
  const CodeView({super.key});

  @override
  State<CodeView> createState() => _CodeViewState();
}

class _CodeViewState extends State<CodeView> {
  @override
  Widget build(BuildContext context) {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    late final TextEditingController code = TextEditingController();

    @override
    void dispose() {
      code.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 48, right: 48),
                child: Text(
                  'Введите уникальный код из набора для получения инструкции',
                  style: GoogleFonts.montserrat(
                    color: AppColors.btnTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),
            TextFormField(
              controller: code,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 20,
                color: AppColors.blueSmallText,
                fontWeight: FontWeight.w700,
              ),
              decoration: InputDecoration(
                constraints: const BoxConstraints(
                  maxHeight: 91,
                  maxWidth: 287,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'ВАШ КОД',
                hintStyle: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: AppColors.blueSmallText,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: AppColors.btnTextColor,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: AppColors.btnTextColor,
                    width: 2.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Flexible(
              flex: 2,
              child: CustomButton(
                onPressed: () async {
                  if (context.canPop()) {
                    context.pop();
                  }

                  storage.write(key: 'code', value: code.text);
                  storage.write(key: 'hasMosaic', value: 'true');
                  storage.write(key: 'isNew', value: 'true');

                  context.goNamed('Mosaic');
                },
                btnText: 'Далее',
                btnWidth: 200,
                borderRadius: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
