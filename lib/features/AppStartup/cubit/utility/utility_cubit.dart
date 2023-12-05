import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/sport_category_model.dart';
import 'package:lets_play/data/services/utility.dart' as utilityService;

part 'utility_state.dart';

class UtilityCubit extends Cubit<UtilityState> {
  UtilityCubit() : super(UtilityState.initial());

  Future getSportCategoriesList() async {
    try {
      final categoriesList = await utilityService.fetchSportCategoriesToFav();
      final List<SportCategoryModel> sCategories =
          categoriesList.map(formatSportCategory).toList();
      emit(state.copyWith(sCategoriesList: sCategories));
    } catch (e) {}
  }
}
