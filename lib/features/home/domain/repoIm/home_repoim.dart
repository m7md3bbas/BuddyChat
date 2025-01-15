import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/auth/data/datasource/firebase_firestore_datasource.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:TaklyAPP/features/home/data/datasource/home_datasource.dart';
import 'package:TaklyAPP/features/home/data/model/home_model.dart';
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
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
