import 'package:cades_flutter_template/common/utils/extensions/context_extensions.dart';
import 'package:cades_flutter_template/common/utils/extensions/enum_extensions.dart';
import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomChip extends StatelessWidget {
  final String text;
  final bool isTappable;
  final double borderRadius;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final Color backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final double height;
  final VoidCallback? onTap;
  final bool isSelected;
  final Color? glowColor;
  final double blurRadius;
  final double spreadRadius;
  final TextStyle? textStyle;
  final double? leftIconPadding;
  final double? rightIconPadding;
  final EdgeInsets? contentPadding;
  final Offset offset;
  final bool strikeOut;

  const CustomChip({
    super.key,
    required this.backgroundColor,
    required this.text,
    this.isTappable = false,
    this.borderRadius = 16,
    this.leftIcon,
    this.rightIcon,
    this.borderColor,
    this.textColor = AppColors.textPrimary,
    this.height = 20,
    this.onTap,
    this.isSelected = false,
    this.glowColor,
    this.blurRadius = 8,
    this.spreadRadius = 1,
    this.textStyle,
    this.leftIconPadding,
    this.rightIconPadding,
    this.contentPadding,
    this.offset = Offset.zero,
    this.strikeOut = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor ?? AppColors.textSecondary.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color:
                        (glowColor ?? context.userRole.accentColor).withOpacity(
                      0.4,
                    ),
                    blurRadius: blurRadius,
                    spreadRadius: spreadRadius,
                    offset: offset,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(right: leftIconPadding ?? 4.w),
                child: leftIcon ?? const SizedBox.shrink(),
              ),
              Text(
                text,
                style: textStyle ?? AppTextStyles.body4Regular12(),
              ),
              Padding(
                padding: EdgeInsets.only(left: rightIconPadding ?? 4.w),
                child: rightIcon ?? const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
