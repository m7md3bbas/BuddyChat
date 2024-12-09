import 'package:TaklyAPP/features/auth/domain/repoIm/repo_im.dart';

class LogoutUsecase {
  final RepoIm repoIm;
  LogoutUsecase(this.repoIm);
  Future<void> call() async {
    await repoIm.logout();
  }
}
