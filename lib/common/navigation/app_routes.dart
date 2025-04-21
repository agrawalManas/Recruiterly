import 'package:cades_flutter_template/common/navigation/page_not_found.dart';
import 'package:cades_flutter_template/common/navigation/routes.dart';
import 'package:cades_flutter_template/di/authentication_bloc_injection.dart';
import 'package:cades_flutter_template/di/candidate_bloc_injection.dart';
import 'package:cades_flutter_template/di/job_listing_bloc_injection.dart';
import 'package:cades_flutter_template/di/job_posting_bloc_injection.dart';
import 'package:cades_flutter_template/di/onboarding_bloc_injection.dart';
import 'package:cades_flutter_template/di/recruiter_bloc_injection.dart';
import 'package:cades_flutter_template/di/recruiter_dashboard_bloc_injection.dart';
import 'package:cades_flutter_template/pages/authentication/presentation/sign_up_view.dart';
import 'package:cades_flutter_template/pages/authentication/presentation/signin_view.dart';
import 'package:cades_flutter_template/pages/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Root class to handle app routes using [GoRouter].
/// [Routes] class to define common app routes as static
/// instances.

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellRouterKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static final GoRouter _router = GoRouter(
    initialLocation: Routes.splash,
    navigatorKey: navigatorKey,
    errorBuilder: ((context, state) {
      return const PageNotFound();
    }),
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const AuthenticationBlocInjection(
          child: SplashScreen(),
        ),
      ),
      ShellRoute(
        navigatorKey: shellRouterKey,
        routes: [
          GoRoute(
            path: Routes.signin,
            builder: (context, state) {
              return const SigninView();
            },
          ),
          GoRoute(
            path: Routes.signup,
            builder: (context, state) {
              return const SignupView();
            },
          ),
        ],
        builder: (context, state, child) {
          return AuthenticationBlocInjection(
            child: child,
          );
        },
      ),
      ShellRoute(
        navigatorKey: shellRouterKey,
        routes: [
          GoRoute(
            path: Routes.candidateOnboarding,
            builder: (context, state) {
              return const CandidateBlocInjection();
            },
          ),
          GoRoute(
            path: Routes.recruiterOnboarding,
            builder: (context, state) {
              return const RecruiterBlocInjection();
            },
          ),
        ],
        builder: (context, state, child) {
          return OnboardingBlocInjection(
            child: child,
          );
        },
      ),
      GoRoute(
        path: Routes.dashboard,
        builder: (context, state) {
          return const DashboardBlocInjection();
        },
      ),
      GoRoute(
        path: Routes.jobPost,
        builder: (context, state) {
          return const JobPostingBlocInjection();
        },
      ),
      GoRoute(
        path: Routes.jobListing,
        builder: (context, state) {
          return const JobListingBlocInjection();
        },
      ),
    ],
  );

  static GoRouter get appRouter => _router;
}

CustomTransitionPage buildPageWithoutAnimation<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: Duration.zero,
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      // Change the opacity of the screen using a Curve based on the the animation's
      // value
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: child,
      );
    },
  );
}
