import 'package:talent_mesh/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final double? radius;
  const CircularIconButton({
    required this.icon,
    required this.onTap,
    this.backgroundColor,
    this.radius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: backgroundColor ?? AppColors.surface,
        radius: radius ?? 18.r,
        child: icon,
      ),
    );
  }
}
