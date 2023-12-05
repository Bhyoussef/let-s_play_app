part of 'playground_details_cubit.dart';

@immutable
abstract class PlaygroundDetailsState {}

class PlaygroundDetailInitial extends PlaygroundDetailsState {}

class PlaygroundDetailLoaded extends PlaygroundDetailsState {
  final PlaygroundModel playground;

  PlaygroundDetailLoaded({required this.playground});
}

class ErrorState extends PlaygroundDetailsState {
  ErrorState(this.error);
  final String error;
  @override
  List<Object> get props => [error];
}
