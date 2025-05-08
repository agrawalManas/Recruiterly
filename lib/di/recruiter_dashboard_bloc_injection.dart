import 'package:talent_mesh/pages/dashboard/domain/dashboard_cubit.dart';
import 'package:talent_mesh/pages/dashboard/presentation/dashboard_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBlocInjection extends StatelessWidget {
  const DashboardBlocInjection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: const DashboardView(),
    );
  }
}
