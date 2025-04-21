import 'package:cades_flutter_template/common/app_enums.dart';
import 'package:cades_flutter_template/common/models/user_model.dart';
import 'package:cades_flutter_template/common/utils/locator.dart';
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  Role get userRole {
    final user = dependencyLocator<UserModel>();
    switch (user.role) {
      case 'admin':
        return Role.admin;
      case 'candidate':
        return Role.candidate;
      case 'recruiter':
        return Role.recruiter;
      default:
        return Role.none;
    }
  }
}
