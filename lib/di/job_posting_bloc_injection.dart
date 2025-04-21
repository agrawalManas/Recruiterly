import 'package:cades_flutter_template/pages/job_posting/domain/job_posting_cubit.dart';
import 'package:cades_flutter_template/pages/job_posting/presentation/job_posting_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobPostingBlocInjection extends StatelessWidget {
  const JobPostingBlocInjection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JobPostingCubit(),
      child: const JobPostingView(),
    );
  }
}
