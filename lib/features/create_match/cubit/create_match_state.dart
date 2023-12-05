part of 'create_match_cubit.dart';

abstract class CreateMatchState extends Equatable {
  const CreateMatchState();
}

class CreateMatchInitial extends CreateMatchState {
  @override
  List<Object> get props => [];
}

class SuccessGetMatchDates extends CreateMatchState {
  final SettingsModel settings;
  const SuccessGetMatchDates(this.settings);

  @override
  List<Object> get props => [settings];
}

class SuccessAvailabilityCheck extends CreateMatchState {
  final bool isAvailable;
  const SuccessAvailabilityCheck(this.isAvailable);

  @override
  List<Object> get props => [isAvailable];
}

class ErrorState extends CreateMatchState {
  const ErrorState(this.error);
  final String error;
  @override
  List<Object> get props => [error];
}
