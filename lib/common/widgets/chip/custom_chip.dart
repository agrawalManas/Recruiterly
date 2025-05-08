import 'package:talent_mesh/styles/app_colors.dart';
import 'package:talent_mesh/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomChip extends StatelessWidget {
  final String text;
  final String? description;
  final bool isTappable;
  final double? borderRadius;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final Color backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final double height;
  final VoidCallback? onTap;
  final bool isSelected;
  final TextStyle? textStyle;
  final double? leftIconPadding;
  final double? rightIconPadding;
  final EdgeInsets? contentPadding;
  final bool strikeOut;

  const CustomChip({
    super.key,
    required this.backgroundColor,
    required this.text,
    this.description,
    this.isTappable = false,
    this.borderRadius,
    this.leftIcon,
    this.rightIcon,
    this.borderColor,
    this.textColor = AppColors.textPrimary,
    this.height = 20,
    this.onTap,
    this.isSelected = false,
    this.textStyle,
    this.leftIconPadding,
    this.rightIconPadding,
    this.contentPadding,
    this.strikeOut = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 6.w,
              vertical: 4.h,
            ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
          border: Border.all(
            color: borderColor ??
                AppColors.textSecondary.withValues(
                  alpha: 0.3,
                ),
            width: 1,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //-------LEFT-ICON
                  Padding(
                    padding: EdgeInsets.only(right: leftIconPadding ?? 4.w),
                    child: leftIcon ?? const SizedBox.shrink(),
                  ),

                  //--------TITLE
                  Text(
                    text,
                    style: textStyle ??
                        AppTextStyles.body4Regular12(
                          color: textColor,
                        ),
                  ),

                  //---------RIGHT-ICON
                  Padding(
                    padding: EdgeInsets.only(left: rightIconPadding ?? 4.w),
                    child: rightIcon ?? const SizedBox.shrink(),
                  ),
                ],
              ),

              //----------DESCRIPTION
              if ((description ?? '').isNotEmpty) ...[
                4.verticalSpace,
                Text(
                  description ?? '',
                  style: AppTextStyles.body5Regular10(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
