import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/widgets/custom_button.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
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

              XFile? imagePicker = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (imagePicker != null) {
                setState(() {
                  imagePath = imagePicker.path;
                });
              }
              CroppedFile? croppedFile = await ImageCropper().cropImage(
                  sourcePath: imagePath!,
                  aspectRatio: const CropAspectRatio(ratioX: 9, ratioY: 14),
                  uiSettings: [
                    AndroidUiSettings(
                      toolbarTitle: 'Отредактируйте фото',
                      backgroundColor: AppColors.backgroundColor,
                      toolbarColor: AppColors.backgroundColor,
                      toolbarWidgetColor: AppColors.btnTextColor,
                      activeControlsWidgetColor: AppColors.btnTextColor,
                      showCropGrid: false,
                      lockAspectRatio: true,
                    ),
                    IOSUiSettings(title: 'Отредактируйте фото'),
                  ]);
              if (croppedFile != null) {
                setState(() {
                  imagePath = croppedFile.path;
                });
              }

              String? canvasFormat = await storage.read(key: 'size');
              String? palette = await storage.read(key: 'color');

              Dio dio = Dio();

              Response loginResponse = await dio.post(
                'http://10.0.2.2:1323/api/v1/auth/login',
                data: {
                  'login': 'test@test.com',
                  'password': 'test',
                },
              );

              storage.write(key: 'accessToken', value: 'Bearer ${loginResponse.data['access_token']}');

              MultipartFile file = await MultipartFile.fromFile(
                imagePath!,
                filename: 'image',
              );
              var formData = FormData();
              formData.files.add(MapEntry('img', file));
              formData.fields.add(MapEntry('canvasFormat', canvasFormat!.toUpperCase()));
              formData.fields.add(MapEntry('palette', palette!));
              var response = await dio.post(
                'http://10.0.2.2:1323/api/v1/mosaic/demo/upload',
                data: formData,
              );
              
              storage.write(key: 'photo', value: imagePath);
              storage.write(key: 'imgId', value: response.data['imgId']);
              storage.write(key: 'ownerId', value: response.data['ownerId']);

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
