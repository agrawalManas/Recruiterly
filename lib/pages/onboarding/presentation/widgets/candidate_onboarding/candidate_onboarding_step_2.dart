import 'package:cades_flutter_template/common/widgets/textfield/custom_textfield_with_label.dart';
import 'package:cades_flutter_template/pages/onboarding/domain/onboarding_cubit.dart';
import 'package:cades_flutter_template/pages/onboarding/domain/onboarding_state.dart';
import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CandidateOnboardingStep2 extends StatefulWidget {
  const CandidateOnboardingStep2({
    super.key,
  });

  @override
  State<CandidateOnboardingStep2> createState() =>
      _CandidateOnboardingStep2State();
}

class _CandidateOnboardingStep2State extends State<CandidateOnboardingStep2> {
  final TextEditingController _summaryController = TextEditingController();

  @override
  void dispose() {
    _summaryController.dispose();
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
            "Tell us about your professional background",
            style: AppTextStyles.body2Regular16(),
          ),
          24.verticalSpace,

          // Summary
          CustomTextfieldWithLabel(
            isRequired: true,
            labelText: 'Professional Summary',
            controller: _summaryController,
            maxLines: 5,
            hintText:
                'Write a brief summary about your professional background, experience, and career goals.',
            // onChanged: (value) {
            //   widget.candidateOnboardingCubit.updateSummary(value);
            // },
          ),
          24.verticalSpace,

          // Experience Level
          Text(
            "Experience Level",
            style: AppTextStyles.body2SemiBold16(),
          ),
          // 12.verticalSpace,
          // BlocBuilder<OnboardingCubit, OnboardingState>(
          //   builder: (context, state) {
          //     return Wrap(
          //       spacing: 8.w,
          //       runSpacing: 8.h,
          //       children: ExperienceLevel.values.map((level) {
          //         return ChoiceChip(
          //           label: Text(level.name),
          //           selected: state.experienceLevel == level,
          //           onSelected: (selected) {
          //             if (selected) {
          //               widget.candidateOnboardingCubit
          //                   .updateExperienceLevel(level);
          //             }
          //           },
          //           backgroundColor: AppColors.surface,
          //           selectedColor: AppColors.primary.withOpacity(0.2),
          //           labelStyle: AppTextStyles.body3Medium14(
          //             color: state.experienceLevel == level
          //                 ? AppColors.primary
          //                 : AppColors.textPrimary,
          //           ),
          //         );
          //       }).toList(),
          //     );
          //   },
          // ),
          24.verticalSpace,

          // Preferred Roles
          Text(
            "Preferred Roles",
            style: AppTextStyles.body2SemiBold16(),
          ),
          12.verticalSpace,
          BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              final roles = [
                'Software Engineer',
                'Product Manager',
                'Designer',
                'Marketing Specialist',
                'Data Analyst',
                'Project Manager',
                'Sales Representative',
                'Customer Support'
              ];

              return Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: roles.map((role) {
                  return ChoiceChip(
                    label: Text(role),
                    selected: false,
                    onSelected: (selected) {
                      // widget.candidateOnboardingCubit.togglePreferredRole(role);
                    },
                    backgroundColor: AppColors.surface,
                    selectedColor: AppColors.primary.withOpacity(0.2),
                    labelStyle: AppTextStyles.body3Medium14(
                        // color: state.preferredRoles.contains(role)
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
