import 'dart:developer';
import 'package:talent_mesh/common/app_enums.dart';
import 'package:talent_mesh/common/navigation/app_routes.dart';
import 'package:talent_mesh/common/utils/locator.dart';
import 'package:talent_mesh/common/utils/utils.dart';
import 'package:talent_mesh/pages/dashboard/models/job_model.dart';
import 'package:talent_mesh/pages/job_listing/model/job_filter_model.dart';
import 'package:talent_mesh/pages/job_posting/domain/job_posting_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobPostingCubit extends Cubit<JobPostingState> {
  JobPostingCubit() : super(const JobPostingState.init());

  dynamic _employmentType;
  Location? _location;
  ExperienceLevel? _experienceLevel;
  bool _isRemoteJob = false;
  bool _showSalaryInJobPosting = false;
  DateTime? _applicationDeadline;

  final _firestore = dependencyLocator<FirebaseFirestore>();
  final user = getUser();

  void resetState() {
    emit(const JobPostingState());
  }

  void onChangeEmployment(dynamic value) {
    _employmentType = value;
  }

  void onChangeRemoteLocation(bool value) {
    _isRemoteJob = value;
    _location = null;
  }

  void onChangeLocation(Location value) {
    _location = value;
    _isRemoteJob = false;
  }

  void onChangeExperienceLevel(ExperienceLevel value) {
    _experienceLevel = value;
  }

  void onChangeShowSalary(bool value) {
    _showSalaryInJobPosting = value;
  }

  void onChangeApplicationDeadline(value) {
    _applicationDeadline = value;
    emit(state.copyWith(applicationDeadlineDate: _applicationDeadline));
  }

  Future<void> postJob({
    required String companyName,
    required String jobRole,
    required String description,
    required String requirements,
    required String responsibilities,
    required String requiredSkills,
    required String minSalary,
    required String maxSalary,
    required String status,
  }) async {
    if (_validDateJobDetails(
      companyName: companyName,
      jobRole: jobRole,
      description: description,
      requirements: requirements,
      responsibilities: responsibilities,
      requiredSkills: requiredSkills,
      minSalary: minSalary,
      maxSalary: maxSalary,
      status: status,
    )) {
      if (status == JobStatus.active.name) {
        emit(state.copyWith(jobPostingApiStatus: ApiStatus.loading));
      } else if (status == JobStatus.active.name) {
        emit(state.copyWith(draftJobApiStatus: ApiStatus.loading));
      }
      final jobId = Utils.getUUID();

      try {
        final newJobData = JobModel(
          applicationDeadline: _applicationDeadline,
          companyLogo: '',
          jobId: jobId,
          applicationsCount: 0,
          companyName: companyName,
          description: description,
          employmentType: _employmentType,
          experienceLevel: _experienceLevel,
          isRemote: _isRemoteJob,
          jobRole: jobRole,
          location: _location,
          postedAt: DateTime.now(),
          recruiterId: user.uid,
          requirements: requirements,
          responsibilities: responsibilities,
          updatedAt: DateTime.now(),
          status: status,
          salaryRange: SalaryRange(
            min: num.parse(minSalary),
            max: num.parse(maxSalary),
            isVisible: _showSalaryInJobPosting,
            id: Utils.getUUID(),
          ),
          requiredSkills: requiredSkills.split(','),
        );
        await _firestore.collection('jobs').doc(jobId).set(newJobData.toMap());
        emit(state.copyWith(jobPostingApiStatus: ApiStatus.success));
        Utils.showToast(message: 'Job created successfully!');
        AppRoutes.appRouter.pop();
        Utils.showToast(
          message: 'Pull down to refresh, to sse the newly created jobs!',
        );
      } catch (error) {
        log('Error in job posting- ${error.toString()}');
        emit(state.copyWith(jobPostingApiStatus: ApiStatus.failure));
        Utils.showToast(message: 'Failed to create the job at the moment!');
      }
    } else {
      Utils.showToast(message: "Please enter valid details!");
    }
  }

  bool _validDateJobDetails({
    required String companyName,
    required String jobRole,
    required String description,
    required String requirements,
    required String responsibilities,
    required String requiredSkills,
    required String minSalary,
    required String maxSalary,
    required String status,
  }) {
    if (companyName.isNotEmpty &&
        jobRole.isNotEmpty &&
        description.isNotEmpty &&
        requirements.isNotEmpty &&
        responsibilities.isNotEmpty &&
        requiredSkills.isNotEmpty &&
        minSalary.isNotEmpty &&
        maxSalary.isNotEmpty &&
        status.isNotEmpty &&
        _employmentType != null &&
        _location != null &&
        _experienceLevel != null &&
        _applicationDeadline != null) {
      return true;
    }
    return false;
  }
}
