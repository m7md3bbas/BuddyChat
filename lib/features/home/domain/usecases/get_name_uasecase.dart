
import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/home/data/model/home_model.dart';
import 'package:TaklyAPP/features/home/domain/repoIm/home_repoim.dart';
import 'package:dartz/dartz.dart';

class GetNameUasecase {
  final HomeRepoImpl homeRepoImpl;

  GetNameUasecase(this.homeRepoImpl);

  Future<Either<Failure, ContactModel>> call({required String email}) async =>
      await homeRepoImpl.getname(email: email);
}
