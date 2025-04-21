import 'package:cades_flutter_template/pages/authentication/domain/authentication_cubit.dart';
import 'package:cades_flutter_template/pages/authentication/presentation/signin_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBlocInjection extends StatelessWidget {
  final Widget? child;
  const AuthenticationBlocInjection({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: child ?? const SigninView(),
    );
  }
}
