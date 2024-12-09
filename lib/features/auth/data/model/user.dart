// ignore_for_file: overridden_fields, annotate_overrides

import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User extends UserEntity {
  final String email;
  final String id;
  final String? userName;
  final String? phone;
  final String? profilePic;

  User({
    required this.email,
    required this.id,
    this.userName,
    this.phone,
    this.profilePic,
  }) : super(
          email: email,
          id: id,
          userName: userName,
          phone: phone,
          profilePic: profilePic,
        );

  /// Factory constructor to map Firestore data to `User`
  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      email: data['email'] as String,
      id: data['id'] as String,
      userName: data['userName'] as String?,
      phone: data['phone'] as String?,
      profilePic: data['profilePic'] as String?,
    );
  }

  /// Converts a `User` object to Firestore-compatible data
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'id': id,
      'userName': userName,
      'phone': phone,
      'profilePic': profilePic,
    };
  }
}
