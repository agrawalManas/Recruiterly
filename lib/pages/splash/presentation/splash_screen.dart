import 'package:cades_flutter_template/common/app_assets.dart';
import 'package:cades_flutter_template/common/image_loader.dart';
import 'package:cades_flutter_template/pages/authentication/domain/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthenticationCubit _authenticationCubit;

  @override
  void initState() {
    super.initState();
    _authenticationCubit = context.read<AuthenticationCubit>();
    _authenticationCubit.checkAuthStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(8.r),
          ),
          child: ImageLoader.asset(
            AppAssets.logo,
            height: 120.h,
            width: 120.w,
          ),
        ),
      ),
    );
  }
}
