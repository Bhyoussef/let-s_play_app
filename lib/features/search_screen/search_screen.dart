import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_play/common/components/app_bar/app_bar_with_back_btn.dart';
import 'package:lets_play/common/components/searchTextField.dart';
import 'package:lets_play/features/search_screen/cubit/search_cubit.dart';
import '../../common/constants/app_constants.dart';
import '../../data/core/http/api_constants.dart';
import '../../models/mainStatus.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SearchScreenState();
  }
}

class SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWithBackBtn(context: context, title: "Search"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SearchTextField(
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 800), () {
                    if (value != "") {
                      // context.read<SearchCubit>().getSearchResults(value);
                    }
                  });
                },
              ),
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state.mainStatus == MainStatus.loaded) {
                    return ListView.builder(
                      itemCount: state.searchResults?.data.data?.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = state.searchResults?.data.data![index];
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(top: 12),
                            padding: const EdgeInsets.all(20),
                            height: 277,
                            width: MediaQuery.of(context).size.width * 0.8,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${item?.enName}',
                                        style: AppStyles.mont17Bold),
                                    // FavWidget(
                                    //   onChange: (value) {},
                                    //   selectedInitially: field.isFav!,
                                    // ),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      height: 134,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  ApiConstants.imageUrl +
                                                      '${item?.mainImage}'),
                                              fit: BoxFit.cover)),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 121, left: 8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      height: 23,
                                      width: 110,
                                      decoration: BoxDecoration(
                                          color: AppColors.yellow,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Center(
                                        child: Text("${item?.fullAddress}",
                                            style: AppStyles.inter12w500
                                                .withColor(Colors.black)),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              )
            ],
          ),
        ));
  }
}
