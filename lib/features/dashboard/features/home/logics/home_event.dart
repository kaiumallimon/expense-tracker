import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeReloadRequested extends HomeEvent {
  final String uid;

  const HomeReloadRequested({required this.uid});

  @override
  List<Object> get props => [uid];
}

class HomeInitialEvent extends HomeEvent {
  const HomeInitialEvent({
    required this.uid,
  });

  final String uid;

  @override
  List<Object> get props => [];
}