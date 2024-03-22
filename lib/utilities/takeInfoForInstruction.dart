import 'dart:convert';
import 'dart:io';

import 'package:diamond_painting/widgets/cell/cell_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class TakeInfoForInstruction {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<dynamic> sizeShapeColor() async {
    String tempColor = await storage.read(key: 'color') ?? '';
    String tempShape = await storage.read(key: 'shape') ?? '';
    String tempSize = await storage.read(key: 'size') ?? '';

    int width = 0;
    int height = 0;
    double shape = 0.0;
    List<Color> cellsColor = List.empty();

    if (tempSize == 'a2') {
      width = 10;
      height = 13;
    } else if (tempSize == 'a3') {
      width = 13;
      height = 12;
    } else {
      width = 9;
      height = 9;
    }

    tempShape == 'square' ? shape = 5.0 : shape = 10.0;

    if (tempColor == 'bw') {
      cellsColor = CellColors.bw;
    } else if (tempColor == 'sepia') {
      cellsColor = CellColors.sepia;
    } else {
      cellsColor = CellColors.popart;
    }

    return [width, height, shape, cellsColor];
  }

  Future<List> data() async {
    // Отправка запроса на инструкцию

    var postDataForInstruction =
        http.MultipartRequest('POST', Uri.parse('http://10.0.2.2:1323/api/v1/mosaic/manual/upload'));

    postDataForInstruction.headers.addAll({
      HttpHeaders.authorizationHeader: '${await storage.read(key: 'accessToken')}',
    });

    var imagePath = await storage.read(key: 'photo') ?? '';
    postDataForInstruction.files.add(await http.MultipartFile.fromPath(
      'img',
      imagePath,
    ));
    postDataForInstruction.fields['canvasFormat'] = (await storage.read(key: 'size'))!.toUpperCase();
    postDataForInstruction.fields['palette'] = await storage.read(key: 'color') ?? '';
    postDataForInstruction.fields['version'] = await storage.read(key: 'favouriteMosaic') ?? '';
    postDataForInstruction.fields['code'] = '8d8bd3da-3e76-4b0e-aeb3-78621d8e5160';

    var dataPostRequest = await postDataForInstruction.send();
    var postResponse = await http.Response.fromStream(dataPostRequest);
    final postBody = json.decode(postResponse.body);

    await Future.delayed(const Duration(seconds: 20));

    // Получение данных инструкции

    var getDataForInstruction = http.Request('GET', Uri.parse('http://10.0.2.2:1323/api/v1/mosaic/manual/data'));

    getDataForInstruction.headers.addAll({
      HttpHeaders.authorizationHeader: '${await storage.read(key: 'accessToken')}',
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    });

    getDataForInstruction.body = json.encode({
      'id': postBody['imgId'],
      'ownerId': postBody['ownerId'],
    });

    var dataGetRequest = await getDataForInstruction.send();
    var getResponse = await http.Response.fromStream(dataGetRequest);
    var data = json.decode(getResponse.body);

    return data['data'];
  }
}
