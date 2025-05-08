import 'package:talent_mesh/common/app_enums.dart';
import 'package:talent_mesh/common/navigation/app_routes.dart';
import 'package:talent_mesh/common/navigation/routes.dart';
import 'package:talent_mesh/common/utils/extensions/context_extensions.dart';
import 'package:talent_mesh/common/utils/extensions/enum_extensions.dart';
import 'package:talent_mesh/common/utils/extensions/string_extensions.dart';
import 'package:talent_mesh/common/utils/locator.dart';
import 'package:talent_mesh/common/widgets/appbar/custom_app_bar.dart';
import 'package:talent_mesh/common/widgets/button/custom_button.dart';
import 'package:talent_mesh/pages/dashboard/domain/dashboard_cubit.dart';
import 'package:talent_mesh/pages/dashboard/domain/dashboard_state.dart';
import 'package:talent_mesh/pages/dashboard/presentation/widgets/admin_filter_management.dart';
import 'package:talent_mesh/pages/dashboard/presentation/widgets/applied_jobs_section.dart';
import 'package:talent_mesh/pages/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:talent_mesh/pages/dashboard/presentation/widgets/dashboard_job_section.dart';
import 'package:talent_mesh/styles/app_colors.dart';
import 'package:talent_mesh/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late DashboardCubit _dashboardCubit;
  @override
  void initState() {
    super.initState();
    _dashboardCubit = context.read<DashboardCubit>();
    _initDashboard();
  }

  void _initDashboard() async {
    await Future.wait([
      _dashboardCubit.getJobFilters(),
      _dashboardCubit.getAppliedJobs(),
      _dashboardCubit.getJobs(),
    ]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _navBarButtonTxt() {
    switch (getUser().role?.userRole) {
      case Role.candidate:
        return 'Find Jobs';
      case Role.recruiter:
        return 'Add a Job';
      case Role.admin:
        return 'Admin';
      case Role.none:
        return 'none';
      default:
        return '--';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Dashboard',
        backEnabled: false,
        action: [
          GestureDetector(
            onTap: () {
              _dashboardCubit.logoutUser();
            },
            child: const Icon(
              Icons.logout,
              color: AppColors.surface,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        color: context.userRole.accentColor,
        onRefresh: () async {
          if (context.userRole == Role.recruiter) {
            await _dashboardCubit.getJobs();
          } else if (context.userRole == Role.candidate) {
            await _dashboardCubit.getAppliedJobs();
          }
        },
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            if (state.jobFiltersApiStatus == ApiStatus.loading ||
                state.getJobsApiStatus == ApiStatus.loading ||
                state.getAppliedJobsApiStatus == ApiStatus.loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: context.userRole.accentColor,
                ),
              );
            }
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.verticalSpace,

                    //---------Header
                    DashboardHeader(
                      totalJobs: state.jobs?.length,
                      activeJobs: state.activeJobs,
                    ),
                    24.verticalSpace,

                    //----------Applications section
                    if (context.userRole == Role.candidate) ...[
                      ApplicationJobsSection(
                        appliedJobs: state.appliedJobs ?? [],
                      ),
                      24.verticalSpace,
                    ],

                    //------------Jobs section
                    if (context.userRole == Role.recruiter)
                      BlocBuilder<DashboardCubit, DashboardState>(
                        builder: (context, state) {
                          return DashboardJobSection(
                            jobs: state.jobs ?? [],
                            dashboardCubit: _dashboardCubit,
                          );
                        },
                      ),

                    if (context.userRole == Role.admin)
                      AdminFilterManagement(
                        cubit: _dashboardCubit,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: (context.userRole == Role.candidate ||
              context.userRole == Role.recruiter)
          ? DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.background,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                    spreadRadius: 0,
                    color: context.userRole.accentColor,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: CustomButton(
                  width: double.infinity,
                  verticalPadding: 4.h,
                  horizontalPadding: 12.w,
                  wantBorder: false,
                  disableElevation: true,
                  buttonColor: context.userRole.accentColor,
                  onPressed: () {
                    if (context.userRole == Role.candidate) {
                      AppRoutes.appRouter.push(Routes.jobListing);
                    } else if (context.userRole == Role.recruiter) {
                      AppRoutes.appRouter.push(Routes.jobPost);
                    }
                  },
                  child: Text(
                    _navBarButtonTxt(),
                    style: AppTextStyles.body2Medium16(
                      color: AppColors.surface,
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
