import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:TaklyAPP/features/home/domain/repoIm/home_repoim.dart';
import 'package:dartz/dartz.dart';

class GetCurrentUser {
  final HomeRepoImpl homeRepoImpl;

  GetCurrentUser({required this.homeRepoImpl});
  Future<Either<Failure, UserEntity>> call() async {
    return await homeRepoImpl.getCurrentUser();
  }
}
