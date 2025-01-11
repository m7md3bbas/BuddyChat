import 'package:TaklyAPP/features/auth/domain/repoIm/repo_im.dart';

class GoogleLoginUsecase {
  final AuthRepoIm authRepoIm;

  GoogleLoginUsecase({required this.authRepoIm});
  Future<void> call() async {
    await authRepoIm.googleSignIn();
  }
}
