import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_play/data/services/home.dart' as homeService;
import 'package:lets_play/features/profile/cubit/user_cubit.dart';
import 'package:lets_play/models/server/match_model.dart';
import '../../../data/core/errors/failures.dart';
import '../../../models/sport_category_model.dart';
import '../models/Promo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());
  getHomeDetails(UserCubit userCubit) async {
    final Either<Failure, Map<String, dynamic>> response =
        await homeService.homeDetails(
            latitude: userCubit.state.userPosition!.latitude,
            longitude: userCubit.state.userPosition!.longitude);

    emit(response
        .fold((Failure failure) => ErrorState(mapFailureToMessage(failure)),
            (result) {
      final sportCats = List.from(result['categories'])
          .map((e) => formatSportCategory(e))
          .toList();
      final promos =
          List.from(result['promo']).map((e) => formatHomePromo(e)).toList();
      final availableMatches = List.from(result['available_match'])
          .map((e) => formatMatchModel(e))
          .toList();
      return state.copyWith(
          homeSportCats: sportCats,
          promos: promos,
          availableMatches: availableMatches);
    }));
  }
}
