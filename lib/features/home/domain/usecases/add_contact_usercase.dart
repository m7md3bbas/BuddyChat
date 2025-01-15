import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:TaklyAPP/features/home/domain/repoIm/home_repoim.dart';
import 'package:dartz/dartz.dart';

class AddContactUsercase {
  final HomeRepoImpl homeRepoIm;

  AddContactUsercase({required this.homeRepoIm});

  Future<Either<Failure, void>> call({required UserEntity contactUser}) async {
    return await homeRepoIm.addContact(contactUser: contactUser);
  }
}
