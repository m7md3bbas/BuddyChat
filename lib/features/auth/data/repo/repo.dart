
import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class Repo {
  Future<Either<Failure, UserEntity?>> login({required String email,required String password});
  Future<Either<Failure, UserEntity?>> register({required String email,required String password ,required String name});
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> forgetPassword({required String email});
  Stream <UserEntity?> get authStateChange;
}
