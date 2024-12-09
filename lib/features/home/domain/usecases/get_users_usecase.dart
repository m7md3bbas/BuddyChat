

import 'package:TaklyAPP/features/home/data/model/home_model.dart';
import 'package:TaklyAPP/features/home/domain/repoIm/home_repoim.dart';

class GetUsersUsecase {
  final HomeRepoImpl homeRepoImpl;

  GetUsersUsecase(this.homeRepoImpl);

  Stream<List<ContactModel>> call() => homeRepoImpl.getContacts();
}
