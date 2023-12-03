import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 253, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 253, 255),
        title: const Text('Мозаика'),
      ),
    );
  }
}
