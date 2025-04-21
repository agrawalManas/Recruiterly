// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cades_flutter_template/common/app_enums.dart';
import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final Role? role;
  final ApiStatus signupApiStatus;
  final int currentPage;
  const OnboardingState({
    this.role,
    this.signupApiStatus = ApiStatus.init,
    this.currentPage = 0,
  });

  @override
  List<Object?> get props => [role, signupApiStatus, currentPage];

  const OnboardingState.init()
      : this(
          role: null,
          signupApiStatus: ApiStatus.init,
          currentPage: 0,
        );

  OnboardingState copyWith({
    final Role? role,
    final ApiStatus? signupApiStatus,
    final int? currentPage,
  }) {
    return OnboardingState(
      role: role ?? this.role,
      signupApiStatus: signupApiStatus ?? this.signupApiStatus,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
