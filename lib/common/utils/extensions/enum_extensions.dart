import 'package:talent_mesh/common/app_enums.dart';
import 'package:talent_mesh/styles/app_colors.dart';
import 'package:flutter/material.dart';

extension EnumExtensions on Role {
  Color get accentColor {
    switch (this) {
      case Role.candidate:
        return AppColors.candidateAccent;
      case Role.recruiter:
        return AppColors.recruiterAccent;
      case Role.admin:
        return AppColors.adminAccent;
      case Role.none:
        return AppColors.primary;
    }
  }
}

extension ApplicationStatusExtension on ApplicationStatus {
  Color get accentColor {
    switch (this) {
      case ApplicationStatus.hired:
        return AppColors.success;
      case ApplicationStatus.rejected:
        return AppColors.error;
      case ApplicationStatus.shortlisted:
        return AppColors.primary;
      case ApplicationStatus.review:
        return AppColors.warning;
      case ApplicationStatus.interview:
        return AppColors.adminAccent;
      case ApplicationStatus.applied:
        return AppColors.textSecondary;
    }
  }
}

extension JobStatusExtension on JobStatus {
  Color get accentColor {
    switch (this) {
      case JobStatus.draft:
        return AppColors.warning;
      case JobStatus.filled:
        return AppColors.primary;
      case JobStatus.active:
        return AppColors.success;
      case JobStatus.closed:
        return AppColors.error;
    }
  }
}
