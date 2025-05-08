import 'package:talent_mesh/common/models/user_model.dart';
import 'package:talent_mesh/common/navigation/app_routes.dart';
import 'package:talent_mesh/di/root_bloc_injection.dart';
import 'package:talent_mesh/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:talent_mesh/common/constants.dart';
import 'package:talent_mesh/common/utils/observer.dart';
import 'package:talent_mesh/common/utils/locator.dart';
import 'package:talent_mesh/styles/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //------Set-app-orientation------
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  //--------Get-It
  await setupGetIt();
  dependencyLocator<UserModel>();

  Bloc.observer = const Observer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: RootBlocInjection(
        child: MaterialApp.router(
          title: appName,
          theme: appTheme(),
          debugShowCheckedModeBanner: false,
          routerConfig: AppRoutes.appRouter,
        ),
      ),
    );
  }
}
