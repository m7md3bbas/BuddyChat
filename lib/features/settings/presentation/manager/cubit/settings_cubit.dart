import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/settings/domain/usecases/delete_account_usecase.dart';
import 'package:TaklyAPP/features/settings/domain/usecases/get_password.dart';
import 'package:TaklyAPP/features/settings/domain/usecases/update_email.dart';
import 'package:TaklyAPP/features/settings/domain/usecases/update_name_usecase.dart';
import 'package:TaklyAPP/features/settings/domain/usecases/update_password_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final DeleteAccountUsecase deleteAccountUsecase;
  final UpdatePasswordUsecase updatePasswordUsecase;
  final UpdateEmailUsecase updateEmailUsecase;
  final UpdateNameUsecase updateNameUsecase;
  final GetPasswordUsecase getPasswordUsecase;
  SettingsCubit(this.deleteAccountUsecase, this.updatePasswordUsecase,
      this.updateEmailUsecase, this.updateNameUsecase, this.getPasswordUsecase)
      : super(SettingsInitial());

  Future<void> deleteAccount({required String password}) async {
    emit(SettingsLoading());
    if (isClosed) return;
    final result = await deleteAccountUsecase.call(password: password);
    result.fold(
      (l) {
        // Add this
        emit(SettingsFailure(failure: l));
      },
      (r) => emit(SettingsSuccess()),
    );
  }

  Future<void> updatePassword({required String password}) async {
    emit(SettingsLoading());
    if (isClosed) return;
    final result = await updatePasswordUsecase(newPassword: password);
    result.fold((l) => emit(SettingsFailure(failure: l)),
        (r) => emit(SettingsSuccess()));
  }

  Future<void> updateEmail({required String email,required String password}) async {
    emit(SettingsLoading());
    if (isClosed) return;
    final result = await updateEmailUsecase(email: email, password: password);
    result.fold((l) => emit(SettingsFailure(failure: l)),
        (r) => emit(SettingsSuccess()));
  }

  Future<void> updateName({required String name}) async {
    emit(SettingsLoading());
    if (isClosed) return;
    final result = await updateNameUsecase(name: name);
    result.fold((l) => emit(SettingsFailure(failure: l)),
        (r) => emit(SettingsSuccess()));
  }

  Future<void> getPassword() async {
    emit(SettingsLoading());
    if (isClosed) return;
    final result = await getPasswordUsecase.call();
    result.fold((l) => emit(SettingsFailure(failure: l)),
        (r) => emit(SettingGetPassword(password: r)));
  }
}
