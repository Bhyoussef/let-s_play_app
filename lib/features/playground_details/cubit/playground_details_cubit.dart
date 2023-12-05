import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:lets_play/models/enums/public_private_type.dart';
import 'package:lets_play/models/server/playground_model.dart';
import 'package:meta/meta.dart';

import '../../../data/core/errors/failures.dart';
import 'package:lets_play/data/services/playground.dart' as playgroundService;

import '../../profile/cubit/user_cubit.dart';

part 'playground_details_state.dart';

class PlaygroundDetailsCubit extends Cubit<PlaygroundDetailsState> {
  PlaygroundDetailsCubit(this.userCubit) : super(PlaygroundDetailInitial());
  final UserCubit userCubit;

  Future getPlaygroundDetails(
      {required int playgroundId,
      required PublicPrivateType playgroundType}) async {
    final Either<Failure, PlaygroundModel> response =
        await playgroundService.playgroundDetails(
      playgroundId: playgroundId,
      type: playgroundType.toString(),
      latitude: userCubit.state.userPosition!.latitude,
      longitude: userCubit.state.userPosition!.longitude,
    );

    print(response);

    emit(response.fold(
        (Failure failure) => ErrorState(mapFailureToMessage(failure)),
        (PlaygroundModel playground) =>
            PlaygroundDetailLoaded(playground: playground)));
  }

  Future setFavorite({required int playgroundId, required bool isFav}) async {
    await playgroundService.setFavourite(
        playgroundId: playgroundId, isFaved: isFav);
    userCubit.getUserFavPlaygrounds();
  }
}
