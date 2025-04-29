// Page 3: Skills & Preferences
import 'package:cades_flutter_template/common/utils/extensions/context_extensions.dart';
import 'package:cades_flutter_template/common/utils/extensions/enum_extensions.dart';
import 'package:cades_flutter_template/common/widgets/chip/chip_selector.dart';
import 'package:cades_flutter_template/common/widgets/chip/custom_chip.dart';
import 'package:cades_flutter_template/common/widgets/dropdown/searchable_dropdown.dart';
import 'package:cades_flutter_template/common/widgets/textfield/custom_textfield_with_label.dart';
import 'package:cades_flutter_template/pages/job_listing/model/job_filter_model.dart';
import 'package:cades_flutter_template/pages/onboarding/domain/candidate/candidate_onboarding_cubit.dart';
import 'package:cades_flutter_template/pages/onboarding/domain/candidate/candidate_onboarding_state.dart';
import 'package:cades_flutter_template/pages/onboarding/domain/onboarding_cubit.dart';
import 'package:cades_flutter_template/pages/onboarding/domain/onboarding_state.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CandidateOnboardingStep3 extends StatefulWidget {
  const CandidateOnboardingStep3({
    super.key,
  });

  @override
  State<CandidateOnboardingStep3> createState() =>
      _CandidateOnboardingStep3State();
}

class _CandidateOnboardingStep3State extends State<CandidateOnboardingStep3> {
  late CandidateOnboardingCubit _candidateOnboardingCubit;

  @override
  void initState() {
    super.initState();
    _candidateOnboardingCubit = context.read<CandidateOnboardingCubit>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select your skills and preferences",
            style: AppTextStyles.body2SemiBold16(
              color: context.userRole.accentColor,
            ),
          ),
          24.verticalSpace,

          //------------Skills
          Text(
            "Add Relevant Skills",
            style: AppTextStyles.body3SemiBold14(),
          ),
          12.verticalSpace,
          BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              return SearchableDropdown<Skill?>(
                items: state.filters?.skills ?? [],
                getLabel: (value) {
                  return value?.name ?? '--';
                },
                onChanged: (skill) {
                  _candidateOnboardingCubit.onSelectCandidateSkills(skill);
                },
              );
            },
          ),

          //-----------Selected-Skills
          BlocBuilder<CandidateOnboardingCubit, CandidateOnboardingState>(
            builder: (context, state) {
              return Column(
                children: [
                  8.verticalSpace,
                  Wrap(
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.start,
                    spacing: 8.w,
                    runSpacing: 6.h,
                    children: List.generate(
                      (state.candidateSkills ?? []).length,
                      (index) {
                        final skill = state.candidateSkills?[index];
                        return FittedBox(
                          child: CustomChip(
                            backgroundColor: context.userRole.accentColor
                                .withValues(alpha: 0.03),
                            text: skill?.name ?? '--',
                            textColor: context.userRole.accentColor,
                            borderRadius: 8.r,
                            borderColor: context.userRole.accentColor,
                            rightIcon: GestureDetector(
                              onTap: () {
                                _candidateOnboardingCubit
                                    .onRemoveSelectedSkill(index);
                              },
                              child: const Icon(
                                Icons.clear,
                                size: 14,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          24.verticalSpace,

          //----------Expected Salary
          Text(
            "Expected Salary Range(LPA)",
            style: AppTextStyles.body3SemiBold14(),
          ),
          12.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: CustomTextfieldWithLabel(
                  isRequired: true,
                  labelText: 'Minimum',
                  hintText: '₹ 2,00,000',
                  controller: _candidateOnboardingCubit.minSalaryController,
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  // prefixWidget: const Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text('₹ '),
                  //   ],
                  // ),
                  // contentPadding: EdgeInsets.symmetric(hori,
                  // onChanged: (value) {
                  //   widget.candidateOnboardingCubit
                  //       .updateMinSalary(int.tryParse(value) ?? 0);
                  // },
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 16.h),
                child: Text(
                  'to',
                  style: AppTextStyles.body4Medium12(),
                ),
              ),
              Expanded(
                child: CustomTextfieldWithLabel(
                  isRequired: true,
                  labelText: 'Maximum',
                  hintText: '₹4,00,000',
                  controller: _candidateOnboardingCubit.maxSalaryController,
                  textInputType: TextInputType.number,
                  // prefixText: '₹ ',
                  // onChanged: (value) {
                  //   widget.candidateOnboardingCubit
                  //       .updateMaxSalary(int.tryParse(value) ?? 0);
                  // },
                ),
              ),
            ],
          ),
          24.verticalSpace,

          //----------Preferred-Locations
          Text(
            "Preferred Locations",
            style: AppTextStyles.body3SemiBold14(),
          ),
          12.verticalSpace,
          BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              final candidateOnboardingState = _candidateOnboardingCubit.state;
              return ChipSelector<Location?>(
                initiallySelectedOptions:
                    candidateOnboardingState.preferredLocations ?? [],
                isMultiSelect: true,
                options: state.filters?.locations ?? [],
                getText: (value) {
                  return value?.name ?? '-';
                },
                onSelectOption: (value) {
                  _candidateOnboardingCubit.onSelectCandidatePreferredLocations(
                    value,
                  );
                },
              );
            },
          ),
          24.verticalSpace,

          //----------Preferred-Employment-Type
          Text(
            "Preferred Employment Types",
            style: AppTextStyles.body3SemiBold14(),
          ),
          12.verticalSpace,
          BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              final candidateOnboardingState = _candidateOnboardingCubit.state;
              return ChipSelector<dynamic>(
                initiallySelectedOptions: candidateOnboardingState
                        .candidatePreferredEmploymentTypes ??
                    [],
                isMultiSelect: true,
                options: state.filters?.employmentType ?? [],
                getText: (value) {
                  return value ?? '-';
                },
                onSelectOption: (value) {
                  _candidateOnboardingCubit
                      .onSelectCandidatePreferredEmploymentType(
                    value,
                  );
                },
              );
            },
          ),
          40.verticalSpace,
        ],
      ),
    );
  }
}
