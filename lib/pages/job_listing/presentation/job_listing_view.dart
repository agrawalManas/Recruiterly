import 'package:talent_mesh/common/app_enums.dart';
import 'package:talent_mesh/common/utils/extensions/context_extensions.dart';
import 'package:talent_mesh/common/utils/extensions/enum_extensions.dart';
import 'package:talent_mesh/common/utils/locator.dart';
import 'package:talent_mesh/common/utils/utils.dart';
import 'package:talent_mesh/common/widgets/appbar/custom_app_bar.dart';
import 'package:talent_mesh/pages/dashboard/presentation/widgets/job_overview_card.dart';
import 'package:talent_mesh/pages/job_listing/domain/job_listing_cubit.dart';
import 'package:talent_mesh/pages/job_listing/domain/job_listing_state.dart';
import 'package:talent_mesh/pages/job_listing/presentation/widgets/filter_bottomsheet.dart';
import 'package:talent_mesh/styles/app_colors.dart';
import 'package:talent_mesh/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobListingView extends StatefulWidget {
  const JobListingView({super.key});

  @override
  State<JobListingView> createState() => _JobListingViewState();
}

class _JobListingViewState extends State<JobListingView> {
  late JobListingCubit _jobListingCubit;

  @override
  void initState() {
    super.initState();
    _jobListingCubit = context.read<JobListingCubit>();
    _jobListingCubit.getJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Jobs',
      ),
      body: BlocBuilder<JobListingCubit, JobListingState>(
        builder: (context, state) {
          if (state.getJobsListApiStatus == ApiStatus.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: context.userRole.accentColor,
              ),
            );
          } else if (state.getJobsListApiStatus == ApiStatus.success) {
            if ((state.jobs ?? []).isEmpty) {
              return Center(
                child: Text(
                  'No jobs found',
                  style: AppTextStyles.body3Medium14(),
                ),
              );
            }
          }
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            itemBuilder: (_, index) {
              final job = state.jobs?[index];
              return JobOverviewCard(
                job: job,
                onApplyJob: () async {
                  if (state.jobApplyApiStatus != ApiStatus.loading) {
                    await _jobListingCubit.applyForJob(
                      jobId: job?.jobId,
                      jobRole: job?.jobRole,
                      companyName: job?.companyName,
                      companyLogo: job?.companyLogo,
                      recruiterId: job?.recruiterId,
                      coverLetter: '',
                      resumeURL: '',
                      location: job?.location,
                      employmentType: job?.employmentType,
                      isRemote: job?.isRemote,
                      applicationsCount: job?.applicationsCount,
                    );
                  }
                },
              );
            },
            separatorBuilder: (_, index) {
              return 16.verticalSpace;
            },
            itemCount: state.jobs?.length ?? 0,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Utils.showBottomSheet(
            context: context,
            radius: 24.r,
            isScrollControlled: true,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: BlocProvider.value(
                value: context
                    .read<JobListingCubit>(), // Reuse the existing instance
                child: FilterBottomsheet(
                  filters: getFilters(),
                ),
              ),
            ),
          );
        },
        backgroundColor: AppColors.candidateAccent,
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}
