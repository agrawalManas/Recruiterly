import 'package:cades_flutter_template/common/utils/extensions/context_extensions.dart';
import 'package:cades_flutter_template/common/utils/extensions/enum_extensions.dart';
import 'package:cades_flutter_template/common/widgets/chip/chip_selector.dart';
import 'package:cades_flutter_template/common/widgets/textfield/custom_textfield_with_label.dart';
import 'package:cades_flutter_template/pages/onboarding/domain/onboarding_cubit.dart';
import 'package:cades_flutter_template/pages/onboarding/domain/onboarding_state.dart';
import 'package:cades_flutter_template/pages/onboarding/domain/recruiter/recruiter_onboarding_cubit.dart';
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
            "Tell us more about your company",
            style: AppTextStyles.body2SemiBold16(
              color: context.userRole.accentColor,
            ),
          ),
          24.verticalSpace,

          //----------Industry
          Text(
            "Industry(ies) that best describes you",
            style: AppTextStyles.body3SemiBold14(),
          ),
          12.verticalSpace,
          BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              final recruiterOnboardingState = _recruiterOnboardingCubit.state;
              return ChipSelector<String>(
                initiallySelectedOptions:
                    recruiterOnboardingState.industries ?? [],
                isMultiSelect: true,
                options: (state.filters?.industries ?? []).cast<String>(),
                getText: (value) {
                  return value;
                },
                onSelectOption: (value) {
                  _recruiterOnboardingCubit.onSelectIndustries(
                    value,
                  );
                },
              );
            },
          ),
          24.verticalSpace,

          //----------Company-size
          Text(
            "Company Size",
            style: AppTextStyles.body3SemiBold14(),
          ),
          12.verticalSpace,
          BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              final recruiterOnboardingState = _recruiterOnboardingCubit.state;
              return ChipSelector<dynamic>(
                initiallySelectedOptions: [
                  recruiterOnboardingState.companySize
                ],
                isMultiSelect: false,
                options: state.filters?.companySize ?? [],
                getText: (value) {
                  return '${value.toString()} employees';
                },
                onSelectOption: (value) {
                  _recruiterOnboardingCubit.onSelectCompanySize(
                    value.first,
                  );
                },
              );
            },
          ),
          24.verticalSpace,

          //----------Website(Optional)
          CustomTextfieldWithLabel(
            isRequired: false,
            labelText: 'Company Website (Optional)',
            hintText: 'eg. https://www.google.com',
            controller: _recruiterOnboardingCubit.companyWebsiteController,
            textInputType: TextInputType.url,
            textInputAction: TextInputAction.done,
          ),
          40.verticalSpace,
        ],
      ),
    );
  }
}
