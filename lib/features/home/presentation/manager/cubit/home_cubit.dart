import 'dart:async';

import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/home/data/model/home_model.dart';
import 'package:TaklyAPP/features/home/domain/usecases/add_new_contact_usecase.dart';
import 'package:TaklyAPP/features/home/domain/usecases/delete_contact_usecase.dart';
import 'package:TaklyAPP/features/home/domain/usecases/get_image_usecase.dart';
import 'package:TaklyAPP/features/home/domain/usecases/get_name_uasecase.dart';
import 'package:TaklyAPP/features/home/domain/usecases/get_users_usecase.dart';
import 'package:TaklyAPP/features/home/domain/usecases/pick_image_usecase.dart';
import 'package:TaklyAPP/features/home/domain/usecases/save_image_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AddNewContactUsecase addNewContactUsecase;
  final GetUsersUsecase getUsersUsecase;
  final DeleteContactUsecase deleteContactUsecase;
  final GetNameUasecase getNameUasecase;
  final SaveImageUsecase saveImageUsecase;
  final GetImageUsecase getImageUsecase;
  final PickImageUseCase pickImageUsecase;

  StreamSubscription? _subscription;

  HomeCubit(
      this.addNewContactUsecase,
      this.deleteContactUsecase,
      this.getUsersUsecase,
      this.getNameUasecase,
      this.saveImageUsecase,
      this.getImageUsecase,
      this.pickImageUsecase)
      : super(HomeInitial());

  void getUsers() async {
    emit(HomeLoading());
    _subscription = getUsersUsecase().listen((event) {
      if (!isClosed) emit(HomeLoaded(contact: null, event));
    });
  }

  void addContact(String name, String email) async {
    emit(HomeLoading());
    final result = await addNewContactUsecase(name, email);
    if (isClosed) return;

    result.fold(
      (failure) => emit(HomeError(failure: failure)),
      (contact) => emit(
        HomeLoaded(contact: ContactModel(name: name, email: email), null),
      ),
    );
  }

  void deleteContact(String email) async {
    emit(HomeLoading());
    final result = await deleteContactUsecase(email);
    if (isClosed) return;

    result.fold(
      (failure) => emit(HomeError(failure: failure)),
      (_) => emit(HomeLoaded(contact: null, null)),
    );
  }

  void getname({required String email}) async {
    emit(HomeLoading());
    final result = await getNameUasecase.call(email: email);
    if (isClosed) return;

    result.fold(
      (failure) => emit(HomeError(failure: failure)),
      (name) => emit(
        HomeLoaded(
          contact: ContactModel(name: name.name, email: email),
          null,
        ),
      ),
    );
  }

  void saveImage({required String? image}) async {
    emit(HomeLoading());
    final result = await saveImageUsecase.call(image: image!);
    if (isClosed) return;

    result.fold(
      (failure) => emit(HomeError(failure: failure)),
      (_) => emit(
        HomeLoaded(contact: ContactModel(photoUrl: image), null),
      ),
    );
  }

  void getImage({required String email}) async {
    emit(HomeLoading());
    final result = await getImageUsecase.call(email: email);
    if (isClosed) return;

    result.fold(
      (failure) => emit(HomeError(failure: failure)),
      (image) => emit(
        HomeLoaded(contact: ContactModel(photoUrl: image.imageUrl), null),
      ),
    );
  }

  void pickImage() async {
    emit(HomeLoading());

    final result = await pickImageUsecase.call();
    if (isClosed) return;

    result.fold(
      (failure) => emit(HomeError(failure: failure)),
      (image) => emit(
        HomeImagePicked(
          contact: ContactModel(photoUrl: image.imageUrl),
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
