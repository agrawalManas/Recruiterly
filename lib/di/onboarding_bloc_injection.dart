import 'package:cades_flutter_template/pages/onboarding/domain/onboarding_cubit.dart';
import 'package:cades_flutter_template/pages/onboarding/presentation/onboarding_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingBlocInjection extends StatelessWidget {
  final Widget? child;
  const OnboardingBlocInjection({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: const OnboardingView(),
    );
  }
}
