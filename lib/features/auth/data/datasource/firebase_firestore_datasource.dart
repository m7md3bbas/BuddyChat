import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreDatasource {
  static final FirebaseFirestoreDatasource? _instance;
  FirebaseFirestoreDatasource._();
  static FirebaseFirestoreDatasource get instance {
    _instance ?? FirebaseFirestoreDatasource._();
    return _instance!;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(
      {required String name,
      required String email,
      required String phone}) async {
    await _firestore
        .collection('users')
        .doc(email)
        .set({'name': name, 'email': email, 'phone': phone});
  }
  
}
