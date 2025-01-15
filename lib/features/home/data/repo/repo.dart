import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure, UserEntity>> getCurrentUser();
  Future<Either<Failure, void>> addContact({required UserEntity contactUser});
  Future<Either<Failure, void>> removeContact({required String email});
  Stream<List<UserEntity>> getUsers();
  Future<Either<Failure, void>> pickimage();
}
