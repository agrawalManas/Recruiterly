import 'package:talent_mesh/common/utils/extensions/context_extensions.dart';
import 'package:talent_mesh/common/utils/extensions/enum_extensions.dart';
import 'package:talent_mesh/common/widgets/textfield/custom_textfield_with_label.dart';
import 'package:talent_mesh/pages/onboarding/domain/recruiter/recruiter_onboarding_cubit.dart';
import 'package:talent_mesh/styles/app_colors.dart';
import 'package:talent_mesh/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecruiterOnboardingStep1 extends StatefulWidget {
  const RecruiterOnboardingStep1({
    super.key,
  });

  @override
  State<RecruiterOnboardingStep1> createState() =>
      _RecruiterOnboardingStep1State();
}

class _RecruiterOnboardingStep1State extends State<RecruiterOnboardingStep1> {
  late RecruiterOnboardingCubit _recruiterOnboardingCubit;

  @override
  void initState() {
    super.initState();
    _recruiterOnboardingCubit = context.read<RecruiterOnboardingCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tell us about your company",
            style: AppTextStyles.body2SemiBold16(
              color: context.userRole.accentColor,
            ),
          ),
          24.verticalSpace,

          //------------Company Logo
          Center(
            child: Column(
              children: [
                GestureDetector(
                  child: Container(
                    width: 120.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: AppColors.disabledText.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: const Icon(
                      Icons.add_a_photo_outlined,
                      size: 40,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                8.verticalSpace,
                Text(
                  "Company Logo (Optional)",
                  style: AppTextStyles.body3Regular14(),
                ),
              ],
            ),
          ),
          24.verticalSpace,

          //----------Company Name
          CustomTextfieldWithLabel(
            isRequired: true,
            labelText: 'Company Name',
            controller: _recruiterOnboardingCubit.companyNameController,
            textInputAction: TextInputAction.next,
            hintText: 'Type here...',
          ),
          16.verticalSpace,

          //-----------Company Description
          CustomTextfieldWithLabel(
            isRequired: true,
            labelText: 'Company Description',
            controller: _recruiterOnboardingCubit.companyDescriptionController,
            maxLines: 5,
            hintText:
                'Give us a brief about your company, its mission, and values...',
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
          ),
          16.verticalSpace,

          //----------Founding Year
          CustomTextfieldWithLabel(
            isRequired: true,
            labelText: 'Year Founded',
            controller: _recruiterOnboardingCubit.companyFoundedYearController,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4),
            ],
            hintText: 'eg. 2014',
          ),
          16.verticalSpace,
          40.verticalSpace,
        ],
      ),
    );
  }
}
