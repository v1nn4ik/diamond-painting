import 'package:flutter/material.dart';

class CustomButtonSelection extends StatelessWidget {
  final double width;
  final double height;
  final String imageUrl;
  final double? borderRadius;
  final VoidCallback onTap;
  const CustomButtonSelection({
    super.key,
    this.width = 90,
    this.height = 130,
    required this.imageUrl,
    required this.onTap,
    this.borderRadius = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: ElevatedButton(
        onPressed: onTap,
        clipBehavior: Clip.antiAlias,
        style: ElevatedButton.styleFrom(
          maximumSize: Size(width, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          padding: EdgeInsets.zero,
          elevation: 4,
        ),
        child: Image.network(
          imageUrl,
          width: width,
          height: height,
        ),
      ),
    );
  }
}
