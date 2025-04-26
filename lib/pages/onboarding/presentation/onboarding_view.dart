import 'package:cades_flutter_template/common/app_enums.dart';
import 'package:cades_flutter_template/common/utils/extensions/context_extensions.dart';
import 'package:cades_flutter_template/common/utils/extensions/enum_extensions.dart';
import 'package:cades_flutter_template/common/utils/locator.dart';
import 'package:cades_flutter_template/common/widgets/button/circular_icon_button.dart';
import 'package:cades_flutter_template/common/widgets/button/custom_button.dart';
import 'package:cades_flutter_template/pages/onboarding/domain/onboarding_cubit.dart';
import 'package:cades_flutter_template/pages/onboarding/domain/onboarding_state.dart';
import 'package:cades_flutter_template/pages/onboarding/presentation/widgets/candidate_onboarding/candidate_onboarding_step_1.dart';
import 'package:cades_flutter_template/pages/onboarding/presentation/widgets/candidate_onboarding/candidate_onboarding_step_2.dart';
import 'package:cades_flutter_template/pages/onboarding/presentation/widgets/candidate_onboarding/candidate_onboarding_step_3.dart';
import 'package:cades_flutter_template/pages/onboarding/presentation/widgets/recruiter_onboarding/recruiter_onboarding_step_1.dart';
import 'package:cades_flutter_template/pages/onboarding/presentation/widgets/recruiter_onboarding/recruiter_onboarding_step_2.dart';
import 'package:cades_flutter_template/pages/onboarding/presentation/widgets/recruiter_onboarding/recruiter_onboarding_step_3.dart';
import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingView extends StatefulWidget {
  final bool allowBack;
  const OnboardingView({this.allowBack = true, super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late OnboardingCubit _onboardingCubit;
  final user = getUser();

  @override
  void initState() {
    super.initState();
    _onboardingCubit = context.read<OnboardingCubit>();
    _onboardingCubit.getJobFilters();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            32.verticalSpace,
            // Progress indicator
            Row(
              children: List.generate(
                3,
                (index) => Expanded(
                  child: BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 2.w),
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: index <= state.currentPage
                              ? context.userRole.accentColor
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
                children: [
                  if (context.userRole == Role.candidate) ...[
                    const CandidateOnboardingStep1(),
                    const CandidateOnboardingStep2(),
                    const CandidateOnboardingStep3(),
                  ] else if (context.userRole == Role.recruiter) ...[
                    const RecruiterOnboardingStep1(),
                    const RecruiterOnboardingStep2(),
                    const RecruiterOnboardingStep3()
                  ],
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
                if (widget.allowBack && state.currentPage != 0) ...[
                  //--------BACK-BUTTON
                  CircularIconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.textPrimary,
                      size: 20,
                    ),
                    backgroundColor:
                        AppColors.disabledText.withValues(alpha: 0.4),
                    onTap: () {
                      _onboardingCubit.onPageChange(
                        context: context,
                        next: false,
                      );
                    },
                  ),
                  16.horizontalSpace,
                ],

                //---------CONTINUE-BUTTON
                Expanded(
                  child: BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) {
                      return CustomButton(
                        width: MediaQuery.sizeOf(context).width,
                        verticalPadding: 8.h,
                        horizontalPadding: 8.w,
                        wantBorder: false,
                        disableElevation: true,
                        isLoading: state.continueOnboardingApiStatus ==
                            ApiStatus.loading,
                        onPressed: () {
                          if (state.continueOnboardingApiStatus !=
                              ApiStatus.loading) {
                            _onboardingCubit.onPageChange(context: context);
                          }
                        },
                        child: Text(
                          state.currentPage == 2 ? 'Complete' : 'Continue',
                          style: AppTextStyles.body2Medium16(
                            color: AppColors.surface,
                          ),
                        ),
                      );
                    },
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
