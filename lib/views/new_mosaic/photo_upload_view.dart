import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/widgets/custom_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class PhotoUploadView extends StatefulWidget {
  const PhotoUploadView({super.key});

  @override
  State<PhotoUploadView> createState() => _PhotoUploadViewState();
}

class _PhotoUploadViewState extends State<PhotoUploadView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Text(
                'Загрузите любую картинку из своей медиатеки',
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
          CustomButton(
            onPressed: () async {
              const FlutterSecureStorage storage = FlutterSecureStorage();

              String? imagePath;
              String? mosaicPhotoUrl;

              XFile? imagePicker =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (imagePicker != null) {
                setState(() {
                  imagePath = imagePicker.path;
                });
              }

              Dio dio = Dio();
              MultipartFile file = await MultipartFile.fromFile(
                imagePath!,
                filename: 'image',
              );
              var formData = FormData();
              formData.files.add(MapEntry('img', file));
              Response response = await dio.post(
                'http://127.0.0.1:8000/mosaic',
                data: formData,
              );
              setState(() {
                mosaicPhotoUrl = response.data.toString();
              });

              storage.write(key: 'mosaic', value: mosaicPhotoUrl!);
              storage.write(key: 'photo', value: imagePath!);

              context.goNamed('photoSelection');
            },
            btnText: 'Загрузить',
            btnWidth: 200,
            btnHeight: 45,
            borderRadius: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
            child: Text(
              'Размер файла не\nбольше 15 МБ',
              style: GoogleFonts.montserrat(
                color: AppColors.blueSmallText,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
