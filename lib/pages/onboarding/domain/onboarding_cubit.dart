import 'package:cades_flutter_template/pages/onboarding/domain/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState.init());

  final PageController _pageController = PageController();
  PageController get pageController => _pageController;

  void onPageChange({bool next = true}) {
    int page = state.currentPage;
    if (next) {
      if (page <= 2) {
        page++;
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
}
