import 'package:TaklyAPP/features/auth/data/datasource/auth_datasource.dart';
import 'package:TaklyAPP/features/auth/data/model/user.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreDatasource {
  static FirebaseFirestoreDatasource? _instance;
  FirebaseFirestoreDatasource._();
  static FirebaseFirestoreDatasource getInstance() {
    _instance ??= FirebaseFirestoreDatasource._();
    return _instance!;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser({
    required UserEntity userEntity,
  }) async {
    await _firestore.collection('users').doc(userEntity.email).set(
        Users.toFirestore(Users(
            email: userEntity.email,
            name: userEntity.name,
            id: userEntity.id)));
  }

  Future<UserEntity> getUser({required UserEntity userEntity}) async {
    try {
      final doc =
          await _firestore.collection('users').doc(userEntity.email).get();
      final user = doc.data();
      return Users.fromFirestore(user!);
    } on AuthExecption catch (e) {
      throw AuthExecption(e.message);
    }
  }
}
