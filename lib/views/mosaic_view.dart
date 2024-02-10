import 'dart:io';

import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/widgets/button_list.dart';
import 'package:diamond_painting/widgets/button_with_number.dart';
import 'package:diamond_painting/widgets/instruction.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';

class MosaicView extends StatefulWidget {
  const MosaicView({super.key});

  @override
  State<MosaicView> createState() => _MosaicViewState();
}

class _MosaicViewState extends State<MosaicView> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  int currentIndex = 1;

  late String _localPath;
  late bool _permissionReady;
  late TargetPlatform? platform;
  bool _progressBarActive = false;

  String color = 'bw';
  String shape = 'square';
  String size = 'a2';

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 23),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/logo.svg'),
                const SizedBox(
                  width: 64,
                ),
                SizedBox(
                  width: 72,
                  height: 72,
                  child: _progressBarActive
                      ? Container(
                          child: Lottie.asset(
                            'assets/loading.json',
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.all(10),
                          child: FloatingActionButton(
                            onPressed: () async {
                              setState(() {
                                _progressBarActive = true;
                              });

                              _permissionReady = await _checkPermission();
                              if (_permissionReady) {
                                Dio dio = Dio();
                                MultipartFile file = await MultipartFile.fromFile(
                                  await storage.read(key: 'photo') ?? '',
                                  filename: 'image',
                                );
                                var formData = FormData();
                                formData.files.add(MapEntry('img', file));
                                Response response = await dio.post(
                                  'http://10.0.2.2:8000/mosaic/manual',
                                  data: formData,
                                );

                                await _prepareSaveDir();
                                String instructionUrl = response.data.toString();
                                await Dio().download(
                                  instructionUrl,
                                  "$_localPath/Инструкция1.pdf",
                                );
                                storage.write(key: 'mosaicInstruction', value: instructionUrl);

                                setState(() {
                                  _progressBarActive = false;
                                });
                              }
                            },
                            backgroundColor: AppColors.warEnableColor,
                            elevation: 2,
                            shape: const CircleBorder(),
                            child: SvgPicture.asset(
                              'assets/icons/mosaic/download.svg',
                              width: 40,
                              height: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          const Instruction(),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 33),
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ButtonList(
                  buttons: [
                    for (int i = 1; i <= 8; i++)
                      ButtonWithNumber(
                        number: i,
                        isFavorite: i == 1 ? true : false,
                        onTap: () {
                          buttonClicked(i);
                        },
                      ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Future<bool> _checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    if (platform == TargetPlatform.android) {
      return '/storage/emulated/0/Download';
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path + Platform.pathSeparator;
    }
  }

  void buttonClicked(int number) {
    setState(() {
      currentIndex = number;
    });
  }
}
