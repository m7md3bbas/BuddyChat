class UserEntity {
  final String email;
  final String id;
  final String? name;
  final String? phone;
  final String? profilePic;

  UserEntity(
      {this.name,
      this.phone,
      this.profilePic,
      required this.email,
      required this.id});
}
