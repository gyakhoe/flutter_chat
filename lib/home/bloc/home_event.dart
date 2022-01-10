part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeContactTapped extends HomeEvent {}

class HomeChatTapped extends HomeEvent {}

class HomeProfileTapped extends HomeEvent {}
