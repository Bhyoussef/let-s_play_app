import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_play/data/services/createMatch.dart' as createMatchService;

import '../../../data/core/errors/failures.dart';
import '../models/DurationModel.dart';

part 'create_match_state.dart';

class CreateMatchCubit extends Cubit<CreateMatchState> {
  CreateMatchCubit() : super(CreateMatchInitial());

  getMatchesSettings({required int sportId}) async {
    emit(CreateMatchInitial());

    try {
      final Either<Failure, SettingsModel> response =
          await createMatchService.getCreateMatchSettings(sportId: sportId);

      emit(response.fold((Failure failure) => ErrorState(mapFailureToMessage(failure)),
          (SettingsModel settings) => SuccessGetMatchDates(settings)));
    } catch (e) {
      emit(ErrorState(mapFailureToMessage(ServerFailure())));
    }
  }

  checkCreateMatchPgAvailability({
    required int playgroundId,
    required int durationId,
    required String dateTime,
  }) async {
    emit(CreateMatchInitial());

    try {
      final Either<Failure, bool> response =
          await createMatchService.checkCreateMatchPgAvailability(
              playgroundId: playgroundId, durationId: durationId, dateTime: dateTime);

      emit(response.fold((Failure failure) => ErrorState(mapFailureToMessage(failure)),
          (bool isAvailable) => SuccessAvailabilityCheck(isAvailable)));
    } catch (e) {
      emit(ErrorState(mapFailureToMessage(ServerFailure())));
    }
  }
}
