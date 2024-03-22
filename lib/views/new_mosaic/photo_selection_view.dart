import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:diamond_painting/app_colors.dart';
import 'package:diamond_painting/widgets/custom_button.dart';
import 'package:diamond_painting/widgets/custom_button_selection.dart';
import 'package:diamond_painting/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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

  void _takeMosaics() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();

    var requestGetMosaic = http.Request(
      'GET',
      Uri.parse('http://10.0.2.2:1323/api/v1/mosaic/demo'),
    );

    requestGetMosaic.headers.addAll({
      HttpHeaders.authorizationHeader: '${await storage.read(key: 'accessToken')}',
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    });
    String id = await storage.read(key: 'imgId') ?? '';
    String ownerId = await storage.read(key: 'ownerId') ?? '';
    requestGetMosaic.body = json.encode({
      'id': id,
      'ownerId': ownerId,
    });
    var mosaicUrls = await requestGetMosaic.send();
    statusCode = mosaicUrls.statusCode;

    if (statusCode == 200) {
      var response = await http.Response.fromStream(mosaicUrls);
      final body = json.decode(response.body);
      List<String> urls = [];
      for (int i = 1; i <= 6; i++) {
        urls.add(body['demo'][i.toString()]);
      }
      print(response);
      setState(() {
        mosaicUrlsStr = urls;
        favouriteMosaicUrl = urls[0];
        favouriteMosaic = 0;
      });
    } else {
      print(statusCode);
    }
  }

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      _takeMosaics();
      if (statusCode == 200) {
        timer?.cancel();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const FlutterSecureStorage storage = FlutterSecureStorage();

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
                          storage.write(key: 'favouriteMosaic', value: favouriteMosaic.toString());
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
