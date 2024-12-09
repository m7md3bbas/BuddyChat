class UserEntity {
  final String email;
  final String id;
  final String? userName;
  final String? phone;
  final String? profilePic;

  UserEntity(
      {this.userName,
      this.phone,
      this.profilePic,
      required this.email,
      required this.id});
}
