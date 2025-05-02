import 'package:cloud_firestore/cloud_firestore.dart';

class RecruiterProfileModel {
  final String? userId;
  final String? companyName;
  final String? companyDescription;
  final List<dynamic>? industries;
  final int? yearFounded;
  final String? companyLogo;
  final String? contactPhone;
  final String? companySize;
  final String? website;
  final Address? address;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  RecruiterProfileModel({
    this.userId,
    this.yearFounded,
    this.companyName,
    this.industries,
    this.companyDescription,
    this.companyLogo,
    this.contactPhone,
    this.companySize,
    this.website,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  factory RecruiterProfileModel.fromJson(Map<String, dynamic> json) {
    return RecruiterProfileModel(
      userId: json['userId'] as String?,
      yearFounded: json['yearFounded'] as int?,
      companyName: json['companyName'] as String?,
      companySize: json['companySize'] as String?,
      companyDescription: json['companyDescription'] as String?,
      industries: json['industries'] as List<dynamic>?,
      companyLogo: json['companyLogo'] as String?,
      contactPhone: json['contactPhone'] as String?,
      website: json['website'] as String?,
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'yearFounded': yearFounded,
      'industries': industries,
      'companyName': companyName,
      'companySize': companySize,
      'companyDescription': companyDescription,
      'companyLogo': companyLogo,
      'contactPhone': contactPhone,
      'website': website,
      'address': address?.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class Address {
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;

  Address({
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.country,
    this.postalCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressLine1: json['addressLine1'] as String?,
      addressLine2: json['addressLine2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      postalCode: json['postalCode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
    };
  }
}
