import 'dart:async';

import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:TaklyAPP/features/home/domain/usecases/add_contact_usercase.dart';
import 'package:TaklyAPP/features/home/domain/usecases/get_current_user.dart';
import 'package:TaklyAPP/features/home/domain/usecases/get_users_usecase.dart';
import 'package:TaklyAPP/features/home/domain/usecases/pick_image_usecase.dart';
import 'package:TaklyAPP/features/home/domain/usecases/remove_contact_usecase.dart';
import 'package:TaklyAPP/features/home/presentation/manager/cubit/home_state.dart';
import 'package:bloc/bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCurrentUser getCurrentUser;
  final PickImageUsecase pickImageUsecase;
  final AddContactUsercase addContactUsecase;
  final RemoveContactUsecase removeContactUsecase;
  final GetUsersUsecase getUsersUsecase;
  StreamSubscription? _subscription;

  HomeCubit(
      {required this.addContactUsecase,
      required this.removeContactUsecase,
      required this.getUsersUsecase,
      required this.pickImageUsecase,
      required this.getCurrentUser})
      : super(HomeState(status: HomeStatus.initial));

  Future<void> currentUser() async {
    emit(state.copyWith(status: HomeStatus.loading));
    final result = await getCurrentUser.call();
    result.fold(
      (failure) => emit(state.copyWith(
        status: HomeStatus.error,
        failure: failure,
      )),
      (user) => emit(state.copyWith(
        status: HomeStatus.loaded,
        user: user,
      )),
    );
  }

  Future<void> addContact({required UserEntity contactUser}) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final result = await addContactUsecase.call(contactUser: contactUser);
    result.fold(
      (failure) => emit(state.copyWith(
        status: HomeStatus.error,
        failure: failure,
      )),
      (user) => emit(state.copyWith(
        status: HomeStatus.loaded,
      )),
    );
  }

  Future<void> removeContact({required String email}) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final result = await removeContactUsecase.call(email: email);
    result.fold(
      (failure) => emit(state.copyWith(
        status: HomeStatus.error,
        failure: failure,
      )),
      (user) => emit(state.copyWith(
        status: HomeStatus.loaded,
      )),
    );
  }

 void getUsers() {
    emit(state.copyWith(status: HomeStatus.loading));
    _subscription = getUsersUsecase.call().listen((users) {
      emit(state.copyWith(
        status: HomeStatus.loaded,
        contacts: users,
      ));
    });
  }

  Future<void> pickImage() async {
    emit(state.copyWith(status: HomeStatus.loading));
    final result = await pickImageUsecase.call();
    result.fold(
      (failure) => emit(state.copyWith(
        status: HomeStatus.error,
        failure: failure,
      )),
      (user) => emit(state.copyWith(
        status: HomeStatus.loaded,
      )),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
