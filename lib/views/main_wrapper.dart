import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:diamond_painting/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: CurvedNavigationBar(
        items: <Widget>[
          SvgPicture.asset(
            'assets/icons/navigation_bar/works.svg',
          ),
          SvgPicture.asset(
            'assets/icons/navigation_bar/diamond.svg',
          ),
          SvgPicture.asset(
            'assets/icons/navigation_bar/person.svg',
          ),
        ],
        index: widget.navigationShell.currentIndex,
        height: 55,
        color: AppColors.btnBackgroundColor,
        buttonBackgroundColor: AppColors.btnBackgroundColor,
        backgroundColor: AppColors.backgroundColor,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 200),
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
