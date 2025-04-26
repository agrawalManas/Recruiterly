import 'package:cades_flutter_template/common/image_loader.dart';
import 'package:cades_flutter_template/common/utils/extensions/context_extensions.dart';
import 'package:cades_flutter_template/common/utils/extensions/enum_extensions.dart';
import 'package:cades_flutter_template/common/widgets/chip/custom_chip.dart';
import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterOptionWithHeader<T> extends StatelessWidget {
  final String label;
  final List<T> filterOptions;
  final String Function(T) getFilterOptionText;
  final String Function(T)? getIconPath;
  final void Function(T)? onFilterTapped;
  final int selectedIndex;

  final ValueNotifier<int> _selectedFilter;

  FilterOptionWithHeader({
    required this.label,
    required this.filterOptions,
    required this.getFilterOptionText,
    this.getIconPath,
    this.onFilterTapped,
    required this.selectedIndex,
    super.key,
  }) : _selectedFilter = ValueNotifier<int>(selectedIndex);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.body3Bold14(),
        ),
        16.verticalSpace,
        Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.end,
          spacing: 16.w,
          runSpacing: 8.w,
          children: [
            ...List.generate(
              filterOptions.length,
              (index) {
                return FittedBox(
                  child: ValueListenableBuilder<int>(
                    valueListenable: _selectedFilter,
                    builder: (context, value, child) {
                      return CustomChip(
                        onTap: () {
                          if (value != index) {
                            _selectedFilter.value = index;
                            onFilterTapped?.call(filterOptions[index]);
                          }
                        },
                        textStyle: AppTextStyles.body4Regular12(
                          fontWeight: value == index
                              ? FontWeight.w400
                              : FontWeight.w300,
                        ),
                        backgroundColor: AppColors.background
                            .withOpacity(value == index ? 1.0 : 0.9),
                        text: getFilterOptionText(filterOptions[index]),
                        // blurRadius: value == index ? 12 : 4,
                        // spreadRadius: value == index ? 4 : 1,
                        // glowColor: value == index
                        //     ? context.userRole.accentColor.withOpacity(
                        //         0.4,
                        //       )
                        //     : AppColors.textSecondary.withOpacity(0.3),
                        borderColor: value == index
                            ? context.userRole.accentColor.withOpacity(0.9)
                            : Colors.transparent,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 4.h,
                          horizontal: 3.w,
                        ),
                        leftIcon: getIconPath != null
                            ? ImageLoader.cachedNetworkImage(
                                getIconPath!(filterOptions[index]),
                                height: 20,
                                width: 20,
                              )
                            : const SizedBox.shrink(),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
