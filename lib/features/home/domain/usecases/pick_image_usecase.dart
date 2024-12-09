

import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/home/data/model/home_model.dart';
import 'package:TaklyAPP/features/home/domain/repoIm/home_repoim.dart';
import 'package:dartz/dartz.dart';

class PickImageUseCase {
  final HomeRepoImpl homeRepoImpl;
  PickImageUseCase(this.homeRepoImpl);

  Future<Either<Failure, ContactModel>> call() async {
    return await homeRepoImpl.pickImage();
  }
}
