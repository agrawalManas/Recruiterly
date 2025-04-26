import 'package:cades_flutter_template/common/utils/extensions/context_extensions.dart';
import 'package:cades_flutter_template/common/utils/extensions/enum_extensions.dart';
import 'package:cades_flutter_template/common/utils/utils.dart';
import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDatePickerWithLabel extends StatelessWidget {
  final String label;
  final Color? fillColor;
  final bool isRequired;
  final DateTime? initialValue;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final void Function(DateTime? value)? onChanged;
  CustomDatePickerWithLabel({
    required this.label,
    this.isRequired = false,
    this.fillColor = AppColors.background,
    this.onChanged,
    this.initialValue,
    this.firstDate,
    this.lastDate,
    super.key,
  }) : _dateNotifier = ValueNotifier<DateTime?>(initialValue);

  final ValueNotifier<DateTime?> _dateNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: Row(
            children: [
              Text(
                label,
                style: AppTextStyles.body4Medium12(),
              ),
              if (isRequired)
                Text(
                  '*',
                  style: AppTextStyles.body4Medium12(
                    color: AppColors.error,
                  ),
                ),
            ],
          ),
        ),
        4.verticalSpace,
        GestureDetector(
          onTap: () async {
            final selectedDate = await Utils.openDatePicker(
              context: context,
              firstDate: firstDate ?? DateTime.now(),
              lastDate: lastDate ?? DateTime(DateTime.now().year + 1),
              initialDate: initialValue,
            );
            if (selectedDate != null) {
              _dateNotifier.value = selectedDate;
            }
            onChanged?.call(selectedDate);
          },
          child: Container(
            decoration: BoxDecoration(
              color: fillColor,
              borderRadius: BorderRadius.all(
                Radius.circular(8.r),
              ),
              border: Border.all(
                color: AppColors.textSecondary.withOpacity(0.2),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ValueListenableBuilder<DateTime?>(
                  valueListenable: _dateNotifier,
                  builder: (context, value, child) {
                    return Text(
                      value == null
                          ? 'Select Date'
                          : Utils.formatToddMMMYYYY(value),
                      style: AppTextStyles.body3Regular14(
                        color: value != null
                            ? AppColors.textPrimary
                            : AppColors.disabledText,
                      ),
                    );
                  },
                ),
                Icon(
                  Icons.calendar_month_outlined,
                  size: 24,
                  color: context.userRole.accentColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
