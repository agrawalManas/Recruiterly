import 'package:cades_flutter_template/common/widgets/textfield/custom_textfield_with_label.dart';
import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CandidateOnboardingStep1 extends StatefulWidget {
  const CandidateOnboardingStep1({
    super.key,
  });

  @override
  State<CandidateOnboardingStep1> createState() =>
      _CandidateOnboardingStep1State();
}

class _CandidateOnboardingStep1State extends State<CandidateOnboardingStep1> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _headlineController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _headlineController.dispose();
    _phoneNumberController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
  //     firstDate: DateTime(1930),
  //     lastDate: DateTime.now(),
  //   );

  //   if (picked != null) {
  //     _dateOfBirthController.text = DateFormat('dd/MM/yyyy').format(picked);
  //     widget.candidateOnboardingCubit.updateDateOfBirth(picked);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Let's start with your basic information",
            style: AppTextStyles.body2Regular16(),
          ),
          32.verticalSpace,

          // First Name
          CustomTextfieldWithLabel(
            isRequired: true,
            labelText: 'Full Name',
            hintText: 'Enter your name here',
            controller: _firstNameController,
            textInputAction: TextInputAction.next,
            // onChanged: (value) {
            //   widget.candidateOnboardingCubit.updateFirstName(value);
            // },
          ),
          24.verticalSpace,

          // Headline
          CustomTextfieldWithLabel(
            isRequired: true,
            labelText: 'Current Designation',
            hintText: 'e.g. Senior Software Engineer',
            controller: _headlineController,
            textInputAction: TextInputAction.next,
            // onChanged: (value) {
            //   widget.candidateOnboardingCubit.updateHeadline(value);
            // },
          ),
          24.verticalSpace,

          // Phone Number
          CustomTextfieldWithLabel(
            isRequired: true,
            labelText: 'Phone Number',
            hintText: 'Enter your phone number here',
            controller: _phoneNumberController,
            textInputType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            // onChanged: (value) {
            //   widget.candidateOnboardingCubit.updatePhoneNumber(value);
            // },
          ),
          24.verticalSpace,

          // Date of Birth
          GestureDetector(
            onTap: () {},
            child: AbsorbPointer(
              child: CustomTextfieldWithLabel(
                isRequired: true,
                labelText: 'Date of Birth',
                hintText: 'DD/MM/YYYY',
                controller: _dateOfBirthController,
                textInputAction: TextInputAction.next,
                suffixIcon: const Icon(
                  Icons.calendar_today,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          40.verticalSpace,
        ],
      ),
    );
  }
}
