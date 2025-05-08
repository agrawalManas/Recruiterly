// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:talent_mesh/common/app_enums.dart';
import 'package:talent_mesh/pages/job_listing/model/job_filter_model.dart';
import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final Role? role;
  final ApiStatus continueOnboardingApiStatus;
  final ApiStatus filtersApiStatus;
  final JobFilterModel? filters;
  final int currentPage;
  const OnboardingState({
    this.role,
    this.filters,
    this.filtersApiStatus = ApiStatus.init,
    this.continueOnboardingApiStatus = ApiStatus.init,
    this.currentPage = 0,
  });

  @override
  List<Object?> get props => [
        role,
        continueOnboardingApiStatus,
        currentPage,
        filters,
        filtersApiStatus,
      ];

  const OnboardingState.init()
      : this(
          role: null,
          filters: null,
          filtersApiStatus: ApiStatus.init,
          continueOnboardingApiStatus: ApiStatus.init,
          currentPage: 0,
        );

  OnboardingState copyWith({
    final Role? role,
    final JobFilterModel? filters,
    final ApiStatus? continueOnboardingApiStatus,
    final ApiStatus? filtersApiStatus,
    final int? currentPage,
  }) {
    return OnboardingState(
      role: role ?? this.role,
      continueOnboardingApiStatus:
          continueOnboardingApiStatus ?? this.continueOnboardingApiStatus,
      currentPage: currentPage ?? this.currentPage,
      filters: filters ?? this.filters,
      filtersApiStatus: filtersApiStatus ?? this.filtersApiStatus,
    );
  }
}
