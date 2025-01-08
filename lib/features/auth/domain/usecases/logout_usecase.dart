import 'package:TaklyAPP/features/auth/domain/repoIm/repo_im.dart';

class LogoutUsecase {
  final AuthRepoIm authRepoIm;
  LogoutUsecase({required this.authRepoIm});
  Future<void> call() async {
    await authRepoIm.logout();
  }
}
