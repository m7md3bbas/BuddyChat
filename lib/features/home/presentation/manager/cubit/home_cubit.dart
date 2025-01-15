import 'dart:async';

import 'package:TaklyAPP/features/home/domain/usecases/get_current_user.dart';
import 'package:TaklyAPP/features/home/presentation/manager/cubit/home_state.dart';
import 'package:bloc/bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCurrentUser getCurrentUser;

  StreamSubscription? _subscription;

  HomeCubit({required this.getCurrentUser})
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

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
