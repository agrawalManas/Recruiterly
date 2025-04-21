// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String? companyName;
  final String? name;
  final String? profileImage;
  final String? email;
  final String? role;
  final DateTime? createdAt;
  final DateTime? lastLogin;
  final int? onboardingStep;
  UserModel({
    this.companyName,
    this.uid,
    this.name,
    this.profileImage,
    this.email,
    this.role = 'none',
    this.createdAt,
    this.lastLogin,
    this.onboardingStep,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'companyName': companyName,
      'name': name,
      'profileImage': profileImage,
      'email': email,
      'role': role,
      // 'createdAt': createdAt,
      // 'lastLogin': lastLogin,
      'createdAt': createdAt,
      'lastLogin': lastLogin,
      'onboardingStep': onboardingStep,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String?,
      companyName: map['company_name'] as String?,
      name: map['name'] as String?,
      profileImage: map['profileImage'] as String?,
      email: map['email'] as String?,
      role: map['role'] as String?,
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
      lastLogin: map['lastLogin'] != null
          ? (map['lastLogin'] as Timestamp).toDate()
          : null,
      onboardingStep: map['onboardingStep'] as int?,
    );
  }

  UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

  String userToJson(UserModel data) => json.encode(data.toJson());
}
