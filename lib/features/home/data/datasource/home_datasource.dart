import 'dart:convert';

import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/auth/data/model/user.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeDataSource {
  static HomeDataSource? _instance;
  HomeDataSource._();

  static HomeDataSource getInstance() {
    _instance ??= HomeDataSource._();
    return _instance!;
  }

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ImagePicker imagePicker = ImagePicker();

  Stream<List<UserEntity>> getUsers() {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      return const Stream.empty();
    }
    try {
      return _firebaseFirestore
          .collection("users")
          .doc(currentUser.email)
          .collection("Contacts")
          .orderBy('addedAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Users.fromFirestore(doc.data()))
              .toList());
    } on Failure catch (e) {
      throw GeneralFailure(e.message);
    }
  }

  Future<UserEntity?> getUidByEmail({required String email}) async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final user = querySnapshot.docs.first.data();
        return Users.fromFirestore(user);
      } else {
        return null;
      }
    } on Failure catch (e) {
      return throw GeneralFailure(e.message);
    }
  }

  Future<void> addContact({required UserEntity contactUser}) async {
    final currentUser = _firebaseAuth.currentUser;
    final userFound = await getUidByEmail(email: contactUser.email!);
    try {
      await _firebaseFirestore
          .collection("users")
          .doc(currentUser!.email)
          .collection("Contacts")
          .doc(userFound!.email)
          .set(Users.toFirestore(contactUser));
    } on Failure catch (e) {
      throw GeneralFailure(e.message);
    }
  }

  Future<void> removeContact(String email) async {
    final currentUser = _firebaseAuth.currentUser;
    try {
      await _firebaseFirestore
          .collection("users")
          .doc(currentUser!.email)
          .collection("Contacts")
          .doc(email)
          .delete();
    } on Failure catch (e) {
      throw GeneralFailure(e.message);
    }
  }

  Future<void> saveImage({required String image}) async {
    final currentUser = _firebaseAuth.currentUser;
    try {
      await _firebaseFirestore
          .collection("users")
          .doc(currentUser!.email)
          .set(Users.toFirestore(UserEntity(profilePic: image)));
    } on GeneralFailure catch (e) {
      throw GeneralFailure(e.message);
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFile = await imagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
          maxWidth: 800,
          maxHeight: 800);

      if (pickedFile == null) {
        throw GeneralFailure("No image selected");
      }
      final bytes = await pickedFile.readAsBytes();
      final String base64Image = base64Encode(bytes);
      await saveImage(image: base64Image);
    } on GeneralFailure catch (e) {
      throw GeneralFailure("Failed to pick image");
    }
  }
}
