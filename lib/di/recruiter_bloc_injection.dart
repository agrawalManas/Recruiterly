import 'package:cades_flutter_template/pages/onboarding/domain/recruiter/recruiter_cubit.dart';
import 'package:cades_flutter_template/pages/onboarding/presentation/widgets/recruiter_onboarding/recruiter_onboarding_step_1.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecruiterBlocInjection extends StatelessWidget {
  const RecruiterBlocInjection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecruiterCubit(),
      child: const RecruiterOnboardingStep1(),
    );
  }
}
