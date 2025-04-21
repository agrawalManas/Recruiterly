// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:cades_flutter_template/common/app_enums.dart';

class AuthenticationState extends Equatable {
  final Role? signupRole;
  final ApiStatus signupApiStatus;
  final ApiStatus signinApiStatus;
  const AuthenticationState({
    this.signupRole,
    this.signupApiStatus = ApiStatus.init,
    this.signinApiStatus = ApiStatus.init,
  });

  @override
  List<Object?> get props => [
        signupRole,
        signupApiStatus,
        signinApiStatus,
      ];

  const AuthenticationState.init()
      : this(
          signupRole: null,
          signupApiStatus: ApiStatus.init,
          signinApiStatus: ApiStatus.init,
        );

  AuthenticationState copyWith({
    final Role? signupRole,
    final ApiStatus? signupApiStatus,
    final ApiStatus? signinApiStatus,
  }) {
    return AuthenticationState(
      signupRole: signupRole ?? this.signupRole,
      signupApiStatus: signupApiStatus ?? this.signupApiStatus,
      signinApiStatus: signinApiStatus ?? this.signinApiStatus,
    );
  }
}
