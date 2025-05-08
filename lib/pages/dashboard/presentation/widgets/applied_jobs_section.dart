import 'package:talent_mesh/pages/dashboard/models/application_model.dart';
import 'package:talent_mesh/pages/dashboard/presentation/widgets/application_overview_card.dart';
import 'package:talent_mesh/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationJobsSection extends StatelessWidget {
  final List<ApplicationModel> appliedJobs;
  const ApplicationJobsSection({required this.appliedJobs, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Your Applications",
              style: AppTextStyles.body2SemiBold16(),
            ),
            // GestureDetector(
            //   onTap: () {},
            //   child: Text(
            //     "View All",
            //     style: AppTextStyles.body4Medium12(
            //       color: context.userRole.accentColor,
            //     ),
            //   ),
            // ),
          ],
        ),
        16.verticalSpace,
        if (appliedJobs.isEmpty)
          Center(
            child: Text(
              "You haven't applied to any job yet",
              style: AppTextStyles.body3Regular14(),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: appliedJobs.length,
            separatorBuilder: (context, index) => 12.verticalSpace,
            itemBuilder: (context, index) {
              return ApplicationOverviewCard(
                application: appliedJobs[index],
              );
            },
          ),
      ],
    );
  }
}
