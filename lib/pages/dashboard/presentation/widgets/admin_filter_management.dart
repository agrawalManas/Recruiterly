import 'package:cades_flutter_template/common/constants.dart';
import 'package:cades_flutter_template/common/utils/utils.dart';
import 'package:cades_flutter_template/common/widgets/switch/custom_switch_with_label.dart';
import 'package:cades_flutter_template/pages/dashboard/domain/dashboard_cubit.dart';
import 'package:cades_flutter_template/pages/dashboard/presentation/widgets/update_filter_bottomsheet.dart';
import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminFilterManagement extends StatelessWidget {
  final DashboardCubit cubit;
  const AdminFilterManagement({required this.cubit, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            // childAspectRatio: 1.2,
          ),
          itemCount: adminFilterOptions.length,
          itemBuilder: (context, index) {
            final filter = adminFilterOptions[index];
            return GestureDetector(
              onTap: () {
                Utils.showBottomSheet(
                  context: context,
                  radius: 24.r,
                  isScrollControlled: false,
                  elevation: 3,
                  child: BlocProvider.value(
                    value: cubit,
                    child: UpdateFilterBottomsheet(
                      title: (filter['title'] ?? '').replaceFirst(
                        's',
                        '',
                        (filter['title'] ?? '').length - 1,
                      ),
                      description: filter['description'] ?? '',
                      isSalaryFilter: filter['title'] == 'Salary Range',
                      cubit: cubit,
                    ),
                  ),
                );
              },
              child: _buildFilterGrid(
                title: filter['title'] ?? '',
                description: filter['description'] ?? '',
                iconName: filter['icon'] ?? 'settings',
              ),
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Disable Remote Jobs filter?',
              style: AppTextStyles.body3Medium14(),
            ),
            CustomSwitchWithLabel(),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterGrid({
    required String title,
    required String description,
    required String iconName,
  }) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.adminAccent.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon at the top
          Container(
            padding: EdgeInsets.all(10.h),
            margin: EdgeInsets.only(bottom: 10.h),
            decoration: BoxDecoration(
              color: AppColors.adminAccent.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(_getIconData(iconName: iconName),
                color: AppColors.adminAccent, size: 20),
          ),

          // Title and description at the bottom
          Text(
            title,
            style: AppTextStyles.body3SemiBold14(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            description,
            style: AppTextStyles.body4Regular12(
              color: AppColors.textSecondary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  IconData _getIconData({
    required String iconName,
  }) {
    switch (iconName) {
      case 'work':
        return Icons.work;
      case 'trending_up':
        return Icons.trending_up;
      case 'location_on':
        return Icons.location_on;
      case 'attach_money':
        return Icons.attach_money;
      case 'psychology':
        return Icons.psychology;
      case 'business_center':
        return Icons.business_center;
      default:
        return Icons.settings;
    }
  }
}
