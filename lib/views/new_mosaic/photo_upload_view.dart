import 'dart:convert';
import 'dart:io';

import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/widgets/custom_button.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class PhotoUploadView extends StatefulWidget {
  const PhotoUploadView({super.key});

  @override
  State<PhotoUploadView> createState() => _PhotoUploadViewState();
}

class _PhotoUploadViewState extends State<PhotoUploadView> {
  Future<Map<String, dynamic>> uploadFile(String url, File file, String canvasFormat, String palette) async {
    var stream = http.ByteStream(file.openRead());
    var length = await file.length();

    var uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);

    var multipartFile = http.MultipartFile('img', stream, length, filename: path.basename(file.path));
    request.files.add(multipartFile);

    request.fields['canvas_format'] = 'A$canvasFormat'.toUpperCase();
    request.fields['palette'] = palette;

    var response = await request.send();

    if (response.statusCode == 200) {
      print('File and fields uploaded successfully!');
    } else {
      print('Failed to upload. Status code: ${response.statusCode}');
    }

    final respStr = json.decode(await response.stream.bytesToString());
    return respStr;
  }

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
              final userBox = Hive.box('userbox');

              Map<String, String> body = {
                'login': 'cuteube1@gmail.com',
                'password': 'cute',
              };
              var responseAuth = await http.post(
                Uri.parse('http://80.87.105.76:1323/api/v1/auth/login'),
                headers: {
                  'Content-Type': 'application/json',
                },
                body: jsonEncode(body),
              );

              if (responseAuth.statusCode == 200) {
                print('Login successful!');
                print('Response body: ${responseAuth.body}');
              } else {
                print('Failed to login. Status code: ${responseAuth.statusCode}');
              }
              var authData = (json.decode(responseAuth.body)).entries.toList();

              userBox.put('accessToken', 'Bearer ${authData.elementAt(0).value}');

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

              String? canvasFormat = await userBox.get('size');
              String? palette = await userBox.get('color');

              String url = 'http://80.87.105.76:1323/api/v1/mosaic/demo/upload';
              File file = File(imagePath!);

              final response = await uploadFile(url, file, canvasFormat!, palette!);
              final responseData = response.entries.toList();

              userBox.put('photo', imagePath);

              userBox.put('imgId', responseData.elementAt(0).value);
              userBox.put('ownerId', responseData.elementAt(1).value);

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
