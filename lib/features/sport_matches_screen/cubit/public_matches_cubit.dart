import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../data/core/errors/failures.dart';
import 'package:lets_play/data/services/playground.dart' as playgroundService;

import '../../../models/mainStatus.dart';
import '../../../models/server/playground_model.dart';
import '../../profile/cubit/user_cubit.dart';

part 'public_matches_state.dart';

class PublicMatchesCubit extends Cubit<PublicMatchesCubitState> {
  PublicMatchesCubit(this.userCubit) : super(PublicMatchesCubitState.initial());
  final UserCubit userCubit;

  Future getMatches(int categoryId) async {
    final Either<Failure, List<PlaygroundModel>> response =
        await playgroundService.listPlaygrounds(
      type: 'public',
      categoryId: categoryId,
      latitude: userCubit.state.userPosition!.latitude,
      longitude: userCubit.state.userPosition!.longitude,
    );

    emit(response.fold(
        (Failure failure) => state.copyWith(mainStatus: MainStatus.failure),
        (List<PlaygroundModel> listPlaygrounds) => state.copyWith(
            publicPlaygrounds: listPlaygrounds,
            mainStatus: MainStatus.loaded)));
  }
}
