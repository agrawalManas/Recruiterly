import 'package:talent_mesh/common/app_enums.dart';
import 'package:talent_mesh/common/utils/extensions/enum_extensions.dart';
import 'package:talent_mesh/common/utils/extensions/string_extensions.dart';
import 'package:talent_mesh/common/utils/locator.dart';
import 'package:talent_mesh/styles/app_colors.dart';
import 'package:talent_mesh/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardHeader extends StatelessWidget {
  final int? totalJobs;
  final int? activeJobs;
  const DashboardHeader({
    this.totalJobs,
    this.activeJobs,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userName = getUser().name ?? '--';
    final role = (getUser().role ?? 'none').userRole;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: role.accentColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Welcome, $userName",
            style: AppTextStyles.heading5SemiBold16(),
            textAlign: TextAlign.center,
          ),
          4.verticalSpace,
          if (role == Role.recruiter) ...[
            Text(
              'Talent Mesh',
              style: AppTextStyles.body2Regular16(),
              textAlign: TextAlign.center,
            ),
            12.verticalSpace,
            Row(
              children: [
                _buildStatCard("Total Jobs", totalJobs ?? 0),
                12.horizontalSpace,
                _buildStatCard("Active Jobs", activeJobs ?? 0),
              ],
            ),
          ] else if (role == Role.candidate) ...[
            Text(
              "Find your dream job today",
              style: AppTextStyles.body3Regular14(),
              textAlign: TextAlign.center,
            ),
          ] else if (role == Role.admin) ...[
            Text(
              'Manage existing job filters and platform settings',
              style: AppTextStyles.body3Regular14(),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, int value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.recruiterAccent),
        ),
        child: Column(
          children: [
            Text(
              value.toString(),
              style: AppTextStyles.heading1ExtraBold20(
                color: AppColors.primary,
              ),
            ),
            4.verticalSpace,
            Text(
              title,
              style: AppTextStyles.body3Regular14(),
            ),
          ],
        ),
      ),
    );
  }
}
