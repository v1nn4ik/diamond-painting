import 'package:flutter/material.dart';
import 'package:diamond_painting/widgets/app_navigation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const DiamondPainting());
}

class DiamondPainting extends StatelessWidget {
  const DiamondPainting({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    storage.write(key: 'hasMosaic', value: 'false');
    return MaterialApp.router(
      title: 'Diamond Painting',
      debugShowCheckedModeBanner: false,
      routerConfig: AppNavigation.router,
    );
  }
}
