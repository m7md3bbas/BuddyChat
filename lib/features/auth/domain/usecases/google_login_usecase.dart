import 'package:TaklyAPP/features/auth/data/datasource/auth_datasource.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:TaklyAPP/features/auth/domain/repoIm/repo_im.dart';
import 'package:dartz/dartz.dart';

class GoogleLoginUsecase {
  final AuthRepoIm authRepoIm;

  GoogleLoginUsecase({required this.authRepoIm});
  Future<Either<AuthExecption, UserEntity?>> call() async {
    return await authRepoIm.googleSignIn();
  }
}
