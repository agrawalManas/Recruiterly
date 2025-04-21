import 'package:cades_flutter_template/common/image_loader.dart';
import 'package:cades_flutter_template/common/utils/extensions/context_extensions.dart';
import 'package:cades_flutter_template/common/utils/extensions/enum_extensions.dart';
import 'package:cades_flutter_template/common/utils/extensions/string_extensions.dart';
import 'package:cades_flutter_template/pages/dashboard/models/application_model.dart';
import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationOverviewCard extends StatelessWidget {
  final ApplicationModel? application;

  const ApplicationOverviewCard({
    super.key,
    required this.application,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: context.userRole.accentColor,
          width: 0.7,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              //-----LOGO
              Container(
                width: 40.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: ((application?.companyLogo ?? '').isNotEmpty)
                      ? ImageLoader.cachedNetworkImage(
                          application?.companyLogo ?? '')
                      : Text(
                          "C",
                          style: AppTextStyles.heading1ExtraBold24(
                            color: AppColors.primary,
                          ),
                        ),
                ),
              ),
              10.horizontalSpace,

              //-------TITLE-&-NAME
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      application?.jobRole ?? 'Job Role',
                      style: AppTextStyles.body2SemiBold16(),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      application?.companyName ?? 'Company',
                      style: AppTextStyles.body3Regular14(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //-------LOCATION
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  4.horizontalSpace,
                  Text(
                    (application?.isRemote ?? false)
                        ? "Remote"
                        : application?.location?.name ?? 'Location',
                    style: AppTextStyles.body4Regular12(),
                  ),
                ],
              ),

              //---------JOB-TYPE
              Row(
                children: [
                  const Icon(
                    Icons.work_outline,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  4.horizontalSpace,
                  Text(
                    (application?.employmentType ?? 'Full-Time')
                        .toCapitalized(),
                    style: AppTextStyles.body4Regular12(),
                  ),
                ],
              ),
            ],
          ),
          4.verticalSpace,

          //------------APPLICATION-STATUS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: application?.applicationStatus?.applicationStatus
                              .accentColor ??
                          AppColors.disabledButton.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                  ),
                  6.horizontalSpace,
                  Text(
                    application?.applicationStatus?.toCapitalized() ??
                        'Application Status',
                    style: AppTextStyles.body4Medium12(
                      color: application
                          ?.applicationStatus?.applicationStatus.accentColor,
                    ),
                  ),
                ],
              ),
              Text(
                'Applied ${application?.appliedAt?.toIso8601String().getDaysAgo()}',
                style: AppTextStyles.body4Regular12(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
