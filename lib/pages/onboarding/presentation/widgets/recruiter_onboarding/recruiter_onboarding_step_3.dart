import 'package:cades_flutter_template/common/widgets/textfield/custom_textfield_with_label.dart';
import 'package:cades_flutter_template/pages/onboarding/domain/recruiter/recruiter_onboarding_cubit.dart';
import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecruiterOnboardingStep3 extends StatefulWidget {
  const RecruiterOnboardingStep3({
    super.key,
  });

  @override
  State<RecruiterOnboardingStep3> createState() =>
      _RecruiterOnboardingStep3State();
}

class _RecruiterOnboardingStep3State extends State<RecruiterOnboardingStep3> {
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
            "Provide your contact details",
            style: AppTextStyles.body2Regular16(),
          ),
          24.verticalSpace,
          //----------Registered-Phone-Number
          CustomTextfieldWithLabel(
            isRequired: true,
            labelText: 'Contact Number',
            hintText: 'Type here...',
            controller:
                _recruiterOnboardingCubit.registeredPhoneNumberController,
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.next,
            prefixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '+91',
                  style: AppTextStyles.body3Medium14(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          24.verticalSpace,

          //--------Address
          Text(
            "Company Address",
            style: AppTextStyles.body3Medium14(),
          ),
          16.verticalSpace,

          //----Line 1
          CustomTextfieldWithLabel(
            isRequired: true,
            labelText: 'Address Line 1',
            controller: _recruiterOnboardingCubit.addressLine1Controller,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.streetAddress,
            hintText: 'Type here...',
          ),
          16.verticalSpace,

          //-----Line 2
          CustomTextfieldWithLabel(
            isRequired: false,
            labelText: 'Address Line 2',
            controller: _recruiterOnboardingCubit.addressLine2Controller,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.streetAddress,
            hintText: 'Type here...',
          ),
          16.verticalSpace,

          //-----City
          CustomTextfieldWithLabel(
            isRequired: true,
            labelText: 'City',
            controller: _recruiterOnboardingCubit.cityController,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.streetAddress,
            hintText: 'eg. Gurugram',
          ),
          16.verticalSpace,

          Row(
            children: [
              //------State
              Expanded(
                child: CustomTextfieldWithLabel(
                  isRequired: true,
                  labelText: 'State/Province',
                  controller: _recruiterOnboardingCubit.stateController,
                  textInputAction: TextInputAction.next,
                  hintText: 'eg. Haryana',
                ),
              ),
              16.horizontalSpace,

              //-------Postal Code
              Expanded(
                child: CustomTextfieldWithLabel(
                  isRequired: true,
                  labelText: 'Postal Code',
                  controller: _recruiterOnboardingCubit.pinCodeController,
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  hintText: 'eg. 122018',
                ),
              ),
            ],
          ),
          16.verticalSpace,

          //-------Country
          CustomTextfieldWithLabel(
            isRequired: true,
            labelText: 'Country',
            readOnly: true,
            controller: _recruiterOnboardingCubit.countryController,
            textInputAction: TextInputAction.done,
          ),
          40.verticalSpace,
        ],
      ),
    );
  }
}
