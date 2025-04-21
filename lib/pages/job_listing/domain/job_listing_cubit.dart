import 'dart:developer';
import 'package:cades_flutter_template/common/app_enums.dart';
import 'package:cades_flutter_template/common/utils/extensions/string_extensions.dart';
import 'package:cades_flutter_template/common/utils/locator.dart';
import 'package:cades_flutter_template/common/utils/utils.dart';
import 'package:cades_flutter_template/pages/dashboard/models/application_model.dart';
import 'package:cades_flutter_template/pages/dashboard/models/job_model.dart';
import 'package:cades_flutter_template/pages/job_listing/domain/job_listing_state.dart';
import 'package:cades_flutter_template/pages/job_listing/model/job_filter_model.dart'
    as filters;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobListingCubit extends Cubit<JobListingState> {
  JobListingCubit() : super(JobListingState());

  final _user = getUser();
  final _firestore = dependencyLocator<FirebaseFirestore>();

  //-----filter related
  void setRoleFilter(filters.Filter? value) {
    emit(state.copyWith(role: value));
  }

  void setRemoteFilter(bool? value) {
    emit(state.copyWith(remote: value));
  }

  void setLocationFilter(filters.Location? value) {
    emit(state.copyWith(location: value));
  }

  void setSalaryRangeFilter(SalaryRange? value) {
    emit(state.copyWith(salaryRange: value));
  }

  void setEmploymentTypeFilter(String? value) {
    emit(state.copyWith(employmentType: value));
  }

  void setExperienceLevelFilter(filters.ExperienceLevel? value) {
    emit(state.copyWith(experienceLevel: value));
  }

  void setSkillFilter(String? value) {
    emit(state.copyWith(skills: value));
  }

  void clearFilters() {
    state.clearFilter();
    getJobs();
  }

  void resetState() {
    emit(JobListingState());
  }

  /// get all the active jobs for candidates
  Future<void> getJobs() async {
    if (_user.role?.userRole == Role.candidate) {
      final appliedJobs = getAppliedJobs();
      emit(state.copyWith(getJobsListApiStatus: ApiStatus.loading));
      List<JobModel> jobs = [];
      try {
        Query<Map<String, dynamic>> query = _firestore
            .collection('jobs')
            .where('status', isEqualTo: JobStatus.active.name);
        if ((state.role?.name ?? '').isNotEmpty) {
          query = query.where('jobRole', isEqualTo: state.role?.name);
        }

        if (state.employmentType != null) {
          query =
              query.where('employmentType', isEqualTo: state.employmentType);
        }

        if (state.remote == true) {
          query = query.where('isRemote', isEqualTo: state.remote);
        }

        if (state.experienceLevel != null) {
          query = query.where(
            'experienceLevel.id',
            isEqualTo: state.experienceLevel?.id,
          );
        }

        if (state.salaryRange != null) {
          query = query.where(
            'salaryRange.id',
            isEqualTo: state.salaryRange?.id,
          );
        }

        if (state.location != null) {
          query = query.where(
            'location.name',
            isEqualTo: state.location?.name,
          );
        }

        if (state.skills != null) {
          query = query.where('requiredSkills', arrayContains: state.skills);
        }

        QuerySnapshot<Map<String, dynamic>>? result;
        result = await query.get();

        for (var job in result.docs) {
          if (job.exists) {
            Map<String, dynamic> jsonData = job.data();
            jobs.add(JobModel.fromMap(jsonData));
          }
        }
        if (appliedJobs.isNotEmpty) {
          jobs = _removeAppliedJobs(allJobs: jobs, appliedJobs: appliedJobs);
        }
        emit(
          state.copyWith(
            getJobsListApiStatus: ApiStatus.success,
            jobs: jobs,
          ),
        );
      } catch (error) {
        log('Error while fetching jobs- ${error.toString()}');
        Utils.showToast(
          message: "Could't get the jobs at the moment try again",
        );
        emit(state.copyWith(getJobsListApiStatus: ApiStatus.failure));
      }
    }
  }

  /// remove applied jobs from all active job list
  List<JobModel> _removeAppliedJobs({
    required List<JobModel> allJobs,
    required List<ApplicationModel> appliedJobs,
  }) {
    // Extract all jobIds from applied jobs
    final Set<String?> appliedJobIds =
        appliedJobs.map((application) => application.jobId).toSet();

    // Filter out jobs whose jobId is in the appliedJobIds set
    return allJobs.where((job) => !appliedJobIds.contains(job.jobId)).toList();
  }

  /// only for candidates
  Future<void> applyForJob({
    required String? jobId,
    required String? jobRole,
    required String? companyName,
    required String? companyLogo,
    required String? recruiterId,
    required String? coverLetter,
    required String? resumeURL,
    required filters.Location? location,
    required String? employmentType,
    required bool? isRemote,
    required int? applicationsCount,
  }) async {
    if (_user.role?.userRole == Role.candidate) {
      emit(state.copyWith(
        jobApplyApiStatus: ApiStatus.loading,
        applyingJobId: jobId,
      ));

      final applicationId = Utils.getUUID();
      try {
        final newApplicationData = ApplicationModel(
          candidateId: _user.uid,
          companyLogo: companyLogo,
          jobId: jobId,
          companyName: companyName,
          employmentType: employmentType,
          isRemote: isRemote,
          jobRole: jobRole,
          location: location,
          resumeURL: resumeURL,
          coverLetter: coverLetter,
          appliedAt: DateTime.now(),
          recruiterId: _user.uid,
          applicationStatus: ApplicationStatus.applied.name,
          notes: null,
          candidateRating: null,
          lastUpdatedAt: DateTime.now(),
          lastUpdatedBy: null,
          applicationId: applicationId,
          applicationsCount: applicationsCount,
        );
        await _firestore
            .collection('jobApplications')
            .doc(applicationId)
            .set(newApplicationData.toMap());
        List<JobModel> updatedJobs = List<JobModel>.from(state.jobs ?? []);
        updatedJobs.removeWhere((job) => job.jobId == jobId);
        _updateApplicationCount(
            jobId: jobId, applicationsCount: applicationsCount);
        emit(
          state.copyWith(
            jobApplyApiStatus: ApiStatus.success,
            jobs: updatedJobs,
          ),
        );
        Utils.showToast(message: 'Applied successfully!');
      } catch (error) {
        log('Error in job apply- ${error.toString()}');
        emit(state.copyWith(jobApplyApiStatus: ApiStatus.failure));
        Utils.showToast(message: 'Failed to apply for the job at the moment!');
      }
    }
  }

  Future<void> _updateApplicationCount({
    required String? jobId,
    required int? applicationsCount,
  }) async {
    if (jobId != null && applicationsCount != null) {
      try {
        await _firestore.collection('jobs').doc(jobId).update(
          {
            'applicationsCount': applicationsCount + 1,
          },
        );
      } catch (error) {
        log('Error while updating applications count- ${error.toString()}');
      }
    }
  }
}
