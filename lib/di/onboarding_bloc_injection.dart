import 'package:talent_mesh/pages/onboarding/domain/candidate/candidate_onboarding_cubit.dart';
import 'package:talent_mesh/pages/onboarding/domain/onboarding_cubit.dart';
import 'package:talent_mesh/pages/onboarding/domain/recruiter/recruiter_onboarding_cubit.dart';
import 'package:talent_mesh/pages/onboarding/presentation/onboarding_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingBlocInjection extends StatelessWidget {
  final Widget? child;
  final bool? allowBack;
  const OnboardingBlocInjection({this.allowBack, super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OnboardingCubit()),
        BlocProvider(create: (context) => CandidateOnboardingCubit()),
        BlocProvider(
          create: (context) => RecruiterOnboardingCubit(),
        ),
      ],
      child: OnboardingView(
        allowBack: allowBack ?? true,
      ),
    );
  }
}
