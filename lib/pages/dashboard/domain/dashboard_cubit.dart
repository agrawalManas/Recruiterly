import 'dart:developer';
import 'package:talent_mesh/common/app_enums.dart';
import 'package:talent_mesh/common/models/user_model.dart';
import 'package:talent_mesh/common/navigation/app_routes.dart';
import 'package:talent_mesh/common/navigation/routes.dart';
import 'package:talent_mesh/common/utils/extensions/string_extensions.dart';
import 'package:talent_mesh/common/utils/locator.dart';
import 'package:talent_mesh/common/utils/utils.dart';
import 'package:talent_mesh/pages/dashboard/domain/dashboard_state.dart';
import 'package:talent_mesh/pages/dashboard/models/application_model.dart';
import 'package:talent_mesh/pages/dashboard/models/job_model.dart';
import 'package:talent_mesh/pages/job_listing/model/job_filter_model.dart'
    as filter_model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState());

  final FirebaseFirestore _firestore = dependencyLocator<FirebaseFirestore>();
  final FirebaseAuth _auth = dependencyLocator<FirebaseAuth>();
  final _user = getUser();

  void resetState() {
    emit(const DashboardState());
  }

  Future<void> logoutUser() async {
    try {
      await _auth.signOut();
      dependencyLocator.unregister<UserModel>();
      dependencyLocator.registerSingleton<UserModel>(
        UserModel(
          role: 'none',
        ),
      );
      if (dependencyLocator.isRegistered<List<ApplicationModel>>()) {
        dependencyLocator.unregister<List<ApplicationModel>>();
      }
      AppRoutes.appRouter.pushReplacement(Routes.signin);
    } catch (error) {
      log('Error while signing out- ${error.toString()}');
      Utils.showToast(message: 'Unable to logout at the moment!');
    }
  }

  Future<void> getJobFilters() async {
    if (!dependencyLocator.isRegistered<filter_model.JobFilterModel>()) {
      emit(state.copyWith(jobFiltersApiStatus: ApiStatus.loading));
      try {
        final result = await _firestore.collection('jobFilters').get();
        Map<String, dynamic> jsonData =
            result.docs.firstOrNull?.data() as Map<String, dynamic>;
        final filters = filter_model.JobFilterModel.fromMap(jsonData);
        dependencyLocator.registerSingleton<filter_model.JobFilterModel>(
          filter_model.JobFilterModel.fromMap(jsonData),
        );
        emit(
          state.copyWith(
            jobFiltersApiStatus: ApiStatus.success,
            filters: filters,
          ),
        );
      } catch (error) {
        emit(state.copyWith(jobFiltersApiStatus: ApiStatus.failure));
        log('Error while fetching job filters- ${error.toString()}');
        // Utils.showToast(message: 'Something went wrong while getting filters');
      }
    }
  }

  /// get recruiter posted jobs to be shown on dashboard(recruiter)
  Future<void> getJobs() async {
    if (_user.role?.userRole == Role.recruiter) {
      emit(state.copyWith(getJobsApiStatus: ApiStatus.loading));
      final List<JobModel> jobs = [];
      int activeJobs = 0;
      try {
        QuerySnapshot<Map<String, dynamic>>? result;
        result = await _firestore
            .collection('jobs')
            .where(
              'recruiterId',
              isEqualTo: _user.uid,
            )
            .get();

        for (var job in result.docs) {
          if (job.exists) {
            Map<String, dynamic> jsonData = job.data();
            jobs.add(JobModel.fromMap(jsonData));
          }
        }
        activeJobs = jobs
            .where(
              (job) => job.status == JobStatus.active.name,
            )
            .length;
        emit(
          state.copyWith(
            getJobsApiStatus: ApiStatus.success,
            jobs: jobs,
            activeJobs: activeJobs,
          ),
        );
      } catch (error) {
        log('Error while fetching jobs- ${error.toString()}');
        Utils.showToast(
            message: "Could't get the jobs at the moment try again");
        emit(state.copyWith(getJobsApiStatus: ApiStatus.failure));
      }
    }
  }

  /// get candidate applied jobs to be shown on dashboard(candidate)
  Future<void> getAppliedJobs() async {
    if (_user.role?.userRole == Role.candidate) {
      emit(state.copyWith(getAppliedJobsApiStatus: ApiStatus.loading));
      final List<ApplicationModel> appliedJobs = [];
      try {
        QuerySnapshot<Map<String, dynamic>>? result;
        result = await _firestore
            .collection('jobApplications')
            .where(
              'candidateId',
              isEqualTo: _user.uid,
            )
            .get();

        for (var appliedJob in result.docs) {
          if (appliedJob.exists) {
            Map<String, dynamic> jsonData = appliedJob.data();
            appliedJobs.add(ApplicationModel.fromMap(jsonData));
          }
        }
        if (dependencyLocator.isRegistered<List<ApplicationModel>>()) {
          dependencyLocator.unregister<List<ApplicationModel>>();
        }
        dependencyLocator.registerSingleton<List<ApplicationModel>>(
          appliedJobs,
        );
        emit(
          state.copyWith(
            getAppliedJobsApiStatus: ApiStatus.success,
            appliedJobs: appliedJobs,
          ),
        );
      } catch (error) {
        log('Error while fetching applied jobs- ${error.toString()}');
        Utils.showToast(
            message: "Could't get the jobs at the moment try again");
        emit(state.copyWith(getAppliedJobsApiStatus: ApiStatus.failure));
      }
    }
  }

  ///change the job status, only for recruiters
  Future<void> changeJobStatus(String id, String status) async {
    if (_user.role?.userRole == Role.recruiter) {
      emit(state.copyWith(
        changeJobStatusApiStatus: ApiStatus.loading,
      ));
      try {
        await _firestore.collection('jobs').doc(id).update({
          'status': status,
        });
        emit(
          state.copyWith(
            changeJobStatusApiStatus: ApiStatus.success,
          ),
        );
        getJobs();
      } catch (error) {
        emit(state.copyWith(changeJobStatusApiStatus: ApiStatus.failure));
        log('Error while changing job status- ${error.toString()}');
        Utils.showToast(message: 'Unable to change the job status!');
      }
    }
  }

  /// update existing filters, only for admins
  Future<void> _updateFiltersInDB({
    required filter_model.JobFilterModel data,
  }) async {
    await _firestore
        .collection('jobFilters')
        .doc(getFilters().id)
        .update(data.toMap());
  }

  Future<void> updateFilters({
    required JobFilters filterType,
    String? text,
    bool? remote,
    num? max,
    num? min,
    num? yearsFrom,
    num? yearsTo,
  }) async {
    if (_user.role?.userRole == Role.admin) {
      try {
        emit(state.copyWith(addFilterApiStatus: ApiStatus.loading));
        filter_model.JobFilterModel existingFilters = getFilters();
        switch (filterType) {
          case JobFilters.locations:
            final locations = text!.split(',');
            existingFilters = existingFilters.copyWith(
              locations: [
                ...List.from(existingFilters.locations ?? []),
                ...List.generate(locations.length, (index) {
                  return filter_model.Location(
                    id: Utils.getUUID(),
                    country: 'India',
                    createdAt: DateTime.now(),
                    name: locations[index].trim(),
                  );
                }),
              ],
            );
          case JobFilters.jobRoles:
            existingFilters = existingFilters.copyWith(
              jobRoles: [
                ...List.from(existingFilters.jobRoles ?? []),
                filter_model.Filter(
                  id: Utils.getUUID(),
                  createdAt: DateTime.now(),
                  name: text,
                ),
              ],
            );
          case JobFilters.employmentType:
            existingFilters = existingFilters.copyWith(
              employmentType: [
                ...List.from(existingFilters.employmentType ?? []),
                text,
              ],
            );
          case JobFilters.remote:
            existingFilters = existingFilters.copyWith(
              remote: remote,
            );
          case JobFilters.skills:
            final skills = text!.split(',');
            existingFilters = existingFilters.copyWith(
              skills: [
                ...List.from(existingFilters.skills ?? []),
                ...List.generate(skills.length, (index) {
                  return filter_model.Skill(
                    id: Utils.getUUID(),
                    category: null,
                    createdAt: DateTime.now(),
                    name: skills[index].trim(),
                  );
                })
              ],
            );
          case JobFilters.experienceLevels:
            existingFilters = existingFilters.copyWith(
              experienceLevels: [
                ...List.from(existingFilters.experienceLevels ?? []),
                filter_model.ExperienceLevel(
                  id: Utils.getUUID(),
                  yearsFrom: yearsFrom,
                  yearsTo: yearsTo,
                  createdAt: DateTime.now(),
                  name: text,
                ),
              ],
            );
          case JobFilters.salaryRange:
            existingFilters = existingFilters.copyWith(
              salaryRange: [
                ...List.from(existingFilters.salaryRange ?? []),
                SalaryRange(
                  id: Utils.getUUID(),
                  isVisible: true,
                  max: max,
                  min: min,
                ),
              ],
            );
          case JobFilters.none:
            return;
        }
        final filterData = existingFilters.copyWith(
          lastUpdatedAt: DateTime.now(),
          lastUpdatedBy: _user.name,
        );
        await _updateFiltersInDB(data: filterData);
        dependencyLocator.unregister<filter_model.JobFilterModel>();
        dependencyLocator
            .registerSingleton<filter_model.JobFilterModel>(filterData);
        emit(state.copyWith(addFilterApiStatus: ApiStatus.success));
        Utils.showToast(
          message:
              'Successfully added another ${filterType.name.toCapitalized()}',
        );
        AppRoutes.appRouter.pop();
      } catch (error) {
        emit(state.copyWith(addFilterApiStatus: ApiStatus.failure));
        log('Error while adding filter- ${error.toString()}');
        Utils.showToast(message: 'Unable to add this filter!');
      }
    }
  }
}
