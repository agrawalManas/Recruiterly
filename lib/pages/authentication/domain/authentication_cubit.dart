import 'dart:developer';
import 'package:cades_flutter_template/common/app_enums.dart';
import 'package:cades_flutter_template/common/models/user_model.dart';
import 'package:cades_flutter_template/common/navigation/app_routes.dart';
import 'package:cades_flutter_template/common/navigation/routes.dart';
import 'package:cades_flutter_template/common/utils/locator.dart';
import 'package:cades_flutter_template/common/utils/utils.dart';
import 'package:cades_flutter_template/pages/authentication/domain/authentication_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(const AuthenticationState.init());

  final FirebaseAuth _firebaseAuth = dependencyLocator<FirebaseAuth>();

  void checkAuthStatus() {
    Future.delayed((const Duration(seconds: 2)), () async {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        await _fetchUserDetails(id: currentUser.uid);
        AppRoutes.appRouter.pushReplacement(Routes.dashboard);
      } else {
        AppRoutes.appRouter.pushReplacement(Routes.signin);
      }
    });
  }

  void resetState() {
    emit(const AuthenticationState.init());
  }

  void onChangeRole(Role role) {
    if (role != state.signupRole) {
      emit(state.copyWith(signupRole: role));
    }
  }

  bool _validateSignupDetails({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    return _validateEmail(email) &&
        _validateName(name) &&
        _validatePassword(
          password: password,
          confirmPassword: confirmPassword,
        ) &&
        state.signupRole != null;
  }

  bool _validateName(String name) {
    if (name.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool _validateEmail(String email) {
    if (email.isNotEmpty &&
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return true;
    }
    return false;
  }

  bool _validatePassword({
    required String password,
    required String confirmPassword,
  }) {
    if (password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        password == confirmPassword) {
      return true;
    }
    return false;
  }

  //-----Sign Up using email & password with validations
  Future<void> onSignup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(state.copyWith(signupApiStatus: ApiStatus.loading));
    if (_validateSignupDetails(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    )) {
      try {
        await _signupWithEmailPassword(
          email: email,
          password: password,
          name: name,
        );
        emit(state.copyWith(signupApiStatus: ApiStatus.success));
        // AppRoutes.appRouter.pushReplacement(Routes.onboarding);
      } catch (error) {
        emit(state.copyWith(signupApiStatus: ApiStatus.failure));
        log('Error while creating new account- ${error.toString()}');
        Utils.showToast(message: error.toString());
      }
    } else {
      Utils.showToast(message: 'Please enter valid details');
    }
    emit(state.copyWith(signupApiStatus: ApiStatus.success));
  }

  Future<void> _signupWithEmailPassword({
    required String email,
    required String password,
    required String name,
    String? profileImage,
  }) async {
    await _firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) async {
        await _postUserDetails(
          user: value.user,
          userModel: UserModel(
            uid: value.user?.uid ?? '',
            name: name,
            profileImage: profileImage ?? '',
            email: email,
            role: state.signupRole?.name ?? '',
            createdAt: DateTime.now(),
            lastLogin: DateTime.now(),
            onboardingStep: 0,
          ),
        ).then((value) async {
          await signIn(email: email, password: password);
        });
      },
    );
  }

  Future<void> _postUserDetails({
    required User? user,
    required UserModel userModel,
  }) async {
    if (user != null) {
      await userDetailDocumentRef(user.uid).set(
        userModel.toJson(),
      );
      Utils.showToast(message: 'Account created successfully!');
    }
  }

  //-----Sign In with email & password with validations
  Future signIn({required String email, required String password}) async {
    if (_validateEmail(email) && password.isNotEmpty) {
      try {
        emit(state.copyWith(signinApiStatus: ApiStatus.loading));
        await _firebaseAuth
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then(
          (value) async {
            await _fetchUserDetails(id: value.user?.uid);
          },
        );
        // final user = dependencyLocator<UserModel>();
        emit(state.copyWith(signinApiStatus: ApiStatus.success));
        AppRoutes.appRouter.pushReplacement(Routes.dashboard);
      } catch (error) {
        emit(state.copyWith(signinApiStatus: ApiStatus.failure));
        log('Error while Sign In- ${error.toString()}');
        Utils.showToast(message: error.toString());
      }
    } else {
      Utils.showToast(message: 'Please enter valid details!');
    }
  }

  Future<void> _fetchUserDetails({required String? id}) async {
    if (id != null) {
      final userDetails = await userDetailDocumentRef(id).get();
      Map<String, dynamic> jsonData =
          userDetails.data() as Map<String, dynamic>;
      dependencyLocator.unregister<UserModel>();
      dependencyLocator.registerSingleton<UserModel>(
        UserModel.fromJson(jsonData),
      );
    }
  }
}
