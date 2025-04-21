import 'package:cades_flutter_template/common/app_enums.dart';
import 'package:cades_flutter_template/common/navigation/app_routes.dart';
import 'package:cades_flutter_template/common/utils/extensions/string_extensions.dart';
import 'package:cades_flutter_template/common/widgets/button/circular_icon_button.dart';
import 'package:cades_flutter_template/common/widgets/button/custom_button.dart';
import 'package:cades_flutter_template/common/widgets/textfield/custom_textfield_with_label.dart';
import 'package:cades_flutter_template/pages/authentication/domain/authentication_cubit.dart';
import 'package:cades_flutter_template/pages/authentication/domain/authentication_state.dart';
import 'package:cades_flutter_template/pages/authentication/presentation/widgets/role_option.dart';
import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late AuthenticationCubit _authenticationCubit;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _authenticationCubit = context.read<AuthenticationCubit>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passWordController.dispose();
    _confirmPasswordController.dispose();
    _authenticationCubit.resetState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              36.verticalSpace,
              CircularIconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.textPrimary,
                  size: 20,
                ),
                backgroundColor: AppColors.disabledText.withValues(alpha: 0.4),
                onTap: () {
                  AppRoutes.appRouter.pop();
                },
              ),
              36.verticalSpace,
              Text(
                "Start your journey at Recruiterly",
                style: AppTextStyles.heading1ExtraBold24(
                  color: AppColors.primary,
                ),
              ),
              40.verticalSpace,

              //------Full Name
              CustomTextfieldWithLabel(
                isRequired: true,
                labelText: 'Full Name',
                hintText: 'Type here...',
                controller: _nameController,
                textInputAction: TextInputAction.next,
              ),
              16.verticalSpace,

              //------Email
              CustomTextfieldWithLabel(
                isRequired: true,
                labelText: 'Email',
                hintText: 'Type here...',
                controller: _emailController,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.emailAddress,
              ),
              16.verticalSpace,

              //-------Password
              CustomTextfieldWithLabel(
                isRequired: true,
                labelText: 'Password',
                hintText: 'Type here...',
                isPasswordFiled: true,
                controller: _passWordController,
                textInputAction: TextInputAction.next,
              ),
              16.verticalSpace,

              //-------Confirm Password
              CustomTextfieldWithLabel(
                isRequired: true,
                labelText: 'Confirm Password',
                hintText: 'Type here...',
                isPasswordFiled: true,
                controller: _confirmPasswordController,
                textInputAction: TextInputAction.done,
              ),
              24.verticalSpace,

              //-------Role Selection
              Text(
                "Sign up as:",
                style: AppTextStyles.body2SemiBold16(),
              ),
              12.verticalSpace,
              BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: RoleOption(
                          title: Role.candidate.name.toCapitalized(),
                          onTap: () {
                            _authenticationCubit.onChangeRole(Role.candidate);
                          },
                          isSelected: state.signupRole == Role.candidate,
                        ),
                      ),
                      16.horizontalSpace,
                      Expanded(
                        child: RoleOption(
                          title: Role.recruiter.name.toCapitalized(),
                          onTap: () {
                            _authenticationCubit.onChangeRole(Role.recruiter);
                          },
                          isSelected: state.signupRole == Role.recruiter,
                        ),
                      ),
                      16.horizontalSpace,
                    ],
                  );
                },
              ),
              32.verticalSpace,

              //--------SignUp-Btn
              BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, state) {
                  return CustomButton(
                    width: MediaQuery.sizeOf(context).width,
                    verticalPadding: 8.h,
                    horizontalPadding: 8.w,
                    wantBorder: false,
                    disableElevation: true,
                    isLoading: state.signupApiStatus == ApiStatus.loading,
                    onPressed: () {
                      if (state.signupApiStatus != ApiStatus.loading) {
                        _authenticationCubit.onSignup(
                          email: _emailController.text.trim(),
                          name: _nameController.text.trim(),
                          password: _passWordController.text.trim(),
                          confirmPassword:
                              _confirmPasswordController.text.trim(),
                        );
                      }
                    },
                    child: Text(
                      'Sign Up',
                      style: AppTextStyles.body2Medium16(
                        color: AppColors.surface,
                      ),
                    ),
                  );
                },
              ),
              16.verticalSpace,

              //--------Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: AppTextStyles.body3Regular14(),
                  ),
                  GestureDetector(
                    onTap: () {
                      AppRoutes.appRouter.pop();
                    },
                    child: Text(
                      "Login",
                      style: AppTextStyles.body3Medium14(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              40.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
