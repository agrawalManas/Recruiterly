import 'package:talent_mesh/common/utils/extensions/context_extensions.dart';
import 'package:talent_mesh/common/utils/extensions/enum_extensions.dart';
import 'package:talent_mesh/styles/app_colors.dart';
import 'package:talent_mesh/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSwitchWithLabel extends StatelessWidget {
  final String? title;
  final ValueChanged<bool>? onChanged;
  final Color backgroundColor;
  final Color thumbColor;
  final Color trackColor;
  final Color activeTrackColor;
  final Color textColor;

  final ValueNotifier<bool> switchState;

  CustomSwitchWithLabel({
    super.key,
    this.title,
    bool initialValue = false,
    this.onChanged,
    this.backgroundColor = AppColors.disabledButton,
    this.thumbColor = AppColors.disabledText,
    this.trackColor = AppColors.disabledButton,
    this.activeTrackColor = AppColors.disabledButton,
    this.textColor = AppColors.textPrimary,
  }) : switchState = ValueNotifier<bool>(initialValue);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: AppTextStyles.body4Medium12(),
          ),
          6.verticalSpace,
        ],
        ValueListenableBuilder<bool>(
          valueListenable: switchState,
          builder: (context, isActive, _) {
            return Switch(
              value: isActive,
              onChanged: (value) {
                switchState.value = value;
                onChanged?.call(value);
              },
              activeTrackColor:
                  isActive ? AppColors.disabledButton : activeTrackColor,
              inactiveTrackColor: trackColor,
              trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
              thumbColor: WidgetStateProperty.all(
                isActive ? context.userRole.accentColor : thumbColor,
              ),
              trackOutlineWidth: WidgetStateProperty.all(0),
              thumbIcon: WidgetStateProperty.all(
                const Icon(null, size: 0),
              ),
            );
          },
        ),
      ],
    );
  }
}
