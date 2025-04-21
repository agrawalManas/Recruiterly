import 'package:cades_flutter_template/common/widgets/textfield/custom_textfield_with_label.dart';
import 'package:cades_flutter_template/pages/onboarding/domain/onboarding_cubit.dart';
import 'package:cades_flutter_template/pages/onboarding/domain/onboarding_state.dart';
import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecruiterOnboardingStep2 extends StatefulWidget {
  const RecruiterOnboardingStep2({
    super.key,
  });

  @override
  State<RecruiterOnboardingStep2> createState() => _CompanyDetailsPageState();
}

class _CompanyDetailsPageState extends State<RecruiterOnboardingStep2> {
  final TextEditingController _websiteController = TextEditingController();

  final List<String> _industries = [
    'Technology',
    'Healthcare',
    'Finance',
    'Education',
    'Manufacturing',
    'Retail',
    'Entertainment',
    'Transportation',
    'Construction',
    'Hospitality',
    'Real Estate',
    'Agriculture',
    'Energy',
    'Media',
    'Telecommunications',
  ];

  @override
  void dispose() {
    _websiteController.dispose();
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
            "Tell us more about your company",
            style: AppTextStyles.body2Regular16(),
          ),
          24.verticalSpace,

          // Industry
          Text(
            "Industry",
            style: AppTextStyles.body2SemiBold16(),
          ),
          12.verticalSpace,
          BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              return Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: _industries.map((industry) {
                  return ChoiceChip(
                    label: Text(industry),
                    selected: false,
                    onSelected: (selected) {
                      // if (selected) {
                      //   widget.recruiterOnboardingCubit
                      //       .updateIndustry(industry);
                      // }
                    },
                    backgroundColor: AppColors.surface,
                    selectedColor: AppColors.primary.withOpacity(0.2),
                    labelStyle: AppTextStyles.body3Medium14(
                        // color: state.industry == industry
                        //     ? AppColors.primary
                        //     : AppColors.textPrimary,
                        ),
                  );
                }).toList(),
              );
            },
          ),
          24.verticalSpace,

          // Website (Optional)
          CustomTextfieldWithLabel(
            isRequired: false,
            labelText: 'Company Website (Optional)',
            hintText: 'https://www.example.com',
            controller: _websiteController,
            textInputType: TextInputType.url,
            textInputAction: TextInputAction.done,
            // onChanged: (value) {
            //   widget.recruiterOnboardingCubit.updateWebsite(value);
            // },
          ),
          40.verticalSpace,
        ],
      ),
    );
  }
}
