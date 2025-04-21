import 'package:cades_flutter_template/common/widgets/textfield/custom_textfield_with_label.dart';
import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
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
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyDescriptionController =
      TextEditingController();
  // final ImagePicker _picker = ImagePicker();
  // File? _logoImage;

  @override
  void dispose() {
    _companyNameController.dispose();
    _companyDescriptionController.dispose();
    super.dispose();
  }

  // Future<void> _pickImage() async {
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     setState(() {
  //       _logoImage = File(image.path);
  //     });
  //     widget.recruiterOnboardingCubit.updateLogoPath(image.path);
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
            "Tell us about your company",
            style: AppTextStyles.body2Regular16(),
          ),
          24.verticalSpace,

          // Company Logo
          Center(
            child: Column(
              children: [
                GestureDetector(
                  // onTap: _pickImage,
                  child: Container(
                    width: 120.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: AppColors.disabledText.withOpacity(0.2),
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

          // Company Name
          CustomTextfieldWithLabel(
            isRequired: true,
            labelText: 'Company Name',
            controller: _companyNameController,
            textInputAction: TextInputAction.next,
            // onChanged: (value) {
            //   widget.recruiterOnboardingCubit.updateCompanyName(value);
            // },
          ),
          16.verticalSpace,

          // Company Description
          CustomTextfieldWithLabel(
            isRequired: true,
            labelText: 'Company Description',
            controller: _companyDescriptionController,
            maxLines: 5,
            hintText: 'Tell us about your company, its mission, and values.',
            // onChanged: (value) {
            //   widget.recruiterOnboardingCubit.updateCompanyDescription(value);
            // },
          ),
          40.verticalSpace,
        ],
      ),
    );
  }
}
