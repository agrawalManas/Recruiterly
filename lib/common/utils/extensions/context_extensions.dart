import 'package:talent_mesh/common/app_enums.dart';
import 'package:talent_mesh/common/models/user_model.dart';
import 'package:talent_mesh/common/utils/locator.dart';
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
