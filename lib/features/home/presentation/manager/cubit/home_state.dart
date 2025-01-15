import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:TaklyAPP/features/home/data/model/home_model.dart';

enum HomeStatus { initial, loading, loaded, error }

extension HomeStateX on HomeStatus {
  bool get isInitial => this == HomeStatus.initial;
  bool get isLoading => this == HomeStatus.loading;
  bool get isLoaded => this == HomeStatus.loaded;
  bool get isError => this == HomeStatus.error;
}

class HomeState {
  final List<ContactModel>? contacts;
  final UserEntity? user;
  final HomeStatus status;
  final Failure? failure;

  HomeState({this.user, this.failure, this.contacts, required this.status});

  HomeState copyWith(
      {UserEntity? user,
      Failure? failure,
      List<ContactModel>? contacts,
      HomeStatus? status}) {
    return HomeState(
      user: user ?? this.user,
      failure: failure ?? this.failure,
      contacts: contacts ?? this.contacts,
      status: status ?? this.status,
    );
  }

  @override
  String toString() =>
      'HomeState(contact: $contacts, status: $status, failure: $failure, user: $user)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeState &&
        other.contacts == contacts &&
        other.status == status &&
        other.failure == failure &&
        other.user == user;
  }

  @override
  int get hashCode => contacts.hashCode ^ status.hashCode ^ failure.hashCode ^ user.hashCode;
}
