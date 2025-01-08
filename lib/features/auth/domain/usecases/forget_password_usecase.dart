import 'package:TaklyAPP/features/auth/domain/repoIm/repo_im.dart';

class ForgetPasswordUsecase {
  final AuthRepoIm authRepoIm;

  ForgetPasswordUsecase({required this.authRepoIm});
  Future<void> call({required String email}) async {
    await authRepoIm.forgetPassword(email:email);
  }
}
