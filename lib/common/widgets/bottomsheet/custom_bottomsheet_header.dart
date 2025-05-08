import 'package:talent_mesh/common/navigation/app_routes.dart';
import 'package:talent_mesh/common/utils/extensions/context_extensions.dart';
import 'package:talent_mesh/common/utils/extensions/enum_extensions.dart';
import 'package:talent_mesh/styles/app_colors.dart';
import 'package:talent_mesh/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomsheetHeader extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final VoidCallback? onCancel;
  const CustomBottomsheetHeader({
    required this.title,
    this.titleColor,
    this.onCancel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.userRole.accentColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        border: Border(
          bottom: BorderSide(
            color: AppColors.surface.withValues(alpha: 0.4),
            width: 0.5,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w)
            .copyWith(top: 16.h, bottom: 8.h),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              onTap: onCancel ??
                  () {
                    AppRoutes.appRouter.pop();
                  },
              child: const Icon(
                Icons.clear,
                color: AppColors.surface,
              ),
            ),
            const Spacer(),
            Text(
              title,
              style: AppTextStyles.body2SemiBold16(
                color: titleColor ?? AppColors.surface,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
