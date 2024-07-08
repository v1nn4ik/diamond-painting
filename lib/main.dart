import 'package:flutter/material.dart';
import 'package:diamond_painting/widgets/app_navigation.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  var userBox = await Hive.openBox('userbox');

  runApp(const DiamondPainting());
}

class DiamondPainting extends StatelessWidget {
  const DiamondPainting({super.key});

  @override
  Widget build(BuildContext context) {
    // FlutterSecureStorage storage = const FlutterSecureStorage();
    final userBox = Hive.box('userbox');
    // storage.write(key: 'hasMosaic', value: 'false');
    userBox.put('hasMosaic', 'false');
    return MaterialApp.router(
      title: 'Diamond Painting',
      debugShowCheckedModeBanner: false,
      routerConfig: AppNavigation.router,
    );
  }
}
