// ignore_for_file: overridden_fields, annotate_overrides

import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users extends UserEntity {
  final String email;
  final String id;
  final String? name;
  final String? phone;
  final String? profilePic;

  Users({
    required this.email,
    required this.id,
    this.name,
    this.phone,
    this.profilePic,
  }) : super(
          email: email,
          id: id,
          name: name,
          phone: phone,
          profilePic: profilePic,
        );

  factory Users.fromFirebaseAuth(User user) {
    return Users(
      email: user.email!,
      id: user.uid,
    );
  }
  static Map<String, dynamic> toFirestore(UserEntity user) {
    return {
      'email': user.email,
      'id': user.id,
      'name': user.name,
      'phone': user.phone,
      'profilePic': user.profilePic,
    };
  }

  static Users fromFirestore(Map<String, dynamic> firestore) {
    return Users(
      email: firestore['email'],
      id: firestore['id'],
      name: firestore['name'],
      phone: firestore['phone'],
      profilePic: firestore['profilePic'],
    );
  }
}
