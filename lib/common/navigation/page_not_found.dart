import 'package:cades_flutter_template/common/widgets/appbar/custom_app_bar.dart';
import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: '',
        backgroundColor: AppColors.background,
        leadingColor: AppColors.textPrimary,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Oops...',
              style: AppTextStyles.body1SemiBold18(),
            ),
            16.verticalSpace,
            Text(
              "We couldn't find the page you are looking for!",
              textAlign: TextAlign.center,
              style: AppTextStyles.body2Regular16(),
            ),
          ],
        ),
      ),
    );
  }
}
