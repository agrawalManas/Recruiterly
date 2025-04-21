import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class Observer extends BlocObserver {
  const Observer();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('${bloc.runtimeType}, ${change.currentState}');
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    log('Bloc closed $bloc');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('OnTransition (${bloc.runtimeType}, $transition)');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onEvent(${bloc.runtimeType}, $event)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('${bloc.runtimeType}, $error, $stackTrace');
  }
}
