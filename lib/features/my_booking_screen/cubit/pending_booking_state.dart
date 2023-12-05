part of 'pending_booking_cubit.dart';

class PendingBookingState extends Equatable {
  final List<BookingModel>? pendingMatches;
  final MainStatus? mainStatus;

  factory PendingBookingState.initial() {
    return const PendingBookingState(
      pendingMatches: [],
      mainStatus: MainStatus.initial,
    );
  }

  const PendingBookingState({this.pendingMatches, this.mainStatus});

  PendingBookingState copyWith({
    MainStatus? mainStatus,
    List<BookingModel>? pendingMatches,
  }) {
    return PendingBookingState(
      pendingMatches: pendingMatches ?? this.pendingMatches,
      mainStatus: mainStatus ?? this.mainStatus,
    );
  }

  @override
  List<Object?> get props => [pendingMatches, mainStatus];

}


