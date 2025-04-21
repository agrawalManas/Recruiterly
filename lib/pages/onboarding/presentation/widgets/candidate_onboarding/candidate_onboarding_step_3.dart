// Page 3: Skills & Preferences
import 'package:cades_flutter_template/common/widgets/textfield/custom_textfield_with_label.dart';
import 'package:cades_flutter_template/pages/onboarding/domain/onboarding_cubit.dart';
import 'package:cades_flutter_template/pages/onboarding/domain/onboarding_state.dart';
import 'package:cades_flutter_template/styles/app_colors.dart';
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
  final TextEditingController _minSalaryController = TextEditingController();
  final TextEditingController _maxSalaryController = TextEditingController();

  @override
  void dispose() {
    _minSalaryController.dispose();
    _maxSalaryController.dispose();
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
            style: AppTextStyles.body2Regular16(),
          ),
          24.verticalSpace,

          // Skills
          Text(
            "Skills (Select your top skills)",
            style: AppTextStyles.body2SemiBold16(),
          ),
          12.verticalSpace,
          BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              final skills = [
                'Flutter',
                'React',
                'JavaScript',
                'Python',
                'Java',
                'UI/UX',
                'Product Management',
                'Data Analysis',
                'Marketing',
                'Sales',
                'HTML/CSS',
                'SQL',
                'Communication',
                'Leadership'
              ];

              return Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: skills.map((skill) {
                  return ChoiceChip(
                    label: Text(skill),
                    selected: false,
                    onSelected: (selected) {
                      // widget.candidateOnboardingCubit.toggleSkill(skill);
                    },
                    backgroundColor: AppColors.surface,
                    selectedColor: AppColors.primary.withOpacity(0.2),
                    labelStyle: AppTextStyles.body3Medium14(
                        // color: state.skills.contains(skill)
                        // ? AppColors.primary
                        // : AppColors.textPrimary,
                        ),
                  );
                }).toList(),
              );
            },
          ),
          24.verticalSpace,

          // Expected Salary
          Text(
            "Expected Salary Range (USD)",
            style: AppTextStyles.body2SemiBold16(),
          ),
          12.verticalSpace,
          Row(
            children: [
              Expanded(
                child: CustomTextfieldWithLabel(
                  isRequired: true,
                  labelText: 'Minimum',
                  controller: _minSalaryController,
                  textInputType: TextInputType.number,
                  // prefixText: '\$ ',
                  // onChanged: (value) {
                  //   widget.candidateOnboardingCubit
                  //       .updateMinSalary(int.tryParse(value) ?? 0);
                  // },
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: CustomTextfieldWithLabel(
                  isRequired: true,
                  labelText: 'Maximum',
                  controller: _maxSalaryController,
                  textInputType: TextInputType.number,
                  // prefixText: '\$ ',
                  // onChanged: (value) {
                  //   widget.candidateOnboardingCubit
                  //       .updateMaxSalary(int.tryParse(value) ?? 0);
                  // },
                ),
              ),
            ],
          ),
          24.verticalSpace,

          // Preferred Locations
          Text(
            "Preferred Locations",
            style: AppTextStyles.body2SemiBold16(),
          ),
          12.verticalSpace,
          BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              final locations = [
                'Remote',
                'New York',
                'San Francisco',
                'London',
                'Berlin',
                'Toronto',
                'Sydney',
                'Singapore',
                'Tokyo',
                'Dubai'
              ];

              return Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: locations.map((location) {
                  return ChoiceChip(
                    label: Text(location),
                    selected: false,
                    onSelected: (selected) {
                      // widget.candidateOnboardingCubit.togglePreferredLocation(location);
                    },
                    backgroundColor: AppColors.surface,
                    selectedColor: AppColors.primary.withOpacity(0.2),
                    labelStyle: AppTextStyles.body3Medium14(
                        // color: state.preferredLocations.contains(location)
                        //     ? AppColors.primary
                        //     : AppColors.textPrimary,
                        ),
                  );
                }).toList(),
              );
            },
          ),
          40.verticalSpace,
        ],
      ),
    );
  }
}
