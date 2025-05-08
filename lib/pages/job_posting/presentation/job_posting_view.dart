import 'package:talent_mesh/common/app_enums.dart';
import 'package:talent_mesh/common/utils/extensions/context_extensions.dart';
import 'package:talent_mesh/common/utils/extensions/enum_extensions.dart';
import 'package:talent_mesh/common/utils/extensions/string_extensions.dart';
import 'package:talent_mesh/common/utils/locator.dart';
import 'package:talent_mesh/common/widgets/appbar/custom_app_bar.dart';
import 'package:talent_mesh/common/widgets/button/custom_button.dart';
import 'package:talent_mesh/common/widgets/checkbox/custom_checkbox.dart';
import 'package:talent_mesh/common/widgets/date_picker/custom_date_picker_with_label.dart';
import 'package:talent_mesh/common/widgets/dropdown/searchable_dropdown.dart';
import 'package:talent_mesh/common/widgets/switch/custom_switch_with_label.dart';
import 'package:talent_mesh/common/widgets/textfield/custom_textfield_with_label.dart';
import 'package:talent_mesh/pages/job_listing/model/job_filter_model.dart';
import 'package:talent_mesh/pages/job_posting/domain/job_posting_cubit.dart';
import 'package:talent_mesh/pages/job_posting/domain/job_posting_state.dart';
import 'package:talent_mesh/styles/app_colors.dart';
import 'package:talent_mesh/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobPostingView extends StatefulWidget {
  const JobPostingView({super.key});

  @override
  State<JobPostingView> createState() => _JobPostingViewState();
}

class _JobPostingViewState extends State<JobPostingView> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _jobRoleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _requirementsController = TextEditingController();
  final TextEditingController _responsibilitiesController =
      TextEditingController();
  final TextEditingController _minSalaryController = TextEditingController();
  final TextEditingController _maxSalaryController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();

  final JobFilterModel filters = getFilters();
  late JobPostingCubit _jobPostingCubit;

  @override
  void initState() {
    super.initState();
    _jobPostingCubit = context.read<JobPostingCubit>();
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _jobRoleController.dispose();
    _descriptionController.dispose();
    _requirementsController.dispose();
    _responsibilitiesController.dispose();
    _minSalaryController.dispose();
    _maxSalaryController.dispose();
    _skillsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Post a New Job',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.verticalSpace,

              //--------Company Name
              CustomTextfieldWithLabel(
                isRequired: true,
                labelText: 'Company Name',
                hintText: 'Type here..',
                controller: _companyNameController,
                textInputAction: TextInputAction.next,
              ),
              16.verticalSpace,

              //---------Job Title
              // CustomTextfieldWithLabel(
              //   isRequired: true,
              //   labelText: 'Job Title',
              //   hintText: 'Type here..',
              //   controller: _jobTitleController,
              //   textInputAction: TextInputAction.next,
              // ),
              // 16.verticalSpace,

              //----------Job Role
              CustomTextfieldWithLabel(
                isRequired: true,
                labelText: 'Job Role',
                hintText: 'eg. Software Developer',
                controller: _jobRoleController,
                textInputAction: TextInputAction.next,
              ),
              16.verticalSpace,

              //-----------Description
              CustomTextfieldWithLabel(
                isRequired: true,
                labelText: 'Description',
                hintText: 'A brief description about the job...',
                controller: _descriptionController,
                textInputAction: TextInputAction.next,
                maxLines: 5,
                borderRadius: 8.r,
              ),
              16.verticalSpace,

              //-------------Requirements
              CustomTextfieldWithLabel(
                isRequired: true,
                labelText: 'Requirements',
                hintText: 'A brief of what is required for this job...',
                controller: _requirementsController,
                textInputAction: TextInputAction.next,
                maxLines: 5,
                borderRadius: 8.r,
              ),
              16.verticalSpace,

              //---------------Responsibilities
              CustomTextfieldWithLabel(
                isRequired: true,
                labelText: 'Responsibilities',
                hintText: 'A brief about the responsibilities...',
                controller: _responsibilitiesController,
                textInputAction: TextInputAction.next,
                maxLines: 5,
                borderRadius: 8.r,
              ),
              16.verticalSpace,

              //----------------Experience Level
              SearchableDropdown<ExperienceLevel?>(
                label: 'Experience Level',
                isRequired: true,
                items: filters.experienceLevels ?? [],
                fillColor: AppColors.background,
                getLabel: (value) {
                  return '${value?.yearsFrom ?? 0} years to ${value?.yearsTo ?? 0} years';
                },
                onChanged: (value) {
                  _jobPostingCubit.onChangeExperienceLevel(value!);
                },
              ),
              16.verticalSpace,

              //-------------Required Skills
              CustomTextfieldWithLabel(
                isRequired: true,
                labelText: 'Required Skills (comma separated)',
                hintText: 'eg. Flutter, Android...',
                controller: _skillsController,
                textInputAction: TextInputAction.next,
              ),
              16.verticalSpace,

              //-----------Location & Remote Option
              BlocBuilder<JobPostingCubit, JobPostingState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: SearchableDropdown<Location?>(
                          label: 'Location',
                          initiallySelectedItem: state.location,
                          isRequired: true,
                          items: filters.locations ?? [],
                          fillColor: AppColors.background,
                          getLabel: (value) {
                            return (value?.name ?? '--').toCapitalized();
                          },
                          onChanged: (value) {
                            _jobPostingCubit.onChangeLocation(value!);
                          },
                        ),
                      ),
                      16.horizontalSpace,
                      Expanded(
                        flex: 1,
                        child: CustomSwitchWithLabel(
                          title: 'Remote',
                          initialValue: state.isRemoteJob ?? false,
                          onChanged: (value) {
                            _jobPostingCubit.onChangeRemoteLocation(value);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
              16.verticalSpace,

              //------------Employment Type
              SearchableDropdown<dynamic>(
                label: 'Employment Type',
                isRequired: true,
                items: filters.employmentType ?? [],
                fillColor: AppColors.background,
                getLabel: (value) {
                  return (value ?? '--').toString().toCapitalized();
                },
                onChanged: (value) {
                  _jobPostingCubit.onChangeEmployment(value!);
                },
              ),
              16.verticalSpace,

              // Salary Range
              Text(
                "Salary Range",
                style: AppTextStyles.body4Medium12(),
              ),
              8.verticalSpace,
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomTextfieldWithLabel(
                      labelText: 'Min',
                      labelStyle: AppTextStyles.body5Medium10(),
                      controller: _minSalaryController,
                      hintText: 'Type here...',
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    flex: 2,
                    child: CustomTextfieldWithLabel(
                      labelText: 'Max',
                      labelStyle: AppTextStyles.body5Medium10(),
                      controller: _maxSalaryController,
                      hintText: 'Type here...',
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 4.h,
                      ),
                    ),
                  ),
                ],
              ),
              8.verticalSpace,
              CustomCheckbox(
                label: 'Show salary in job posting',
                onChanged: (value) {
                  _jobPostingCubit.onChangeShowSalary(value);
                },
              ),
              16.verticalSpace,

              //----------Application Deadline
              BlocBuilder<JobPostingCubit, JobPostingState>(
                builder: (context, state) {
                  return CustomDatePickerWithLabel(
                    label: 'Application Deadline',
                    initialValue: state.applicationDeadlineDate,
                    isRequired: true,
                    onChanged: (value) {
                      _jobPostingCubit.onChangeApplicationDeadline(value);
                    },
                  );
                },
              ),
              32.verticalSpace,
            ],
          ),
        ),
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              blurRadius: 16,
              offset: const Offset(0, 8),
              spreadRadius: 0,
              color: context.userRole.accentColor,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              //----------Save as Draft Button
              Expanded(
                child: BlocBuilder<JobPostingCubit, JobPostingState>(
                  builder: (context, state) {
                    return CustomButton(
                      width: double.infinity,
                      verticalPadding: 4.h,
                      horizontalPadding: 8.w,
                      wantBorder: true,
                      isLoading: state.draftJobApiStatus == ApiStatus.loading,
                      buttonColor: AppColors.background,
                      borderColor: context.userRole.accentColor,
                      disableElevation: true,
                      onPressed: () {
                        if (state.jobPostingApiStatus != ApiStatus.loading) {
                          _jobPostingCubit.postJob(
                            companyName: _companyNameController.text.trim(),
                            jobRole: _jobRoleController.text.trim(),
                            description: _descriptionController.text.trim(),
                            requirements: _requirementsController.text.trim(),
                            responsibilities:
                                _responsibilitiesController.text.trim(),
                            requiredSkills: _skillsController.text.trim(),
                            minSalary: _minSalaryController.text.trim(),
                            maxSalary: _maxSalaryController.text.trim(),
                            status: JobStatus.draft.name,
                          );
                        }
                      },
                      child: Text(
                        'Save as Draft',
                        style: AppTextStyles.body2Medium16(
                          color: context.userRole.accentColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
              16.horizontalSpace,

              //---------Post Job Button
              Expanded(
                child: BlocBuilder<JobPostingCubit, JobPostingState>(
                  builder: (context, state) {
                    return CustomButton(
                      width: double.infinity,
                      verticalPadding: 4.h,
                      horizontalPadding: 8.w,
                      wantBorder: false,
                      disableElevation: true,
                      isLoading: state.jobPostingApiStatus == ApiStatus.loading,
                      buttonColor: context.userRole.accentColor,
                      onPressed: () {
                        if (state.jobPostingApiStatus != ApiStatus.loading) {
                          _jobPostingCubit.postJob(
                            companyName: _companyNameController.text.trim(),
                            jobRole: _jobRoleController.text.trim(),
                            description: _descriptionController.text.trim(),
                            requirements: _requirementsController.text.trim(),
                            responsibilities:
                                _responsibilitiesController.text.trim(),
                            requiredSkills: _skillsController.text.trim(),
                            minSalary: _minSalaryController.text.trim(),
                            maxSalary: _maxSalaryController.text.trim(),
                            status: JobStatus.active.name,
                          );
                        }
                      },
                      child: Text(
                        'Post Job',
                        style: AppTextStyles.body2Medium16(
                          color: AppColors.surface,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
