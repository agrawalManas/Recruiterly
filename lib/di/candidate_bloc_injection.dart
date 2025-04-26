import 'package:cades_flutter_template/pages/onboarding/domain/candidate/candidate_onboarding_cubit.dart';
import 'package:cades_flutter_template/pages/onboarding/presentation/widgets/candidate_onboarding/candidate_onboarding_step_1.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CandidateBlocInjection extends StatelessWidget {
  const CandidateBlocInjection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CandidateOnboardingCubit(),
      child: const CandidateOnboardingStep1(),
    );
  }
}
