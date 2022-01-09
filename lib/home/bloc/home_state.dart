part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeContact extends HomeState {}

class HomeChat extends HomeState {}

class HomeProfile extends HomeState {}
