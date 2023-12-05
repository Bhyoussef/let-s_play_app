import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/features/home_search/cubit/home_search_cubit.dart';
import 'package:lets_play/features/home_search/widgets/sliver_appbar/pg_or_match_picker.dart';
import 'package:lets_play/features/home_search/widgets/sports_sheet/sport_grid_item.dart';

class SportCategoryPickerSheetContent extends StatelessWidget {
  const SportCategoryPickerSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    final searchCubit = context.watch<HomeSearchCubit>();
    return Material(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      color: AppColors.backGrey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 13, bottom: 12),
              child: Container(
                height: 5.h,
                width: 54.w,
                decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(100)),
              ),
            ),
          ),
          const PlaygroundOrMatchPickerWidget(),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: searchCubit.state.sportCategories!.length,
                itemBuilder: (context, index) {
                  final sport = searchCubit.state.sportCategories![index];
                  final isSelected = searchCubit.state.selectedSports!
                      .where((element) => element.id == sport.id)
                      .isNotEmpty;
                  return GestureDetector(
                    onTap: () {
                      searchCubit.selectedSportChanged(sportCat: sport);
                    },
                    child: SportGridItemWidget(
                        sport: sport, isSelected: isSelected),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  mainAxisExtent: 90.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
