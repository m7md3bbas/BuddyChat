import 'package:TaklyAPP/features/auth/data/datasource/auth_datasource.dart';
import 'package:TaklyAPP/features/auth/data/model/user.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFirestoreAuthDatasource {
  static FirebaseFirestoreAuthDatasource? _instance;
  FirebaseFirestoreAuthDatasource._();
  static FirebaseFirestoreAuthDatasource getInstance() {
    _instance ??= FirebaseFirestoreAuthDatasource._();
    return _instance!;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createUser({
    required UserEntity userEntity,
  }) async {
    await _firestore.collection('users').doc(userEntity.email).set(
        Users.toFirestore(UserEntity(
            email: userEntity.email,
            name: userEntity.name,
            id: userEntity.id)));
  }

  Future<void> updateCurrentUser({required UserEntity userEntity}) async {
    await _firestore
        .collection('users')
        .doc(userEntity.email)
        .update(Users.toFirestore(UserEntity(
          email: userEntity.email,
          name: userEntity.name,
        )));
  }

  Future<UserEntity> getCurrentUser() async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.email)
          .get();
      final user = doc.data();
      return Users.fromFirestore(user!);
    } on AuthExecption catch (e) {
      throw AuthExecption(e.message);
    }
  }
}
