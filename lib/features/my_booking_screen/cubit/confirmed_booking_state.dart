part of 'confirmed_booking_cubit.dart';

@immutable
class ConfirmedBookingState extends Equatable {
  final List<BookingModel>? confirmedMatches;
  final MainStatus? mainStatus;

  factory ConfirmedBookingState.initial() {
    return const ConfirmedBookingState(
      confirmedMatches: [],
      mainStatus: MainStatus.initial,
    );
  }

  const ConfirmedBookingState({this.confirmedMatches, this.mainStatus});

  ConfirmedBookingState copyWith({
    MainStatus? mainStatus,
    List<BookingModel>? pendingMatches,
  }) {
    return ConfirmedBookingState(
      confirmedMatches: pendingMatches ?? confirmedMatches,
      mainStatus: mainStatus ?? this.mainStatus,
    );
  }

  @override
  List<Object?> get props => [confirmedMatches, mainStatus];
}

