import 'dart:convert';
import 'dart:io';

import 'package:diamond_painting/widgets/cell/cell_colors.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class TakeInfoForInstruction {
  final userBox = Hive.box('userbox');

  Future<dynamic> sizeShapeColor() async {
    String tempColor = await userBox.get('color');
    String tempShape = await userBox.get('shape');
    String tempSize = await userBox.get('size');

    int width = 0;
    int height = 0;
    double shape = 0.0;
    List<Color> cellsColor = List.empty();

    if (tempSize == '2') {
      width = 10;
      height = 13;
    } else if (tempSize == '3') {
      width = 13;
      height = 12;
    } else {
      width = 9;
      height = 9;
    }

    tempShape == 'square' ? shape = 5.0 : shape = 10.0;

    if (tempColor == 'black_white') {
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
        http.MultipartRequest('POST', Uri.parse('http://80.87.105.76:1323/api/v1/mosaic/manual/upload'));

    postDataForInstruction.headers.addAll({
      HttpHeaders.authorizationHeader: '${await userBox.get('accessToken')}',
    });

    var imagePath = await userBox.get('photo');
    postDataForInstruction.files.add(await http.MultipartFile.fromPath(
      'img',
      imagePath,
    ));
    postDataForInstruction.fields['canvas_format'] = 'A${await userBox.get('size')}';
    postDataForInstruction.fields['palette'] = await userBox.get('color');
    postDataForInstruction.fields['version'] = 'v${await userBox.get('favouriteMosaic')}';

    postDataForInstruction.fields['code'] = '5f8fc6ac-02af-456c-a3f4-12382c887ff5';

    var dataPostRequest = await postDataForInstruction.send();
    var postResponse = await http.Response.fromStream(dataPostRequest);
    final postBody = json.decode(postResponse.body);

    final id = userBox.put('imgId', postBody['id']);

    await Future.delayed(const Duration(seconds: 2));

    // Получение данных инструкции

    var getDataForInstruction = http.Request(
        'GET', Uri.parse('http://80.87.105.76:1323/api/v1/mosaic/manual/${await userBox.get('imgId')}/data'));

    getDataForInstruction.headers.addAll({
      HttpHeaders.authorizationHeader: '${await userBox.get('accessToken')}',
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    });

    var dataGetRequest = await getDataForInstruction.send();
    var getResponse = await http.Response.fromStream(dataGetRequest);
    var data = json.decode(getResponse.body);

    return data['data'];
  }
}
