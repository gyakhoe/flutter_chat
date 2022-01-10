import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeContact()) {
    on<HomeContactTapped>(_onContactTapped);
    on<HomeChatTapped>(_onChatTapped);
    on<HomeProfileTapped>(_onProfileTapped);
  }

  FutureOr<void> _onContactTapped(
    HomeContactTapped event,
    Emitter<HomeState> emit,
  ) {
    emit(HomeContact());
  }

  FutureOr<void> _onChatTapped(
    HomeChatTapped event,
    Emitter<HomeState> emit,
  ) {
    emit(HomeChat());
  }

  FutureOr<void> _onProfileTapped(
    HomeProfileTapped event,
    Emitter<HomeState> emit,
  ) {
    emit(HomeProfile());
  }
}
