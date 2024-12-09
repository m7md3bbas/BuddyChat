import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/home/domain/repoIm/home_repoim.dart';
import 'package:dartz/dartz.dart';

class DeleteContactUsecase {
  final HomeRepoImpl homeRepoImpl;

  DeleteContactUsecase(this.homeRepoImpl);
  Future<Either<Failure, void>> call(String email) async =>
      await homeRepoImpl.deleteContact(email);
}
