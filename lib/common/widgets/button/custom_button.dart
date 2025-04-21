import 'package:cades_flutter_template/common/utils/extensions/context_extensions.dart';
import 'package:cades_flutter_template/common/utils/extensions/enum_extensions.dart';
import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool? isDisabled;
  final bool isLoading;
  final Widget? child;
  final Color? buttonColor;
  final Color? hoverColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? width;
  final bool? wantBorder;
  final bool? disableElevation;
  final Color? borderColor;
  final Color? disabledColor;
  final double? height;
  final double? borderRadius;
  final InteractiveInkFeatureFactory? splashFactory;
  final bool showGlowEffect;
  final Color? glowColor;
  final double? glowSpreadRadius;
  final double? glowBlurRadius;

  /// If [onPressed] is null or [isLoading] is true, the button is disabled.
  const CustomButton({
    super.key,
    this.onPressed,
    this.isDisabled,
    this.isLoading = false,
    this.child,
    this.buttonColor,
    this.hoverColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.width,
    this.wantBorder,
    this.borderColor,
    this.disableElevation,
    this.disabledColor,
    this.height,
    this.borderRadius,
    this.splashFactory,
    this.showGlowEffect = false,
    this.glowColor,
    this.glowSpreadRadius,
    this.glowBlurRadius,
  });

  @override
  Widget build(BuildContext context) {
    bool enabled = _checkEnabled();
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          elevation: disableElevation == true ? 0 : null,
          splashFactory: splashFactory ?? NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 24.r),
            side: wantBorder == true
                ? BorderSide(
                    width: 1,
                    color: borderColor ?? AppColors.surface,
                  )
                : BorderSide.none,
          ),
          backgroundColor: enabled
              ? (buttonColor ?? context.userRole.accentColor)
              : AppColors.disabledButton,
          disabledForegroundColor: AppColors.disabledText,
          disabledBackgroundColor: disabledColor ?? AppColors.disabledButton,
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding ?? 8.h,
            horizontal: horizontalPadding ?? 0,
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 20.w,
                height: 20.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    buttonColor ?? context.userRole.accentColor,
                  ),
                ),
              )
            : child,
      ),
    );
  }

  bool _checkEnabled() {
    return !(isDisabled ?? false) && !isLoading;
  }
}
