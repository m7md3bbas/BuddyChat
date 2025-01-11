import 'package:TaklyAPP/features/auth/domain/repoIm/repo_im.dart';

class ResetPasswordUsecase {
  final AuthRepoIm authRepoIm;

  ResetPasswordUsecase({required this.authRepoIm});

  Future<void> call({required String code, required String newPassword}) async {
    await authRepoIm.resetPassword(code: code, newPassword: newPassword);
  }
}
