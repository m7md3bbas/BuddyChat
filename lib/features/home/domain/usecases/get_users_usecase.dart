import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:TaklyAPP/features/home/domain/repoIm/home_repoim.dart';

class GetUsersUsecase {
  final HomeRepoImpl homeRepoImpl;

  GetUsersUsecase({required this.homeRepoImpl});
  Stream<List<UserEntity>> call() {
    return homeRepoImpl.getUsers();
  }
}
