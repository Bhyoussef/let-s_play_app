import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/common/extensions/string_extensions.dart';
import 'package:lets_play/features/home_search/cubit/home_search_cubit.dart';
import 'package:lets_play/features/home_search/models/search_entity_type.dart';
import 'package:lets_play/models/sport_category_model.dart';

class SelectedSportRow extends StatelessWidget {
  const SelectedSportRow({
    Key? key,
    required this.homeSearchCubit,
  }) : super(key: key);

  final HomeSearchCubit homeSearchCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Wrap(
        children: [
          BlocBuilder<HomeSearchCubit, HomeSearchState>(
            builder: (context, state) {
              String typeToShow =
                  state.selectedEntityType == SearchEntityType.playground
                      ? 'playgrounds'
                      : 'matches';
              return Text('Search for $typeToShow : ',
                  style: AppStyles.inter15Bold);
            },
          ),
          BlocBuilder<HomeSearchCubit, HomeSearchState>(
            builder: (context, state) {
              final List<SportCategoryModel> selectedSports =
                  state.selectedSports!;
              String text = '';
              if (selectedSports.length == state.sportCategories!.length) {
                text = 'All';
              } else {
                for (var sport in selectedSports) {
                  final isLast = selectedSports.last == sport;
                  final isFirst = selectedSports.first == sport;
                  text = text +
                      sport.nameEn! +
                      (!isLast ? ',' : '') +
                      (isLast && !isFirst ? '.' : ' ');
                }
              }
              return Text(text.capitalizeEveryWord,
                  style: AppStyles.inter15Bold);
            },
          )
        ],
      ),
    );
  }
}
