import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWithSearchAndCrossIcon extends StatelessWidget {
  const TextFieldWithSearchAndCrossIcon({
    super.key,
    required this.controller,
    this.onEditingComplete,
    this.onSearchIconTapped,
    this.onCrossIconTapped,
    this.fillColor = AppColors.surface,
    this.iconColor,
    this.hintText,
    this.showPrefix = true,
    this.autoFocus = true,
  });
  final TextEditingController controller;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onSearchIconTapped;
  final VoidCallback? onCrossIconTapped;
  final Color fillColor;
  final Color? iconColor;
  final String? hintText;
  final bool showPrefix;
  final bool autoFocus;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.w),
      child: TextFormField(
        style: AppTextStyles.body2Regular16(),
        autofocus: autoFocus,
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: showPrefix
              ? GestureDetector(
                  onTap: onSearchIconTapped,
                  child: Container(
                    color: Colors.transparent,
                    child: Icon(Icons.search, size: 20.w),
                  ),
                )
              : null,
          fillColor: fillColor,
          filled: true,
          border: InputBorder.none,
          hintText: hintText ?? "\t\t\tSearch Module or Features",
          hintStyle: AppTextStyles.body4Regular12(
            color: AppColors.textSecondary,
          ),
          suffixIcon: InkWell(
            onTap: onCrossIconTapped,
            child: Icon(
              Icons.close,
              size: 20.w,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
