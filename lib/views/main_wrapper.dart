import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:diamond_painting/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainWrapper extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainWrapper({
    required this.navigationShell,
    super.key,
  });

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int selectedIndex = 0;

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: const <Widget>[
          Icon(
            Icons.apps,
            color: AppColors.btnTextColor,
          ),
          Icon(
            Icons.diamond_outlined,
            color: AppColors.btnTextColor,
          ),
          Icon(
            Icons.account_circle_outlined,
            color: AppColors.btnTextColor,
          )
        ],
        index: 0,
        height: 65,
        color: AppColors.btnBackgroundColor,
        buttonBackgroundColor: AppColors.btnBackgroundColor,
        backgroundColor: AppColors.backgroundColor,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 200),
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
          _goBranch(selectedIndex);
        },
      ),
    );
  }
}
