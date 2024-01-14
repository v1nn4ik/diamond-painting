import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/widgets/custom_button.dart';
import 'package:diamond_painting/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class PhotoSelectionView extends StatefulWidget {
  const PhotoSelectionView({
    super.key,
  });

  @override
  State<PhotoSelectionView> createState() => _PhotoSelectionViewState();
}

class _PhotoSelectionViewState extends State<PhotoSelectionView> {
  String? mosaicUrl;

  void _takeMosaics() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    String url = await storage.read(key: 'mosaic') ?? '';
    setState(() {
      mosaicUrl = url;
    });
  }

  @override
  void initState() {
    _takeMosaics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _takeMosaics();

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
                  'Выберите понравившийся вариант',
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
              flex: 1,
              child: Container(),
            ),
            CustomContainer(
              width: 180,
              height: 240,
              borderRadius: 15,
              shadowRadius: 20,
              imageUrl: mosaicUrl,
            ),
            Flexible(
              flex: 1,
              child: Container(),
            ),
            Container(
              height: 140,
              color: AppColors.btnBackgroundColor,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CustomContainer(
                      width: 90,
                      height: 120,
                      borderRadius: 15,
                      imageUrl: mosaicUrl,
                    ),
                    CustomContainer(
                      width: 90,
                      height: 120,
                      borderRadius: 15,
                      imageUrl: mosaicUrl,
                    ),
                    CustomContainer(
                      width: 90,
                      height: 120,
                      borderRadius: 15,
                      imageUrl: mosaicUrl,
                    ),
                    CustomContainer(
                      width: 90,
                      height: 120,
                      borderRadius: 15,
                      imageUrl: mosaicUrl,
                    ),
                    CustomContainer(
                      width: 90,
                      height: 120,
                      borderRadius: 15,
                      imageUrl: mosaicUrl,
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(),
            ),
            Flexible(
              flex: 1,
              child: CustomButton(
                onPressed: () {
                  context.goNamed('code');
                },
                btnText: 'Далее',
                btnWidth: 164,
                borderRadius: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
