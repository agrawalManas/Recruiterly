import 'package:cades_flutter_template/common/utils/extensions/context_extensions.dart';
import 'package:cades_flutter_template/common/utils/extensions/enum_extensions.dart';
import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final String label;
  final bool isInitiallySelected;
  final Color? checkColor;
  final Color? activeColor;
  final Color? inactiveColor;
  final TextStyle? labelStyle;
  final void Function(bool)? onChanged;
  final ValueNotifier<bool> _selectionNotifier;

  CustomCheckbox({
    required this.label,
    this.checkColor,
    this.activeColor,
    this.inactiveColor,
    this.labelStyle,
    this.onChanged,
    this.isInitiallySelected = false,
    super.key,
  }) : _selectionNotifier = ValueNotifier<bool>(isInitiallySelected);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: _selectionNotifier,
          builder: (context, isChecked, _) {
            final accentColor = context.userRole.accentColor;
            return Checkbox(
              visualDensity: const VisualDensity(
                horizontal: -4,
                vertical: -4,
              ),
              value: isChecked,
              onChanged: (value) {
                _selectionNotifier.value = value!;
                onChanged?.call(value);
              },
              checkColor: checkColor ?? AppColors.background,
              activeColor: activeColor ?? accentColor,
              side: BorderSide(
                color: inactiveColor ?? accentColor,
                width: 1.5,
              ),
            );
          },
        ),
        Flexible(
          child: Text(
            label,
            style: labelStyle ?? AppTextStyles.body3Regular14(),
          ),
        ),
      ],
    );
  }
}
