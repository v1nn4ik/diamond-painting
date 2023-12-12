import 'package:diamond_painting/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:diamond_painting/widgets/app_navigation.dart';

void main() {
  runApp(const DiamondPainting());
}

class DiamondPainting extends StatelessWidget {
  const DiamondPainting({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return MaterialApp.router(
              title: 'Diamond Painting',
              debugShowCheckedModeBanner: false,
              routerConfig: AppNavigation.router,
            );
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
