import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:TaklyAPP/features/auth/domain/repoIm/repo_im.dart';
import 'package:dartz/dartz.dart';

class LoginUsecase {
  final AuthRepoIm authRepoIm;

  LoginUsecase({required this.authRepoIm});

  Future<Either<Failure, UserEntity?>> call(
      {required String email, required String password}) async {
    return await authRepoIm.login(email: email, password: password);
  }
}
