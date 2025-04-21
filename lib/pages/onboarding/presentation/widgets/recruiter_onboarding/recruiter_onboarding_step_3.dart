import 'package:cades_flutter_template/common/widgets/textfield/custom_textfield_with_label.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
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
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _postalCodeController.dispose();
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
            "Enter contact details",
            style: AppTextStyles.body2Regular16(),
          ),
          24.verticalSpace,

          // Phone Number
          CustomTextfieldWithLabel(
            isRequired: true,
            labelText: 'Contact Phone',
            controller: _phoneController,
            textInputType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            // onChanged: (value) {
            //   widget.recruiterOnboardingCubit.updateContactPhone(value);
            // },
          ),
          24.verticalSpace,

          // Address
          Text(
            "Company Address",
            // style: AppTextStyles.body2SemiBold16(),
          ),
          16.verticalSpace,

          // Street
          CustomTextfieldWithLabel(
            isRequired: true,
            labelText: 'Street',
            controller: _streetController,
            textInputAction: TextInputAction.next,
            // onChanged: (value) {
            //   widget.recruiterOnboardingCubit.updateStreet(value);
            // },
          ),
          16.verticalSpace,

          // City
          CustomTextfieldWithLabel(
            isRequired: true,
            labelText: 'City',
            controller: _cityController,
            textInputAction: TextInputAction.next,
            // onChanged: (value) {
            //   widget.recruiterOnboardingCubit.updateCity(value);
            // },
          ),
          16.verticalSpace,

          // Row for State and Postal Code
          Row(
            children: [
              // State
              Expanded(
                child: CustomTextfieldWithLabel(
                  isRequired: true,
                  labelText: 'State/Province',
                  controller: _stateController,
                  textInputAction: TextInputAction.next,
                  // onChanged: (value) {
                  //   widget.recruiterOnboardingCubit.updateState(value);
                  // },
                ),
              ),
              16.horizontalSpace,
              // Postal Code
              Expanded(
                child: CustomTextfieldWithLabel(
                  isRequired: true,
                  labelText: 'Postal Code',
                  controller: _postalCodeController,
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  // onChanged: (value) {
                  //   widget.recruiterOnboardingCubit.updatePostalCode(value);
                  // },
                ),
              ),
            ],
          ),
          16.verticalSpace,

          // Country
          CustomTextfieldWithLabel(
            isRequired: true,
            labelText: 'Country',
            controller: _countryController,
            textInputAction: TextInputAction.done,
            // onChanged: (value) {
            //   widget.recruiterOnboardingCubit.updateCountry(value);
            // },
          ),
          40.verticalSpace,
        ],
      ),
    );
  }
}
