// ignore_for_file: overridden_fields, annotate_overrides

import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users extends UserEntity {
  final String email;
  final String id;
  final String? userName;
  final String? phone;
  final String? profilePic;

  Users({
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

  factory Users.fromFirebase(User user) {
    return Users(
      email: user.email!,
      id: user.uid,
      userName: user.displayName,
      phone: user.phoneNumber,
      profilePic: user.photoURL,
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
