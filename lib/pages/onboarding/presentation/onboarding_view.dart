import 'package:cades_flutter_template/common/widgets/button/circular_icon_button.dart';
import 'package:cades_flutter_template/common/widgets/button/custom_button.dart';
import 'package:cades_flutter_template/pages/onboarding/domain/onboarding_cubit.dart';
import 'package:cades_flutter_template/pages/onboarding/domain/onboarding_state.dart';
import 'package:cades_flutter_template/pages/onboarding/presentation/widgets/recruiter_onboarding/recruiter_onboarding_step_1.dart';
import 'package:cades_flutter_template/pages/onboarding/presentation/widgets/recruiter_onboarding/recruiter_onboarding_step_2.dart';
import 'package:cades_flutter_template/pages/onboarding/presentation/widgets/recruiter_onboarding/recruiter_onboarding_step_3.dart';
import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late OnboardingCubit _onboardingCubit;

  final List<String> _pageTitles = [
    'Step1: Personal Information',
    'Step 2: Professional Details',
    'Step 3: Skills & Preferences',
  ];

  @override
  void initState() {
    super.initState();
    _onboardingCubit = context.read<OnboardingCubit>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // void _nextPage() {
  //   if (_currentPage < 2) {
  //     _pageController.nextPage(
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeInOut,
  //     );
  //   } else {
  //     // Submit form and complete onboarding
  //     _onboardingCubit.completeOnboarding();
  //   }
  // }

  // void _previousPage() {
  //   if (_currentPage > 0) {
  //     _pageController.previousPage(
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeInOut,
  //     );
  //   } else {
  //     // Go back to previous screen
  //     AppRoutes.appRouter.pop();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            36.verticalSpace,
            BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) {
                return Text(
                  _pageTitles[state.currentPage],
                  style: AppTextStyles.heading3SemiBold18(
                    color: AppColors.primary,
                  ),
                );
              },
            ),
            24.verticalSpace,

            // Progress indicator
            Row(
              children: List.generate(
                _pageTitles.length,
                (index) => Expanded(
                  child: BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 2.w),
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: index <= state.currentPage
                              ? AppColors.primary
                              : AppColors.disabledText,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            24.verticalSpace,

            // PageView
            Expanded(
              child: PageView(
                controller: _onboardingCubit.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  // CandidateOnboardingStep1(),
                  // CandidateOnboardingStep2(),
                  // CandidateOnboardingStep3(),
                  RecruiterOnboardingStep1(),
                  RecruiterOnboardingStep2(),
                  RecruiterOnboardingStep3(),
                ],
              ),
            ),
            // 24.verticalSpace,
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Row(
              children: [
                if (state.currentPage != 0) ...[
                  CircularIconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.textPrimary,
                      size: 20,
                    ),
                    backgroundColor:
                        AppColors.disabledText.withValues(alpha: 0.4),
                    onTap: () {
                      _onboardingCubit.onPageChange(next: false);
                    },
                  ),
                  16.horizontalSpace,
                ],
                Expanded(
                  child: CustomButton(
                    width: MediaQuery.sizeOf(context).width,
                    verticalPadding: 8.h,
                    horizontalPadding: 8.w,
                    wantBorder: false,
                    disableElevation: true,
                    // isLoading: state.onboardingStatus == ApiStatus.loading,
                    onPressed: () {
                      _onboardingCubit.onPageChange();
                    },
                    child: Text(
                      state.currentPage == 2 ? 'Complete' : 'Continue',
                      style: AppTextStyles.body2Medium16(
                        color: AppColors.surface,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
