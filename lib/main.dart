import 'package:diamond_painting/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:diamond_painting/widgets/app_navigation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const DiamondPainting());
}

class DiamondPainting extends StatefulWidget {
  const DiamondPainting({super.key});

  @override
  State<DiamondPainting> createState() => _DiamondPaintingState();
}

class _DiamondPaintingState extends State<DiamondPainting> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    storage.write(key: 'hasMosaic', value: 'false');
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        return MaterialApp.router(
          title: 'Diamond Painting',
          debugShowCheckedModeBanner: false,
          routerConfig: AppNavigation.router,
        );
      },
    );
  }
}
