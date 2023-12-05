import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_play/data/core/errors/failures.dart';
import 'package:lets_play/features/home_screen/public_matches_show_all/models/matchesResultModel.dart';
import 'package:lets_play/features/profile/cubit/user_cubit.dart';
import 'package:lets_play/models/mainStatus.dart';
import 'package:lets_play/models/server/match_model.dart';
import 'package:lets_play/data/services/match.dart' as matchService;

part 'all_available_public_matches_state.dart';

class AllAvailablePublicMatchesCubit
    extends Cubit<AllAvailablePublicMatchesState> {
  AllAvailablePublicMatchesCubit(this.userCubit)
      : super(AllAvailablePublicMatchesState.initial());
  final UserCubit userCubit;

  Future<void> getAvailablePublicMatches() async {
    if (state.hasReachedMax!) return;
    if (state.mainStatus == MainStatus.initial) {
      final Either<Failure, MatchResultModel> eitherResponse =
          await matchService.fetchAvailablePublicMatches(
        latitude: userCubit.state.userPosition!.latitude,
        longitude: userCubit.state.userPosition!.longitude,
      );
      return emit(eitherResponse.fold(
          (l) => state.copyWith(
                mainStatus: MainStatus.failure,
                matches: [],
              ),
          (r) => state.copyWith(
                mainStatus: MainStatus.loaded,
                matches: r.matchesList,
                hasReachedMax: r.next == null,
              )));
    }
    emit(state.copyWith(mainStatus: MainStatus.loading));
    final Either<Failure, MatchResultModel> eitherResponse =
        await matchService.fetchAvailablePublicMatches(
      page: state.currentPage! + 1,
      latitude: userCubit.state.userPosition!.latitude,
      longitude: userCubit.state.userPosition!.longitude,
    );

    return eitherResponse.fold(
        (l) => state.copyWith(
              mainStatus: MainStatus.failure,
              matches: [],
            ), (r) {
      emit(state.copyWith(
        mainStatus: MainStatus.loaded,
        matches: List.of(state.matches!)..addAll(r.matchesList!),
        hasReachedMax: r.next == null,
        currentPage: state.currentPage! + 1,
      ));
    });
  }
}
