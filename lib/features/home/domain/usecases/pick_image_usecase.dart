import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/home/domain/repoIm/home_repoim.dart';
import 'package:dartz/dartz.dart';

class PickImageUsecase {
  final HomeRepoImpl homeRepoImpl;

  PickImageUsecase({required this.homeRepoImpl});

  Future<Either<Failure,void>> call() async {
   return await homeRepoImpl.pickimage();
  }
}
