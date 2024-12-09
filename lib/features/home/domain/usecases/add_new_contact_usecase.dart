
import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/home/domain/repoIm/home_repoim.dart';
import 'package:dartz/dartz.dart';

class AddNewContactUsecase {
  final HomeRepoImpl? homeRepoImpl;

  AddNewContactUsecase(this.homeRepoImpl);

  Future<Either<Failure, void>> call(String name, String email) =>
      homeRepoImpl!.addContact(name, email);
}
