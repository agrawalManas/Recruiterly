import 'package:talent_mesh/pages/authentication/domain/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootBlocInjection extends StatelessWidget {
  final Widget child;
  const RootBlocInjection({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => AuthenticationCubit()),
    ], child: child);
  }
}
