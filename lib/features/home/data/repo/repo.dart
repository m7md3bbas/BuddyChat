import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/home/data/model/home_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Stream<List<ContactModel>> getContacts();
  Future<Either<Failure, void>> addContact(String name, String email);
  Future<Either<Failure, void>> deleteContact(String email);
  Future<Either<Failure, ContactModel>> getname({required String email});
  Future<Either<Failure, ContactModel>> saveImage({required String image});
  Future<Either<Failure, ContactModel>> getImage({required String email});
  Future<Either<Failure, ContactModel>> pickImage();
}
