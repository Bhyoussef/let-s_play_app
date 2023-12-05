part of 'history_booking_cubit.dart';

@immutable
class HistoryBookingState extends Equatable {
  final List<BookingModel>? completedMatches;
  final MainStatus? mainStatus;

  factory HistoryBookingState.initial() {
    return const HistoryBookingState(
      completedMatches: [],
      mainStatus: MainStatus.initial,
    );
  }

  const HistoryBookingState({this.completedMatches, this.mainStatus});

  HistoryBookingState copyWith({
    MainStatus? mainStatus,
    List<BookingModel>? pendingMatches,
  }) {
    return HistoryBookingState(
      completedMatches: pendingMatches ?? completedMatches,
      mainStatus: mainStatus ?? this.mainStatus,
    );
  }

  @override
  List<Object?> get props => [completedMatches, mainStatus];
}

