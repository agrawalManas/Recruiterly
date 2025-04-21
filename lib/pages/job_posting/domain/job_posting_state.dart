import 'package:cades_flutter_template/common/app_enums.dart';
import 'package:cades_flutter_template/pages/job_listing/model/job_filter_model.dart';
import 'package:equatable/equatable.dart';

class JobPostingState extends Equatable {
  final ApiStatus jobPostingApiStatus;
  final ApiStatus draftJobApiStatus;
  final DateTime? applicationDeadlineDate;
  final bool? isRemoteJob;
  final Location? location;

  const JobPostingState({
    this.jobPostingApiStatus = ApiStatus.init,
    this.draftJobApiStatus = ApiStatus.init,
    this.applicationDeadlineDate,
    this.isRemoteJob,
    this.location,
  });

  const JobPostingState.init()
      : this(
          jobPostingApiStatus: ApiStatus.init,
          draftJobApiStatus: ApiStatus.init,
          applicationDeadlineDate: null,
          isRemoteJob: null,
          location: null,
        );

  JobPostingState copyWith({
    ApiStatus? jobPostingApiStatus,
    ApiStatus? draftJobApiStatus,
    DateTime? applicationDeadlineDate,
    bool? isRemoteJob,
    Location? location,
  }) {
    return JobPostingState(
      jobPostingApiStatus: jobPostingApiStatus ?? this.jobPostingApiStatus,
      draftJobApiStatus: draftJobApiStatus ?? this.draftJobApiStatus,
      applicationDeadlineDate:
          applicationDeadlineDate ?? this.applicationDeadlineDate,
      isRemoteJob: isRemoteJob ?? this.isRemoteJob,
      location: location ?? this.location,
    );
  }

  @override
  List<Object?> get props => [
        jobPostingApiStatus,
        draftJobApiStatus,
        applicationDeadlineDate,
        isRemoteJob,
        location,
      ];
}
