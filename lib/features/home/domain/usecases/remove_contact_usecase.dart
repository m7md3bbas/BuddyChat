import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/home/domain/repoIm/home_repoim.dart';
import 'package:dartz/dartz.dart';

class RemoveContactUsecase {
  final HomeRepoImpl homeRepoImpl;

  RemoveContactUsecase({required this.homeRepoImpl});
  Future<Either<Failure, void>> call({required String email}) async {
    return await homeRepoImpl.removeContact(email: email);
  }
}
