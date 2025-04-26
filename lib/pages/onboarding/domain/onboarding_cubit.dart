import 'dart:developer';
import 'package:cades_flutter_template/common/app_enums.dart';
import 'package:cades_flutter_template/common/navigation/app_routes.dart';
import 'package:cades_flutter_template/common/navigation/routes.dart';
import 'package:cades_flutter_template/common/utils/extensions/string_extensions.dart';
import 'package:cades_flutter_template/common/utils/locator.dart';
import 'package:cades_flutter_template/common/utils/utils.dart';
import 'package:cades_flutter_template/pages/job_listing/model/job_filter_model.dart';
import 'package:cades_flutter_template/pages/onboarding/domain/candidate/candidate_onboarding_cubit.dart';
import 'package:cades_flutter_template/pages/onboarding/domain/onboarding_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit()
      : super(
          ((getUser().onboardingStep ?? 0) == 0)
              ? const OnboardingState.init()
              : OnboardingState(currentPage: getUser().onboardingStep ?? 0),
        );

  final _firestore = dependencyLocator<FirebaseFirestore>();
  final PageController _pageController = PageController(
    initialPage: (getUser().onboardingStep ?? 0) == 0
        ? 0
        : getUser().onboardingStep ?? 0,
  );

  PageController get pageController => _pageController;

  Future<void> getJobFilters() async {
    emit(state.copyWith(filtersApiStatus: ApiStatus.loading));
    try {
      final result = await _firestore.collection('jobFilters').get();
      Map<String, dynamic> jsonData =
          result.docs.firstOrNull?.data() as Map<String, dynamic>;
      final filters = JobFilterModel.fromMap(jsonData);
      if (!dependencyLocator.isRegistered<JobFilterModel>()) {
        dependencyLocator.registerSingleton<JobFilterModel>(
          JobFilterModel.fromMap(jsonData),
        );
      }
      emit(
        state.copyWith(
          filtersApiStatus: ApiStatus.success,
          filters: filters,
        ),
      );
    } catch (error) {
      emit(state.copyWith(filtersApiStatus: ApiStatus.failure));
      log('Error while fetching job filters- ${error.toString()}');
      // Utils.showToast(message: 'Something went wrong while getting filters');
    }
  }

  Future<void> onPageChange({
    required BuildContext context,
    bool next = true,
  }) async {
    int page = state.currentPage;
    if (next) {
      if (page <= 2) {
        if (await _validateSteps(context: context, page: page)) {
          if (page == 2) {
            AppRoutes.appRouter.pushReplacement(Routes.dashboard);
          } else {
            page++;
          }
        }
      }
    } else {
      if (page >= 0) {
        page--;
      }
    }
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
    emit(state.copyWith(currentPage: page));
  }

  /// context is required to initialize the respective cubits
  /// global context(navigator key) doesn't work here
  /// do not use try catch in the methods invoked in switch cases
  /// as it is already handled in this(top-level) function only
  Future<bool> _validateSteps({
    required BuildContext context,
    required int page,
  }) async {
    emit(state.copyWith(continueOnboardingApiStatus: ApiStatus.loading));
    final user = getUser();
    bool result = false;
    try {
      if (user.role?.userRole == Role.candidate) {
        final candidateCubit = context.read<CandidateOnboardingCubit>();
        switch (page) {
          case 0:
            result = await candidateCubit.continueOnboardingStep1();
            break;
          case 1:
            result = await candidateCubit.continueOnboardingStep2();
            break;
          case 2:
            result = await candidateCubit.continueOnboardingStep3();
            break;
          default:
            break;
        }
        emit(state.copyWith(continueOnboardingApiStatus: ApiStatus.success));
        return result;
      } else if (user.role?.userRole == Role.recruiter) {}
    } catch (error) {
      log('Error in step $page validation: ${error.toString()}');
      Utils.showToast(message: 'Failed to update details at the moment!');
      emit(state.copyWith(continueOnboardingApiStatus: ApiStatus.failure));
      return false;
    }
    return false;
  }
}
