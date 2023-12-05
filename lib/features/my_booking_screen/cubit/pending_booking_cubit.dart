import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_play/features/my_booking_screen/models/booking_model.dart';
import '../../../data/core/errors/failures.dart';
import '../../../models/mainStatus.dart';
import 'package:lets_play/data/services/booking.dart' as bookingService;

part 'pending_booking_state.dart';

class PendingBookingCubit extends Cubit<PendingBookingState> {
  PendingBookingCubit() : super(PendingBookingState.initial());

  Future getBooking(String type) async {
    final Either<Failure, List<BookingModel>> response = await bookingService.getBooking(type: type);

    emit(response.fold(
            (Failure failure) => state.copyWith(mainStatus: MainStatus.failure),
            (List<BookingModel> pendingMatches) => state.copyWith(
            pendingMatches: pendingMatches,
            mainStatus: MainStatus.loaded)));
  }

}
