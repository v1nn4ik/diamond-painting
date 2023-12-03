import 'package:flutter/material.dart';

class MyWorksView extends StatelessWidget {
  const MyWorksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 253, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 253, 255),
        title: const Text('Мои работы'),
      ),
    );
  }
}
