import 'package:equatable/equatable.dart';

abstract class CalenderViewState extends Equatable{
  const CalenderViewState();

  @override
  List<Object> get props => [];
}

class CalenderViewInitial extends CalenderViewState{}

class CalenderViewLoading extends CalenderViewState{}

class CalenderViewLoaded extends CalenderViewState{
  final Map<String, List<Map<String, dynamic>>> data;

  const CalenderViewLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class CalenderViewError extends CalenderViewState{
  final String message;

  const CalenderViewError(this.message);

  @override
  List<Object> get props => [message];
}