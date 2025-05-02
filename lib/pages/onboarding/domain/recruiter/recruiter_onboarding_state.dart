// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class RecruiterOnboardingState extends Equatable {
  final int currentPage;
  final List<String>? industries;
  final String? companySize;
  const RecruiterOnboardingState({
    this.currentPage = 0,
    this.industries,
    this.companySize,
  });

  @override
  List<Object?> get props => [
        currentPage,
        industries,
        companySize,
      ];

  const RecruiterOnboardingState.init()
      : this(currentPage: 0, industries: null, companySize: null);

  RecruiterOnboardingState copyWith({
    final int? currentPage,
    final List<String>? industries,
    final String? companySize,
  }) {
    return RecruiterOnboardingState(
      currentPage: currentPage ?? this.currentPage,
      industries: industries ?? this.industries,
      companySize: companySize ?? this.companySize,
    );
  }
}
