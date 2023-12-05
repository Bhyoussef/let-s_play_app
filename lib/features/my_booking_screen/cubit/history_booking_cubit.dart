import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:lets_play/data/services/booking.dart' as bookingService;
import '../../../data/core/errors/failures.dart';
import '../../../models/mainStatus.dart';
import '../models/booking_model.dart';

part 'history_booking_state.dart';

class HistoryBookingCubit extends Cubit<HistoryBookingState> {
  HistoryBookingCubit() : super(HistoryBookingState.initial());

  Future getBooking(String type) async {
    final Either<Failure, List<BookingModel>> response = await bookingService.getBooking(type: type);

    emit(response.fold(
            (Failure failure) => state.copyWith(mainStatus: MainStatus.failure),
            (List<BookingModel> completedMatches) => state.copyWith(
            pendingMatches: completedMatches,
            mainStatus: MainStatus.loaded)));
  }
}
