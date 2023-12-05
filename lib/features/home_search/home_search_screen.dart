import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_play/common/components/app_bar/app_bar_with_back_btn.dart';
import 'package:lets_play/common/constants/assets_images.dart';
import 'package:lets_play/features/Loading/loading_screen.dart';
import 'package:lets_play/features/home_search/cubit/home_search_cubit.dart';
import 'package:lets_play/features/home_search/models/search_entity_type.dart';
import 'package:lets_play/features/home_search/widgets/empty_playgrounds.dart';
import 'package:lets_play/features/home_search/widgets/match_card.dart';
import 'package:lets_play/features/home_search/widgets/playground_card.dart';
import 'package:lets_play/features/home_search/widgets/sliver_appbar/appbar_content.dart';
import 'package:lets_play/features/home_search/widgets/sports_sheet/sport_picker_sheet_content.dart';
import 'package:lets_play/features/profile/cubit/user_cubit.dart';
import 'package:lets_play/models/mainStatus.dart';
import 'package:lets_play/models/sport_category_model.dart';

class HomeSearchScreen extends StatelessWidget {
  const HomeSearchScreen({super.key, required this.homeSportCats});
  final List<SportCategoryModel> homeSportCats;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => HomeSearchCubit(context.read<UserCubit>())
        ..registerSportCategoriesList(homeSportCats: homeSportCats),
      child: HomeSearchContent(homeSportCats: homeSportCats),
    );
  }
}

class HomeSearchContent extends StatelessWidget {
  const HomeSearchContent({super.key, required this.homeSportCats});
  final List<SportCategoryModel> homeSportCats;

  @override
  Widget build(BuildContext context) {
    final homeSearchCubit = context.read<HomeSearchCubit>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: appBarWithBackBtn(
        context: context,
        title: "Let's Search",
        trailingAction: IconButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                ),
                isScrollControlled: true,
                builder: (context) {
                  return BlocProvider.value(
                    value: homeSearchCubit,
                    child: const SportCategoryPickerSheetContent(),
                  );
                });
          },
          icon: Image.asset(
            Assets.filterIconBlack,
            height: 25,
            width: 25,
          ),
        ),
      ),
      body: BlocBuilder<HomeSearchCubit, HomeSearchState>(
        builder: (context, state) {
          return CustomScrollView(slivers: [
            SearchFiltersSliverAppbar(homeSearchCubit: homeSearchCubit),
            if (state.mainStatus == MainStatus.initial)
              const SliverToBoxAdapter(child: SizedBox.shrink())
            else if (state.mainStatus == MainStatus.loaded) ...[
              if (state.searchedEntityType == SearchEntityType.playground)
                if (state.playgrounds!.isNotEmpty)
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, int index) {
                          return PlaygroundCardWidget(
                            playground: state.playgrounds![index],
                          );
                        },
                        childCount: state.playgrounds!.length,
                      ),
                    ),
                  )
                else
                  const SearchEmptyPlaygroundsWidget(
                    searchEntityType: SearchEntityType.playground,
                  )
              else if (state.matches!.isNotEmpty)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, int index) {
                        return MatchCardWidget(
                          match: state.matches![index],
                        );
                      },
                      childCount: state.matches!.length,
                    ),
                  ),
                )
              else
                const SearchEmptyPlaygroundsWidget(
                  searchEntityType: SearchEntityType.match,
                )
            ] else
              const SliverFillRemaining(hasScrollBody: false, child: LoadingScreen()),
          ]);
        },
      ),
    );
  }
}
