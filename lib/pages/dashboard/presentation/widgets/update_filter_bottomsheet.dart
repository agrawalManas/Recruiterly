import 'package:cades_flutter_template/common/app_enums.dart';
import 'package:cades_flutter_template/common/utils/extensions/context_extensions.dart';
import 'package:cades_flutter_template/common/utils/extensions/enum_extensions.dart';
import 'package:cades_flutter_template/common/utils/extensions/string_extensions.dart';
import 'package:cades_flutter_template/common/widgets/bottomsheet/custom_bottomsheet_header.dart';
import 'package:cades_flutter_template/common/widgets/button/custom_button.dart';
import 'package:cades_flutter_template/common/widgets/textfield/custom_textfield_with_label.dart';
import 'package:cades_flutter_template/pages/dashboard/domain/dashboard_cubit.dart';
import 'package:cades_flutter_template/pages/dashboard/domain/dashboard_state.dart';
import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateFilterBottomsheet extends StatelessWidget {
  final String title;
  final String description;
  final bool isSalaryFilter;
  final DashboardCubit cubit;
  UpdateFilterBottomsheet({
    required this.title,
    required this.description,
    required this.cubit,
    this.isSalaryFilter = false,
    super.key,
  });

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomBottomsheetHeader(
          title: description,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                24.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTextfieldWithLabel(
                        controller: _controller,
                        fillColor: AppColors.surface,
                        labelText: isSalaryFilter ? 'From' : title,
                        hintText: isSalaryFilter
                            ? 'eg. 300000'
                            : _getHintText(title: title),
                        isRequired: true,
                        textInputAction: isSalaryFilter
                            ? TextInputAction.next
                            : TextInputAction.done,
                        textInputType: isSalaryFilter
                            ? const TextInputType.numberWithOptions(
                                decimal: true,
                              )
                            : null,
                      ),
                    ),
                    if (isSalaryFilter) ...[
                      16.horizontalSpace,
                      Expanded(
                        child: CustomTextfieldWithLabel(
                          labelText: isSalaryFilter ? 'To' : title,
                          isRequired: true,
                          hintText: '400000',
                          controller: _controller2,
                          fillColor: AppColors.surface,
                          textInputAction: isSalaryFilter
                              ? TextInputAction.next
                              : TextInputAction.done,
                          textInputType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                32.verticalSpace,
              ],
            ),
          ),
        ),
        SafeArea(
          top: false,
          bottom: true,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.background,
              boxShadow: [
                BoxShadow(
                  blurRadius: 16,
                  offset: const Offset(0, -8),
                  spreadRadius: 0,
                  color: context.userRole.accentColor.withOpacity(0.3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: BlocBuilder<DashboardCubit, DashboardState>(
                builder: (context, state) {
                  return CustomButton(
                    width: double.infinity,
                    verticalPadding: 4.h,
                    horizontalPadding: 8.w,
                    wantBorder: false,
                    isLoading: state.addFilterApiStatus == ApiStatus.loading,
                    buttonColor: context.userRole.accentColor,
                    disableElevation: true,
                    onPressed: () {
                      if (state.addFilterApiStatus != ApiStatus.loading) {
                        if (title.filterType == JobFilters.salaryRange) {
                          cubit.updateFilters(
                            filterType: title.filterType,
                            min: num.parse(_controller.text.toString().trim()),
                            max: num.parse(_controller2.text.toString().trim()),
                          );
                        } else if (title.filterType ==
                            JobFilters.experienceLevels) {
                          final years = _controller.text.split('to');
                          cubit.updateFilters(
                            filterType: title.filterType,
                            yearsFrom: num.parse(years.first.toString().trim()),
                            yearsTo: num.parse(years.last.toString().trim()),
                          );
                        } else {
                          cubit.updateFilters(
                            filterType: title.filterType,
                            text: _controller.text.trim(),
                          );
                        }
                      }
                    },
                    child: Text(
                      'Update this Filter',
                      style: AppTextStyles.body2Medium16(
                        color: AppColors.surface,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getHintText({required String title}) {
    switch (title) {
      case 'Job Role':
        return 'eg. Software Developer';
      case 'Experience Level':
        return 'eg. 2 to 3';
      case 'Skill':
        return 'eg. Flutter, Android';
      case 'Location':
        return 'eg. Gurugram, Banglore';
      case 'Employment Type':
        return 'eg. Full-Time';
      default:
        return 'Type here...';
    }
  }
}
