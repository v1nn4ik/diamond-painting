import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:diamond_painting/views/account_view.dart';
import 'package:diamond_painting/views/home_view.dart';
import 'package:diamond_painting/views/my_works_view.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int sectionIndex = 1;
  List<Widget> screens = const [
    MyWorksView(),
    HomeView(),
    AccountView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Алмазная мозаика')),
      body: screens[sectionIndex],
      bottomNavigationBar: CurvedNavigationBar(
          items: const <Widget>[
            Icon(
              Icons.apps,
              color: Color.fromRGBO(3, 4, 94, 68),
            ),
            Icon(
              Icons.diamond_outlined,
              color: Color.fromRGBO(3, 4, 94, 68),
            ),
            Icon(
              Icons.account_circle_outlined,
              color: Color.fromRGBO(3, 4, 94, 68),
            )
          ],
          index: 1,
          height: 65,
          color: const Color.fromRGBO(54, 172, 196, 100),
          buttonBackgroundColor: const Color.fromRGBO(54, 172, 196, 26),
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 200),
          onTap: (int index) {
            setState(() => sectionIndex = index);
          }),
    );
  }
}
