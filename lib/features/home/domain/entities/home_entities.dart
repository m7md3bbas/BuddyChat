class Contact {
  final String? name;
  final String?email;
  final String? uid;
  final String? imageUrl;
  final DateTime? addedAt;

  Contact(this.imageUrl, {
    required this.name,
    required this.email,
    required this.uid,
    this.addedAt,
  });
}
