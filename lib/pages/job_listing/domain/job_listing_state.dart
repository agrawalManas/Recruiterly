import 'package:talent_mesh/common/app_enums.dart';
import 'package:talent_mesh/pages/dashboard/models/job_model.dart';
import 'package:talent_mesh/pages/job_listing/model/job_filter_model.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class JobListingState extends Equatable {
  final ApiStatus jobApplyApiStatus;
  final ApiStatus getJobsListApiStatus;
  final String? applyingJobId;
  final List<JobModel>? jobs;
  Filter? role;
  Location? location;
  ExperienceLevel? experienceLevel;
  SalaryRange? salaryRange;
  bool? remote;
  String? employmentType;
  String? skills;

  JobListingState({
    this.jobApplyApiStatus = ApiStatus.init,
    this.getJobsListApiStatus = ApiStatus.init,
    this.applyingJobId,
    this.jobs,
    this.employmentType,
    this.experienceLevel,
    this.location,
    this.remote,
    this.role,
    this.salaryRange,
    this.skills,
  });

  JobListingState copyWith({
    ApiStatus? jobApplyApiStatus,
    ApiStatus? getJobsListApiStatus,
    String? applyingJobId,
    List<String>? appliedJobIds,
    List<JobModel>? jobs,
    Filter? role,
    Location? location,
    ExperienceLevel? experienceLevel,
    SalaryRange? salaryRange,
    bool? remote,
    String? employmentType,
    String? skills,
  }) {
    return JobListingState(
      jobApplyApiStatus: jobApplyApiStatus ?? this.jobApplyApiStatus,
      getJobsListApiStatus: getJobsListApiStatus ?? this.getJobsListApiStatus,
      applyingJobId: applyingJobId ?? applyingJobId,
      jobs: jobs ?? this.jobs,
      role: role ?? this.role,
      location: location ?? this.location,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      salaryRange: salaryRange ?? this.salaryRange,
      remote: remote ?? this.remote,
      employmentType: employmentType ?? this.employmentType,
      skills: skills ?? this.skills,
    );
  }

  void clearFilter() {
    role = null;
    employmentType = null;
    location = null;
    salaryRange = null;
    experienceLevel = null;
    skills = null;
    remote = null;
  }

  @override
  List<Object?> get props => [
        jobApplyApiStatus,
        getJobsListApiStatus,
        applyingJobId,
        jobs,
        role,
        location,
        experienceLevel,
        salaryRange,
        remote,
        remote,
        employmentType,
        skills,
      ];
}
