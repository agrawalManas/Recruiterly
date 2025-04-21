import 'package:cades_flutter_template/common/navigation/app_routes.dart';
import 'package:cades_flutter_template/common/utils/extensions/context_extensions.dart';
import 'package:cades_flutter_template/common/utils/extensions/enum_extensions.dart';
import 'package:cades_flutter_template/common/utils/extensions/string_extensions.dart';
import 'package:cades_flutter_template/common/utils/locator.dart';
import 'package:cades_flutter_template/common/widgets/button/custom_button.dart';
import 'package:cades_flutter_template/common/widgets/dropdown/searchable_popup_menu.dart';
import 'package:cades_flutter_template/common/widgets/switch/custom_switch_with_label.dart';
import 'package:cades_flutter_template/pages/dashboard/models/job_model.dart';
import 'package:cades_flutter_template/pages/job_listing/domain/job_listing_cubit.dart';
import 'package:cades_flutter_template/pages/job_listing/domain/job_listing_state.dart';
import 'package:cades_flutter_template/pages/job_listing/model/job_filter_model.dart';
import 'package:cades_flutter_template/pages/job_listing/presentation/widgets/fitler_option_with_header.dart';
import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBottomsheet extends StatefulWidget {
  final JobFilterModel? filters;
  const FilterBottomsheet({
    required this.filters,
    super.key,
  });

  @override
  State<FilterBottomsheet> createState() => _FilterBottomsheetState();
}

class _FilterBottomsheetState extends State<FilterBottomsheet> {
  late JobListingCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<JobListingCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.92,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //----------HEADER---------
          DecoratedBox(
            decoration: BoxDecoration(
              color: context.userRole.accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
              border: Border(
                bottom: BorderSide(
                  color: AppColors.surface.withOpacity(0.4),
                  width: 0.5,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w)
                  .copyWith(top: 16.h, bottom: 8.h),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: () {
                      AppRoutes.appRouter.pop();
                    },
                    child: const Icon(
                      Icons.clear,
                      color: AppColors.surface,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Filters',
                    style: AppTextStyles.body2SemiBold16(
                      color: AppColors.surface,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          24.verticalSpace,

          if (widget.filters != null)
            Expanded(
              child: _buildFilterList(filters: widget.filters),
            )
          else
            Text(
              'No Filters available at the moment!',
              style: AppTextStyles.body1SemiBold18(),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterList({required JobFilterModel? filters}) {
    return BlocBuilder<JobListingCubit, JobListingState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //---------JOB-ROlE
                      if ((filters?.jobRoles ?? []).isNotEmpty) ...[
                        SearchablePopupMenu<Filter?>(
                          label: 'Role',
                          initiallySelectedItem: state.role,
                          items: filters?.jobRoles ?? [],
                          getLabel: (value) {
                            return value?.name ?? 'Role-';
                          },
                          onChanged: (value) {
                            _cubit.setRoleFilter(value);
                          },
                        ),
                        16.verticalSpace,
                      ],

                      // //---------INDUSTRY
                      // SearchablePopupMenu<Filter>(
                      //   items: [],
                      //   getLabel: (value) {
                      //     return value.name ?? 'Industry-';
                      //   },
                      //   onChanged: (value) {},
                      // ),
                      // CustomDivider(
                      //   height: 16.h,
                      //   thickness: 0.5,
                      //   color: AppColors.disabledButton,
                      // ),

                      //---------EXPERIENCE-LEVEL
                      if ((filters?.experienceLevels ?? []).isNotEmpty) ...[
                        SearchablePopupMenu<ExperienceLevel?>(
                          label: 'Experience Level',
                          initiallySelectedItem: state.experienceLevel,
                          items: filters?.experienceLevels ?? [],
                          getLabel: (value) {
                            return '${value?.yearsFrom ?? 0} years to ${value?.yearsTo ?? 0} years';
                          },
                          onChanged: (value) {
                            _cubit.setExperienceLevelFilter(value);
                          },
                        ),
                        16.verticalSpace,
                      ],

                      //------------SKILLS
                      if ((filters?.skills ?? []).isNotEmpty) ...[
                        FilterOptionWithHeader<Skill?>(
                          label: 'Skills',
                          filterOptions: filters?.skills ?? [],
                          getFilterOptionText: (value) {
                            return value?.name ?? '--';
                          },
                          selectedIndex: -1,
                          onFilterTapped: (value) {
                            _cubit.setSkillFilter(value?.name);
                          },
                        ),
                        16.verticalSpace,
                      ],

                      //---------SALARY-RANGE
                      if ((filters?.salaryRange ?? []).isNotEmpty) ...[
                        SearchablePopupMenu<SalaryRange?>(
                          initiallySelectedItem: state.salaryRange,
                          label: 'Salary Range',
                          items: filters?.salaryRange ?? [],
                          getLabel: (value) {
                            return '₹${value?.min ?? 0} to ₹${value?.max ?? 0}';
                          },
                          onChanged: (value) {
                            _cubit.setSalaryRangeFilter(value);
                          },
                        ),
                        16.verticalSpace,
                      ],

                      //---------LOCATION
                      if ((filters?.locations ?? []).isNotEmpty) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: SearchablePopupMenu<Location?>(
                                label: 'Location',
                                initiallySelectedItem: state.location,
                                items: filters?.locations ?? [],
                                getLabel: (value) {
                                  return value?.name ?? 'Location-';
                                },
                                onChanged: (value) {
                                  _cubit.setLocationFilter(value);
                                },
                              ),
                            ),
                            16.horizontalSpace,
                            Expanded(
                              flex: 1,
                              child: CustomSwitchWithLabel(
                                title: 'Remote only',
                                initialValue: state.remote ?? false,
                                onChanged: (value) {
                                  _cubit.setRemoteFilter(value);
                                },
                              ),
                            ),
                          ],
                        ),
                        16.verticalSpace,
                      ],

                      //-------------EMPLOYMENT-TYPE
                      if ((filters?.employmentType ?? []).isNotEmpty) ...[
                        SearchablePopupMenu<dynamic>(
                          label: 'Employment Type',
                          initiallySelectedItem: state.employmentType,
                          items: filters?.employmentType ?? [],
                          getLabel: (value) {
                            return value?.toCapitalized() ?? 'Employment Type-';
                          },
                          onChanged: (value) {
                            _cubit.setEmploymentTypeFilter(value.toString());
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            12.verticalSpace,
            SafeArea(
              top: false,
              bottom: true,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  border: Border(
                    top: BorderSide(
                      color: getUser().role?.userRole.accentColor ??
                          AppColors.surface,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //-------Clear-Btn
                      TextButton(
                        onPressed: () {
                          _cubit.clearFilters();
                        },
                        child: Text(
                          'Clear',
                          style: AppTextStyles.body3Regular14().copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor:
                                getUser().role?.userRole.accentColor,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 1,
                        child: CustomButton(
                          wantBorder: false,
                          verticalPadding: 8.h,
                          horizontalPadding: 16.w,
                          disableElevation: true,
                          onPressed: () {
                            _cubit.getJobs();
                            AppRoutes.appRouter.pop();
                          },
                          child: Text(
                            'Apply',
                            style: AppTextStyles.body3Regular14(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
