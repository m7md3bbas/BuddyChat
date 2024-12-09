import 'package:TaklyAPP/features/auth/domain/repoIm/repo_im.dart';

class ForgetPasswordUsecase {
  final RepoIm repoIm;

  ForgetPasswordUsecase(this.repoIm);
  Future<void> call({required String email}) async {
    await repoIm.forgetPassword(email:email);
  }
}
