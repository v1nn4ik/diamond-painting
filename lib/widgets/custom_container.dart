import 'package:diamond_painting/app_colors.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? color;
  final Color? shadowColor;
  final double? shadowRadius;
  final double? offsetX;
  final double? offsetY;
  final double? paddingLeft;
  final double? paddingRight;
  final String? imageUrl;
  final VoidCallback? onTap;

  const CustomContainer({
    super.key,
    this.width = 180,
    this.height = 280,
    this.borderRadius = 15,
    this.shadowColor = Colors.grey,
    this.shadowRadius = 20,
    this.offsetX = 0,
    this.offsetY = 4,
    this.paddingLeft = 0,
    this.paddingRight = 0,
    this.color = AppColors.warEnableTextColor,
    this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: paddingLeft!, right: paddingRight!),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius!)),
          boxShadow: [
            BoxShadow(
              color: shadowColor!,
              blurRadius: shadowRadius!,
              offset: Offset(
                offsetX!,
                offsetY!,
              ),
            )
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius!)),
            color: color,
          ),
          child: imageUrl != null
              ? Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(imageUrl!),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(borderRadius!))),
                )
              : null,
        ),
      ),
    );
  }
}
