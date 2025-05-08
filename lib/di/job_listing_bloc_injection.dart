import 'package:talent_mesh/pages/job_listing/domain/job_listing_cubit.dart';
import 'package:talent_mesh/pages/job_listing/presentation/job_listing_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobListingBlocInjection extends StatelessWidget {
  const JobListingBlocInjection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JobListingCubit(),
      child: const JobListingView(),
    );
  }
}
