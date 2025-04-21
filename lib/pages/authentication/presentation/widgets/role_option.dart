import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoleOption extends StatelessWidget {
  final bool isSelected;
  final String title;
  final VoidCallback onTap;
  const RoleOption({
    required this.title,
    required this.onTap,
    this.isSelected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
            width: 1,
          ),
        ),
        child: Text(
          title,
          style: AppTextStyles.body3Medium14(
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
