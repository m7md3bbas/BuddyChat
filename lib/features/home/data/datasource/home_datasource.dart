import 'dart:convert';

import 'package:TaklyAPP/features/home/data/model/home_model.dart';
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

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final ImagePicker imagePicker = ImagePicker();

  Stream<List<ContactModel>> getUsers() {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      return const Stream.empty();
    }
    try {
      return firebaseFirestore
          .collection("users")
          .doc(currentUser.uid)
          .collection("Contacts")
          .orderBy('addedAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ContactModel.fromFirestore(doc.data()))
              .toList());
    } on FirebaseException catch (e) {
      Get.snackbar("Error", e.message ?? "An unknown error occurred");
      return const Stream.empty();
    }
  }

  Future<ContactModel?> getUidByEmail(String? email) async {
    if (email == null || email.isEmpty) {
      Get.snackbar("Error", "Email is required");
      return null;
    }
    try {
      final querySnapshot = await firebaseFirestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data();
        return ContactModel(uid: data['uid']);
      } else {
        Get.snackbar("Error", "User not found");
        return null;
      }
    } on FirebaseException catch (e) {
      Get.snackbar("Error", e.message ?? "An unknown error occurred");
      return null;
    }
  }

  Future<ContactModel> getname({required String email}) async {
    final contact = await getUidByEmail(email);
    final name = await firebaseFirestore
        .collection('users')
        .doc(contact!.uid)
        .get()
        .then((snapshot) => snapshot.data()!['name']);

    return ContactModel(name: name);
  }

  Future<void> addContact({required String email, required String name}) async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      Get.snackbar("Error", "User is not authenticated");
      return;
    }
    if (email == currentUser.email) {
      Get.snackbar("Error", "You cannot add yourself as a contact.");
      return;
    }

    final contact = await getUidByEmail(email);
    final contatName = await getname(email: currentUser.email!);
    if (contact == null || contact.uid == null) {
      Get.snackbar("Error", "Cannot add contact. User not found.");
      return;
    }
    try {
      await firebaseFirestore
          .collection("users")
          .doc(currentUser.uid)
          .collection("Contacts")
          .doc(email)
          .set({
        "name": name,
        "email": email,
        "uid": contact.uid,
        'addedAt': FieldValue.serverTimestamp(),
      });

      await firebaseFirestore
          .collection("users")
          .doc(contact.uid)
          .collection("Contacts")
          .doc(currentUser.email)
          .set({
        "name": contatName.name,
        "email": currentUser.email,
        "uid": currentUser.uid,
        'addedAt': FieldValue.serverTimestamp(),
      });
      Get.snackbar("Success", "Contact added successfully");
    } on FirebaseException catch (e) {
      Get.snackbar("Error", e.message ?? "An unknown error occurred");
    }
  }

  Future<void> removeContact(String email) async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      Get.snackbar("Error", "User is not authenticated");
      return;
    }
    try {
      await firebaseFirestore
          .collection("users")
          .doc(currentUser.uid)
          .collection("Contacts")
          .doc(email)
          .delete();
    } on FirebaseException catch (e) {
      Get.snackbar("Error", e.message ?? "An unknown error occurred");
    }
  }

  Future<ContactModel> getImage({required String email}) async {
    final contact = await getUidByEmail(email);
    final image = await firebaseFirestore
        .collection('users')
        .doc(contact!.uid)
        .get()
        .then((snapshot) => snapshot.data()!['image']);
    return ContactModel(photoUrl: image);
  }

  Future<ContactModel> saveImage({required String image}) async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      Get.snackbar("Error", "User is not authenticated");
      return ContactModel();
    }
    try {
      await firebaseFirestore
          .collection("users")
          .doc(currentUser.uid)
          .update({"image": image});

      return ContactModel(photoUrl: image);
    } on FirebaseException catch (e) {
      Get.snackbar("Error", e.message ?? "An unknown error occurred");
      return ContactModel();
    }
  }

  Future<ContactModel> pickImage() async {
    try {
      final pickedFile = await imagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
          maxWidth: 800,
          maxHeight: 800);
      if (pickedFile == null) {
        return ContactModel();
      }

      final bytes = await pickedFile.readAsBytes();
      final String base64Image = base64Encode(bytes);
      saveImage(image: base64Image);
      return ContactModel(photoUrl: base64Image);
    } catch (e) {
      throw Exception("Failed to pick image: $e");
    }
  }
}
