import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String contactNumber;
  final DateTime createdAt;
  final String? profilePictureUrl;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.contactNumber,
    required this.createdAt,
    this.profilePictureUrl,
  });

  // Convert UserModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'contactNumber': contactNumber,
      'createdAt': createdAt,
      'profilePictureUrl': profilePictureUrl,
    };
  }

  // Create UserModel from Firestore Document Snapshot
  factory UserModel.fromMap(String uid, Map<String, dynamic> data) {
    return UserModel(
      uid: uid,
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      contactNumber: data['contactNumber'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      profilePictureUrl: data['profilePictureUrl'],
    );
  }

  UserModel copyWith({
    String? uid,
    String? fullName,
    String? email,
    String? contactNumber,
    DateTime? createdAt,
    String? profilePictureUrl,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      contactNumber: contactNumber ?? this.contactNumber,
      createdAt: createdAt ?? this.createdAt,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }
}
