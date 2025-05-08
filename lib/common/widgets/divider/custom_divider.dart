import 'package:talent_mesh/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDivider extends StatelessWidget {
  final double? height;
  final double? thickness;
  final Color? color;
  const CustomDivider({
    this.height,
    this.thickness = 1,
    this.color = AppColors.disabledText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height ?? 48.h,
      thickness: thickness,
      color: color,
    );
  }
}
