import 'package:cades_flutter_template/common/app_enums.dart';
import 'package:cades_flutter_template/common/image_loader.dart';
import 'package:cades_flutter_template/common/utils/extensions/context_extensions.dart';
import 'package:cades_flutter_template/common/utils/extensions/enum_extensions.dart';
import 'package:cades_flutter_template/common/utils/extensions/string_extensions.dart';
import 'package:cades_flutter_template/common/widgets/button/custom_button.dart';
import 'package:cades_flutter_template/pages/dashboard/models/job_model.dart';
import 'package:cades_flutter_template/pages/job_listing/domain/job_listing_cubit.dart';
import 'package:cades_flutter_template/pages/job_listing/domain/job_listing_state.dart';
import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobOverviewCard extends StatelessWidget {
  final JobModel? job;
  final VoidCallback? onCloseJob;
  final VoidCallback? onEditJob;
  final VoidCallback? onPublishJob;
  final VoidCallback? onReopenJob;
  final VoidCallback? onApplyJob;
  const JobOverviewCard({
    required this.job,
    this.onCloseJob,
    this.onEditJob,
    this.onPublishJob,
    this.onReopenJob,
    this.onApplyJob,
    super.key,
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
                  child: ((job?.companyLogo ?? '').isNotEmpty)
                      ? ImageLoader.cachedNetworkImage(job?.companyLogo ?? '')
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
                      job?.jobRole ?? 'Job title',
                      style: AppTextStyles.body2SemiBold16(),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      job?.companyName ?? 'Company',
                      style: AppTextStyles.body3Regular14(),
                    ),
                  ],
                ),
              ),

              //-------STATUS
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: job?.status?.jobStatus.accentColor.withOpacity(0.1) ??
                      AppColors.disabledButton.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  job?.status?.toUpperCase() ?? 'Status',
                  style: AppTextStyles.body5Medium10(
                    color: job?.status?.jobStatus.accentColor,
                  ),
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
                    (job?.isRemote ?? false)
                        ? "Remote"
                        : job?.location?.name ?? 'Location',
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
                    (job?.employmentType ?? 'Full-Time').toCapitalized(),
                    style: AppTextStyles.body4Regular12(),
                  ),
                ],
              ),
            ],
          ),
          4.verticalSpace,

          //------------SKILLS
          Row(
            children: [
              const Icon(
                Icons.psychology_alt,
                size: 16,
                color: AppColors.textSecondary,
              ),
              4.horizontalSpace,
              Text(
                (job?.requiredSkills ?? []).join(','),
                style: AppTextStyles.body4Regular12(),
              ),
            ],
          ),
          4.verticalSpace,

          //------------SALARY-OFFERED
          if (job?.salaryRange?.isVisible ?? true) ...[
            Row(
              children: [
                Text(
                  'CTC Range: ',
                  style: AppTextStyles.body4Regular12(),
                ),
                4.horizontalSpace,
                Text(
                  '${(job?.salaryRange?.min ?? 0).toString().toCommaSeparatedFormat()} to ${(job?.salaryRange?.max ?? 0).toString().toCommaSeparatedFormat()}',
                  style: AppTextStyles.body4Regular12(),
                ),
              ],
            ),
            4.verticalSpace,
          ],

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //-------POSTED-ON
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  4.horizontalSpace,
                  Text(
                    "Posted ${job?.postedAt?.toIso8601String().getDaysAgo()}",
                    style: AppTextStyles.body4Regular12(),
                  ),
                ],
              ),

              //--------APPLICATION-COUNT
              Row(
                children: [
                  const Icon(
                    Icons.people_outline,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  4.horizontalSpace,
                  Text(
                    "${job?.applicationsCount ?? 0} applicants",
                    style: AppTextStyles.body4Regular12(),
                  ),
                ],
              ),
            ],
          ),
          if (context.userRole == Role.candidate &&
              job?.status != JobStatus.closed.name) ...[
            26.verticalSpace,
            BlocBuilder<JobListingCubit, JobListingState>(
              builder: (context, state) {
                return CustomButton(
                  width: double.infinity,
                  verticalPadding: 8.h,
                  wantBorder: true,
                  borderColor: context.userRole.accentColor,
                  buttonColor: AppColors.surface,
                  isLoading: state.jobApplyApiStatus == ApiStatus.loading &&
                      state.applyingJobId == job?.jobId,
                  disableElevation: true,
                  onPressed: onApplyJob,
                  child: Text(
                    'Apply for this Job',
                    style: AppTextStyles.body3Medium14(
                      color: context.userRole.accentColor,
                    ),
                  ),
                );
              },
            ),
          ] else if (context.userRole == Role.recruiter) ...[
            if (job?.status == JobStatus.closed.name ||
                job?.status == JobStatus.filled.name) ...[
              12.verticalSpace,
              CustomButton(
                width: double.infinity,
                verticalPadding: 8.h,
                wantBorder: true,
                borderColor: context.userRole.accentColor,
                buttonColor: AppColors.surface,
                disableElevation: true,
                onPressed: onReopenJob,
                child: Text(
                  'Reopen this Job',
                  style: AppTextStyles.body3Medium14(
                    color: context.userRole.accentColor,
                  ),
                ),
              ),
            ],
            if (job?.status == JobStatus.draft.name) ...[
              12.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      verticalPadding: 8.h,
                      wantBorder: true,
                      borderColor: context.userRole.accentColor,
                      buttonColor: AppColors.surface,
                      disableElevation: true,
                      onPressed: onEditJob,
                      child: Text(
                        'Edit',
                        style: AppTextStyles.body3Medium14(
                          color: context.userRole.accentColor,
                        ),
                      ),
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: CustomButton(
                      verticalPadding: 8.h,
                      wantBorder: false,
                      disableElevation: true,
                      onPressed: onPublishJob,
                      child: Text(
                        'Publish',
                        style: AppTextStyles.body3Medium14(
                          color: AppColors.surface,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            if (job?.status == JobStatus.active.name) ...[
              12.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      verticalPadding: 8.h,
                      wantBorder: true,
                      borderColor: context.userRole.accentColor,
                      disableElevation: true,
                      buttonColor: AppColors.surface,
                      onPressed: onCloseJob,
                      child: Text(
                        'Close Job',
                        style: AppTextStyles.body3Medium14(
                          color: context.userRole.accentColor,
                        ),
                      ),
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: CustomButton(
                      verticalPadding: 8.h,
                      wantBorder: false,
                      disableElevation: true,
                      onPressed: () {
                        // AppRoutes.appRouter.push('/view-applicants/$jobId');
                      },
                      child: Text(
                        'View Applicants',
                        style: AppTextStyles.body3Medium14(
                          color: AppColors.surface,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ]
        ],
      ),
    );
  }
}
