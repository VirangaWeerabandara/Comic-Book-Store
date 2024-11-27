import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String contactNumber;
  final DateTime createdAt;
  final String? profilePictureUrl; // New variable for profile picture URL

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.contactNumber,
    required this.createdAt,
    this.profilePictureUrl, // Allow null value
  });

  // Convert UserModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'contactNumber': contactNumber,
      'createdAt': createdAt,
      'profilePictureUrl': profilePictureUrl, // Include profile picture URL
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
      profilePictureUrl:
          data['profilePictureUrl'], // Handle profile picture URL
    );
  }
}
