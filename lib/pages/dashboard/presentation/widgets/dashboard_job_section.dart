import 'package:cades_flutter_template/common/app_enums.dart';
import 'package:cades_flutter_template/common/utils/extensions/string_extensions.dart';
import 'package:cades_flutter_template/common/utils/locator.dart';
import 'package:cades_flutter_template/common/utils/utils.dart';
import 'package:cades_flutter_template/pages/dashboard/domain/dashboard_cubit.dart';
import 'package:cades_flutter_template/pages/dashboard/models/job_model.dart';
import 'package:cades_flutter_template/pages/dashboard/presentation/widgets/job_overview_card.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardJobSection extends StatelessWidget {
  final List<JobModel> jobs;
  final DashboardCubit dashboardCubit;
  const DashboardJobSection({
    required this.jobs,
    required this.dashboardCubit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (getUser().role ?? 'none').userRole == Role.recruiter
                  ? "Your recent job postings"
                  : "Recommended Jobs",
              style: AppTextStyles.body2SemiBold16(),
            ),
            // if (jobs.isNotEmpty)
            //   GestureDetector(
            //     onTap: () {},
            //     child: Text(
            //       "View All",
            //       style: AppTextStyles.body4Medium12(
            //         color: context.userRole.accentColor,
            //       ),
            //     ),
            //   ),
          ],
        ),
        16.verticalSpace,
        if (jobs.isNotEmpty)
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: jobs.length,
            separatorBuilder: (context, index) => 12.verticalSpace,
            itemBuilder: (context, index) {
              final jobId = jobs[index].jobId;
              return JobOverviewCard(
                job: jobs[index],
                onCloseJob: () {
                  dashboardCubit.changeJobStatus(
                    jobId ?? '',
                    JobStatus.closed.name,
                  );
                },
                onEditJob: () {
                  Utils.showToast(message: 'Coming soon!');
                },
                onReopenJob: () {
                  dashboardCubit.changeJobStatus(
                    jobId ?? '',
                    JobStatus.active.name,
                  );
                },
                onPublishJob: () {
                  dashboardCubit.changeJobStatus(
                    jobId ?? '',
                    JobStatus.active.name,
                  );
                },
              );
            },
          )
        else
          Center(
            child: Text(
              "You haven't posted a job lately!",
              style: AppTextStyles.body3Medium14(),
            ),
          ),
        32.verticalSpace,
      ],
    );
  }
}
