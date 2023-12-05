import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lets_play/data/core/errors/failures.dart';
import 'package:lets_play/features/home_search/models/search_entity_type.dart';
import 'package:lets_play/features/profile/cubit/user_cubit.dart';
import 'package:lets_play/models/mainStatus.dart';
import 'package:lets_play/models/server/match_model.dart';
import 'package:lets_play/models/server/playground_model.dart';
import 'package:lets_play/models/sport_category_model.dart';
import 'package:lets_play/data/services/search.dart' as searchService;

part 'home_search_state.dart';

class HomeSearchCubit extends Cubit<HomeSearchState> {
  HomeSearchCubit(this.userCubit) : super(HomeSearchState.initial());
  final TextEditingController searchTermController = TextEditingController();
  final UserCubit userCubit;

  applyFilterPressed() async {
    emit(state.copyWith(
        searchedEntityType: state.selectedEntityType!,
        mainStatus: MainStatus.loading));
    final Either<Failure, Map<String, dynamic>> response =
        await searchService.homeSearch(
      categoriesIds: state.selectedSports!.map((e) => e.id).toList(),
      searchTerm: searchTermController.text,
      type: state.selectedEntityType!,
      latitude: userCubit.state.userPosition!.latitude,
      longitude: userCubit.state.userPosition!.longitude,
    );

    response.fold((l) {
      emit(state.copyWith(mainStatus: MainStatus.failure));
    }, (r) {
      if (state.selectedEntityType == SearchEntityType.playground) {
        emit(state.copyWith(
            matches: [],
            playgrounds: List.from(r['data'])
                .map((e) => PlaygroundModel.fromJson(e))
                .toList()));
      } else {
        emit(state.copyWith(
            playgrounds: [],
            matches:
                List.from(r['data']).map((e) => formatMatchModel(e)).toList()));
      }
      emit(state.copyWith(mainStatus: MainStatus.loaded));
    });
  }

  registerSportCategoriesList(
      {required List<SportCategoryModel> homeSportCats}) {
    emit(state.copyWith(
        sportCategories: homeSportCats, selectedSports: [homeSportCats.first]));
  }

  selectedSportChanged({required SportCategoryModel sportCat}) {
    final List<SportCategoryModel> currectlySelected =
        List.from(state.selectedSports!);
    if (currectlySelected.contains(sportCat)) {
      currectlySelected.remove(sportCat);
    } else {
      currectlySelected.add(sportCat);
    }
    emit(state.copyWith(selectedSports: currectlySelected));
  }

  selectedEntityTypeChanged({required SearchEntityType entityType}) {
    emit(state.copyWith(selectedEntityType: entityType));
  }

  @override
  close() async {
    searchTermController.dispose();
    super.close();
  }
}
