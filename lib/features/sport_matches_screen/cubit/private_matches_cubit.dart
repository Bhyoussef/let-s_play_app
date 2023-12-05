import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:lets_play/features/profile/cubit/user_cubit.dart';

import '../../../data/core/errors/failures.dart';
import '../../../models/mainStatus.dart';
import '../../../models/server/playground_model.dart';
import 'package:lets_play/data/services/playground.dart' as playgroundService;

part 'private_matches_state.dart';

class PrivateMatchesCubit extends Cubit<PrivateMatchesState> {
  PrivateMatchesCubit(this.userCubit) : super(PrivateMatchesState.initial());
  final UserCubit userCubit;

  Future getMatches(int categoryId) async {
    final Either<Failure, List<PlaygroundModel>> response =
        await playgroundService.listPlaygrounds(
      type: 'private',
      categoryId: categoryId,
      latitude: userCubit.state.userPosition!.latitude,
      longitude: userCubit.state.userPosition!.longitude,
    );

    emit(response.fold(
        (Failure failure) => state.copyWith(mainStatus: MainStatus.failure),
        (List<PlaygroundModel> listPlaygrounds) => state.copyWith(
            privatePlaygrounds: listPlaygrounds,
            mainStatus: MainStatus.loaded)));
  }
}
