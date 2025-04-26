// ignore_for_file: must_be_immutable
import 'package:cades_flutter_template/common/utils/extensions/context_extensions.dart';
import 'package:cades_flutter_template/common/utils/extensions/enum_extensions.dart';
import 'package:cades_flutter_template/common/widgets/chip/custom_chip.dart';
import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ChipSelector<T> extends StatelessWidget {
  final List<T> options;
  List<T> initiallySelectedOptions;
  final bool isMultiSelect;
  final double? borderRadius;
  final void Function(List<T>)? onSelectOption;
  final String Function(T value) getText;
  final String? Function(T value)? getDescription;
  final ValueNotifier<List<T>> _selectedOptionsNotifier;

  ChipSelector({
    required this.options,
    required this.isMultiSelect,
    required this.getText,
    this.initiallySelectedOptions = const [],
    this.getDescription,
    this.onSelectOption,
    this.borderRadius,
    super.key,
  }) : _selectedOptionsNotifier = ValueNotifier<List<T>>(
          initiallySelectedOptions,
        );

  void _toggleSelection(T option) {
    final currentSelections = List<T>.from(_selectedOptionsNotifier.value);

    if (isMultiSelect) {
      // Multi-select mode
      if (currentSelections.contains(option)) {
        currentSelections.remove(option);
      } else {
        currentSelections.add(option);
      }
    } else {
      // Single-select mode
      if (currentSelections.contains(option)) {
        currentSelections.clear();
      } else {
        currentSelections.clear();
        currentSelections.add(option);
      }
    }

    _selectedOptionsNotifier.value = currentSelections;
    onSelectOption?.call(currentSelections);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<T>>(
      valueListenable: _selectedOptionsNotifier,
      builder: (context, selectedOptions, _) {
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: options.map((option) {
            final isSelected = selectedOptions.contains(option);
            return FittedBox(
              child: CustomChip(
                text: getText(option),
                borderRadius: borderRadius,
                description:
                    getDescription != null ? getDescription!(option) : null,
                backgroundColor: isSelected
                    ? context.userRole.accentColor.withOpacity(0.05)
                    : AppColors.surface,
                isSelected: isSelected,
                textColor: isSelected ? context.userRole.accentColor : null,
                onTap: () => _toggleSelection(option),
                borderColor: isSelected ? context.userRole.accentColor : null,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
