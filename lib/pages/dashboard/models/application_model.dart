import 'dart:convert';
import 'package:cades_flutter_template/pages/job_listing/model/job_filter_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApplicationModel {
  final String? candidateId;
  final String? jobId;
  final String? companyName;
  final String? jobRole;
  final String? companyLogo;
  final String? recruiterId;
  final String? applicationStatus;
  final String? coverLetter;
  final String? resumeURL;
  final DateTime? appliedAt;
  final Location? location;
  final String? employmentType;
  final bool? isRemote;
  final DateTime? lastUpdatedAt;
  final String? lastUpdatedBy;
  final String? applicationId;
  final Notes? notes;
  final int? candidateRating;
  final int? applicationsCount;
  ApplicationModel({
    this.candidateId,
    this.recruiterId,
    this.companyLogo,
    this.companyName,
    this.jobRole,
    this.jobId,
    this.applicationStatus,
    this.coverLetter,
    this.resumeURL,
    this.appliedAt,
    this.lastUpdatedAt,
    this.lastUpdatedBy,
    this.location,
    this.employmentType,
    this.isRemote,
    this.notes,
    this.candidateRating,
    this.applicationId,
    this.applicationsCount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'candidateId': candidateId,
      'jobId': jobId,
      'recruiterId': recruiterId,
      'companyLogo': companyLogo,
      'companyName': companyName,
      'jobRole': jobRole,
      'applicationStatus': applicationStatus,
      'location': location?.toMap(),
      'employmentType': employmentType,
      'isRemote': isRemote,
      'coverLetter': coverLetter,
      'resumeURL': resumeURL,
      'appliedAt': appliedAt,
      'lastUpdatedAt': lastUpdatedAt,
      'notes': notes?.toMap(),
      'candidateRating': candidateRating,
      'applicationId': applicationId,
      'applicationsCount': applicationsCount,
    };
  }

  factory ApplicationModel.fromMap(Map<String, dynamic> map) {
    return ApplicationModel(
      candidateId: map['candidateId'] as String?,
      jobId: map['jobId'] as String?,
      recruiterId: map['recruiterId'] as String?,
      applicationStatus: map['applicationStatus'] as String?,
      location:
          map['location'] != null ? Location.fromMap(map['location']) : null,
      jobRole: map['jobRole'] as String?,
      companyLogo: map['companyLogo'] as String?,
      companyName: map['companyName'] as String?,
      isRemote: map['isRemote'] as bool?,
      coverLetter: map['coverLetter'] as String?,
      resumeURL: map['resumeURL'] as String?,
      appliedAt: map['appliedAt'] != null
          ? (map['appliedAt'] as Timestamp).toDate()
          : null,
      employmentType: map['employmentType'] as String?,
      lastUpdatedAt: map['lastUpdatedAt'] != null
          ? (map['lastUpdatedAt'] as Timestamp).toDate()
          : null,
      lastUpdatedBy: map['lastUpdatedBy'] as String?,
      notes: map['notes'] != null
          ? Notes.fromMap(map['notes'] as Map<String, dynamic>)
          : null,
      candidateRating: map['candidateRating'] as int?,
      applicationsCount: map['applicationsCount'] as int?,
      applicationId: map['applicationId'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApplicationModel.fromJson(String source) => ApplicationModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}

class Notes {
  final String? text;
  final DateTime? updatedAt;
  Notes({
    required this.text,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      text: map['text'] as String?,
      updatedAt: map['updatedAt'] != null
          ? (map['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notes.fromJson(String source) => Notes.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
