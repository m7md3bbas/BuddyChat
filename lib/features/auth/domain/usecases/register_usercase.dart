import 'package:TaklyAPP/features/auth/data/datasource/auth_datasource.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:TaklyAPP/features/auth/domain/repoIm/repo_im.dart';
import 'package:dartz/dartz.dart';

class RegisterUsecase {
  final AuthRepoIm authRepoIm;

  RegisterUsecase({required this.authRepoIm});

  Future<Either<AuthExecption, UserEntity?>> call({
    required String email,
    required String password,
    required String name,
  }) async {
    return await authRepoIm.register(
      name: name,
      email: email,
      password: password,
    );
  }
}
