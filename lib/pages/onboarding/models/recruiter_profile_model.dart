import 'package:cloud_firestore/cloud_firestore.dart';

class RecruiterProfileModel {
  final String? userId;
  final String? companyName;
  final String? companyDescription;
  final String? companyLogo;
  final String? industry;
  final String? contactPhone;
  final String? website;
  final Address? address;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  RecruiterProfileModel({
    this.userId,
    this.companyName,
    this.companyDescription,
    this.companyLogo,
    this.industry,
    this.contactPhone,
    this.website,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  factory RecruiterProfileModel.fromJson(Map<String, dynamic> json) {
    return RecruiterProfileModel(
      userId: json['userId'] as String?,
      companyName: json['companyName'] as String?,
      companyDescription: json['companyDescription'] as String?,
      companyLogo: json['companyLogo'] as String?,
      industry: json['industry'] as String?,
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
      'companyName': companyName,
      'companyDescription': companyDescription,
      'companyLogo': companyLogo,
      'industry': industry,
      'contactPhone': contactPhone,
      'website': website,
      'address': address?.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class Address {
  final String? street;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;

  Address({
    this.street,
    this.city,
    this.state,
    this.country,
    this.postalCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      postalCode: json['postalCode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
    };
  }
}
