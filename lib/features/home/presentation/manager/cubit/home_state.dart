part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<ContactModel>? contacts;
  final ContactModel? contact;
  HomeLoaded(this.contacts, {required this.contact});
}

final class HomeError extends HomeState {
  final Failure failure;
  HomeError({required this.failure});
}

class HomeImagePicked extends HomeState {
  final ContactModel? contact;

  HomeImagePicked({required this.contact});
}
