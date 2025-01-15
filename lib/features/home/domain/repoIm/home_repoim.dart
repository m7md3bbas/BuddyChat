import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/auth/data/datasource/firebase_firestore_datasource.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:TaklyAPP/features/home/data/datasource/home_datasource.dart';
import 'package:TaklyAPP/features/home/data/repo/repo.dart';
import 'package:dartz/dartz.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeDataSource dataSource;
  final FirebaseFirestoreAuthDatasource firebaseFirestoreDataSource;

  HomeRepoImpl(
      {required this.firebaseFirestoreDataSource, required this.dataSource});

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      return Right(await firebaseFirestoreDataSource.getCurrentUser());
    } on Failure catch (e) {
      return Left(GeneralFailure(e.message));
    }
  }

  Future<Either<Failure, void>> pickimage() async {
    try {
      return Right(await dataSource.pickImage());
    } on Failure catch (e) {
      return Left(GeneralFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> addContact(
      {required UserEntity contactUser}) async {
    try {
      return Right(await dataSource.addContact(contactUser: contactUser));
    } on Failure catch (e) {
      return Left(GeneralFailure(e.message));
    }
  }

  @override
  Stream<List<UserEntity>> getUsers() {
    return dataSource.getUsers();
  }

  @override
  Future<Either<Failure, void>> removeContact({required String email}) async {
    try {
      return Right(await dataSource.removeContact(email));
    } on Failure catch (e) {
      return Left(GeneralFailure(e.message));
    }
  }
}
