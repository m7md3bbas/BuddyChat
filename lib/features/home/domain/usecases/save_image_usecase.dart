

import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/home/domain/repoIm/home_repoim.dart';
import 'package:dartz/dartz.dart';

class SaveImageUsecase {
  final HomeRepoImpl homeRepoImpl;

  SaveImageUsecase(this.homeRepoImpl);

  Future<Either<Failure, void>> call({required String? image}) async =>
      await homeRepoImpl.saveImage(image: image!);
}
