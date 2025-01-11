import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/home/data/datasource/home_datasource.dart';
import 'package:TaklyAPP/features/home/data/model/home_model.dart';
import 'package:TaklyAPP/features/home/data/repo/repo.dart';
import 'package:dartz/dartz.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeDataSource dataSource;

  HomeRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, void>> addContact(String name, String email) async {
    try {
      await dataSource.addContact(email: email, name: name);
      return const Right(
          null); // Return `null` since the operation has no specific return value.
    } catch (e) {
      // Log error for debugging purposes.
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteContact(String email) async {
    try {
      await dataSource.removeContact(email);
      return const Right(null);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Stream<List<ContactModel>> getContacts() {
    return dataSource.getUsers();
  }

  @override
  Future<Either<Failure, ContactModel>> getname({required String email}) async {
    try {
      return Right(await dataSource.getname(email: email));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ContactModel>> getImage(
      {required String email}) async {
    try {
      return Right(await dataSource.getImage(email: email));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ContactModel>> saveImage(
      {required String image}) async {
    try {
      return Right(await dataSource.saveImage(image: image));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ContactModel>> pickImage() async {
    try {
      final imagePath = await dataSource.pickImage();
      return Right(ContactModel(photoUrl: imagePath.imageUrl));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
