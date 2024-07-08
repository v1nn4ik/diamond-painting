import 'dart:convert';
import 'dart:io';

import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/widgets/instruction.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class MosaicView extends StatefulWidget {
  const MosaicView({super.key});

  @override
  State<MosaicView> createState() => _MosaicViewState();
}

class _MosaicViewState extends State<MosaicView> with TickerProviderStateMixin {
  final userBox = Hive.box('userbox');
  bool? hasMosaic = false;

  late String _localPath;
  late bool _permissionReady;
  late TargetPlatform? platform;
  bool _progressBarActive = false;

  String color = 'bw';
  String shape = 'square';
  String size = 'a2';

  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (hasMosaic == false) {
      checkMosaic();
    }
    return hasMosaic == true
        ? Scaffold(
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
                                      var getPdf = http.Request(
                                          'GET',
                                          Uri.parse(
                                              'http://80.87.105.76:1323/api/v1/mosaic/manual/${await userBox.get('imgId')}/pdf'));

                                      getPdf.headers.addAll({
                                        HttpHeaders.authorizationHeader: '${await userBox.get('accessToken')}',
                                        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
                                      });

                                      var dataGetRequest = await getPdf.send();
                                      var pdfData = await http.Response.fromStream(dataGetRequest);
                                      var data = json.decode(pdfData.body);

                                      await _prepareSaveDir();
                                      String instructionUrl = data['manual'];
                                      var rng = Random();
                                      await Dio().download(
                                        instructionUrl,
                                        "$_localPath/Инструкция Kaleido${rng.nextInt(9999999)}.pdf",
                                      );

                                      userBox.put('mosaicInstruction', instructionUrl);

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
              ],
            ),
          )
        : Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Нажмите “+”\nчтобы начать',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      color: AppColors.btnTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_animationController != null) {
                      _animationController!.forward();
                    }
                    Future.delayed(const Duration(seconds: 1), () {
                      context.goNamed('mosaicColor');
                      _animationController!.reset();
                    });
                  },
                  child: SizedBox(
                    child: Lottie.asset(
                      'assets/add.json',
                      controller: _animationController,
                      width: 150,
                      height: 150,
                      repeat: false,
                    ),
                  ),
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

  void checkMosaic() async {
    String value = await userBox.get('hasMosaic');
    if (value == 'true') {
      setState(() {
        hasMosaic = true;
      });
    } else {
      setState(() {
        hasMosaic = false;
      });
    }
  }
}
