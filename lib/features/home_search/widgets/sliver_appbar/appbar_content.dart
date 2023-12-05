import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_play/common/components/searchTextField.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/features/home_search/cubit/home_search_cubit.dart';
import 'package:lets_play/features/home_search/widgets/sliver_appbar/selected_sport_row.dart';

class SearchFiltersSliverAppbar extends StatelessWidget {
  const SearchFiltersSliverAppbar({
    Key? key,
    required this.homeSearchCubit,
  }) : super(key: key);

  final HomeSearchCubit homeSearchCubit;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      pinned: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
      ),
      toolbarHeight: 180.h,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectedSportRow(homeSearchCubit: homeSearchCubit),
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                          child: SearchTextField(
                        controller: homeSearchCubit.searchTermController,
                        onChanged: (term) {},
                      )),
                      SizedBox(width: 10.w),
                      SizedBox(
                        width: 50,
                        height: 42,
                        child: TextButton(
                          onPressed: () {
                            homeSearchCubit.applyFilterPressed();
                          },
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              minimumSize: const Size.fromHeight(40),
                              backgroundColor: AppColors.yellow),
                          child: const Center(
                            child: Icon(
                              Icons.search,
                              color: Color.fromARGB(134, 10, 1, 49),
                              size: 26,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
