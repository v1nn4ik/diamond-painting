import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/widgets/custom_button.dart';
import 'package:diamond_painting/widgets/custom_button_selection.dart';
import 'package:diamond_painting/widgets/custom_container.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class PhotoSelectionView extends StatefulWidget {
  const PhotoSelectionView({
    super.key,
  });

  @override
  State<PhotoSelectionView> createState() => _PhotoSelectionViewState();
}

class _PhotoSelectionViewState extends State<PhotoSelectionView> with SingleTickerProviderStateMixin {
  List<String>? mosaicUrlsStr;
  String? favouriteMosaicUrl;
  int? favouriteMosaic;
  Timer? timer;
  int? statusCode;

  Future<void> _takeMosaics() async {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) async {
      final userBox = Hive.box('userbox');
      String imgId = await userBox.get('imgId');
      String ownerId = await userBox.get('ownerId');

      String baseUrl = 'http://80.87.105.76:1323/api/v1/mosaic/demo/$imgId?owner_id=$ownerId';

      var uri = Uri.parse(baseUrl).replace(queryParameters: {'owner_id': ownerId});

      var response = await http.get(uri);
      statusCode = response.statusCode;

      if (statusCode == 200) {
        Map<dynamic, dynamic> body = json.decode(response.body);
        final bodyValues = body.values.toList();
        List<String> urls = [];
        for (int i = 0; i <= 5; i++) {
          urls.add(bodyValues[i]);
        }
        setState(() {
          mosaicUrlsStr = urls;
          favouriteMosaicUrl = urls[0];
          favouriteMosaic = 0;
        });
        timer?.cancel();
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    });
  }

  @override
  void initState() {
    _takeMosaics();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box('userbox');

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
        ),
        backgroundColor: AppColors.backgroundColor,
        body: statusCode == 200
            ? Center(
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
                      height: 270,
                      imageUrl: favouriteMosaicUrl,
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(),
                    ),
                    Container(
                      height: 160,
                      color: AppColors.btnBackgroundColor,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          if (mosaicUrlsStr != null) ...[
                            for (int i = 0; i <= 5; i++)
                              CustomButtonSelection(
                                width: 84,
                                onTap: () {
                                  setState(() {
                                    favouriteMosaicUrl = mosaicUrlsStr![i];
                                    favouriteMosaic = i;
                                  });
                                },
                                imageUrl: mosaicUrlsStr![i],
                              ),
                          ],
                        ]),
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
                          userBox.put('favouriteMosaic', (favouriteMosaic! + 1).toString());
                          context.goNamed('code');
                        },
                        btnText: 'Далее',
                        btnWidth: 164,
                        borderRadius: 20,
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: Lottie.asset(
                  'assets/loading.json',
                  fit: BoxFit.cover,
                ),
              ));
  }
}
