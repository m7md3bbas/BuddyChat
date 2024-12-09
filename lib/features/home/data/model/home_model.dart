import 'package:TaklyAPP/features/home/domain/entities/home_entities.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

class ContactModel extends Contact {
  ContactModel({
    String? name,
    String? email,
    String? uid,
    String? photoUrl,
    DateTime? addedAt,
  }) : super(photoUrl, name: name, email: email, uid: uid, addedAt: addedAt);

  factory ContactModel.fromFirestore(Map<String, dynamic> data) {
    return ContactModel(
      name: data['name'] as String? ?? 'Unknown', // Default to 'Unknown' if null
      email: data['email'] as String? ?? 'No Email', // Default to 'No Email' if null
      uid: data['uid'] as String? ?? 'No UID', // Default to 'No UID' if null
      photoUrl: data['photoUrl'] as String?, // Optional field
      addedAt: (data['addedAt'] as Timestamp?)?.toDate(), // Handle null safely
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'addedAt': addedAt,
    };
  }
}
