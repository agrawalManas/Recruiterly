import 'package:talent_mesh/common/app_enums.dart';
import 'package:talent_mesh/pages/dashboard/models/application_model.dart';
import 'package:talent_mesh/pages/dashboard/models/job_model.dart';
import 'package:talent_mesh/pages/job_listing/model/job_filter_model.dart';
import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  final ApiStatus jobFiltersApiStatus;
  final ApiStatus getJobsApiStatus;
  final ApiStatus getAppliedJobsApiStatus;
  final ApiStatus changeJobStatusApiStatus;
  final ApiStatus addFilterApiStatus;
  final JobFilterModel? filters;
  final List<JobModel>? jobs;
  final List<ApplicationModel>? appliedJobs;
  final int? activeJobs;

  const DashboardState({
    this.jobFiltersApiStatus = ApiStatus.init,
    this.getJobsApiStatus = ApiStatus.init,
    this.getAppliedJobsApiStatus = ApiStatus.init,
    this.changeJobStatusApiStatus = ApiStatus.init,
    this.addFilterApiStatus = ApiStatus.init,
    this.filters,
    this.jobs,
    this.appliedJobs,
    this.activeJobs,
  });

  const DashboardState.init()
      : this(
          jobFiltersApiStatus: ApiStatus.init,
          getJobsApiStatus: ApiStatus.init,
          changeJobStatusApiStatus: ApiStatus.init,
          getAppliedJobsApiStatus: ApiStatus.init,
          addFilterApiStatus: ApiStatus.init,
          filters: null,
          jobs: null,
          activeJobs: null,
          appliedJobs: null,
        );

  DashboardState copyWith({
    ApiStatus? jobFiltersApiStatus,
    ApiStatus? getJobsApiStatus,
    ApiStatus? changeJobStatusApiStatus,
    ApiStatus? applyJobApiStatus,
    ApiStatus? getAppliedJobsApiStatus,
    ApiStatus? addFilterApiStatus,
    JobFilterModel? filters,
    List<JobModel>? jobs,
    int? activeJobs,
    List<ApplicationModel>? appliedJobs,
  }) {
    return DashboardState(
      jobFiltersApiStatus: jobFiltersApiStatus ?? this.jobFiltersApiStatus,
      getJobsApiStatus: getJobsApiStatus ?? this.getJobsApiStatus,
      addFilterApiStatus: addFilterApiStatus ?? this.addFilterApiStatus,
      getAppliedJobsApiStatus:
          getAppliedJobsApiStatus ?? this.getAppliedJobsApiStatus,
      changeJobStatusApiStatus:
          changeJobStatusApiStatus ?? this.changeJobStatusApiStatus,
      filters: filters ?? this.filters,
      jobs: jobs ?? this.jobs,
      appliedJobs: appliedJobs ?? this.appliedJobs,
      activeJobs: activeJobs ?? this.activeJobs,
    );
  }

  @override
  List<Object?> get props => [
        jobFiltersApiStatus,
        changeJobStatusApiStatus,
        getAppliedJobsApiStatus,
        addFilterApiStatus,
        filters,
        jobs,
        getJobsApiStatus,
        activeJobs,
        appliedJobs,
      ];
}
