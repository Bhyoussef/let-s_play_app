import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/features/home_search/models/search_entity_type.dart';

class SearchEmptyPlaygroundsWidget extends StatelessWidget {
  final SearchEntityType searchEntityType;

  const SearchEmptyPlaygroundsWidget(
      {super.key, required this.searchEntityType});
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/empty_favs.webp',
              width: 400.w,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: Text(
              searchEntityType == SearchEntityType.playground
                  ? 'No playgrounds have been found!'
                  : 'No matches have been found!',
              textAlign: TextAlign.center,
              style: AppStyles.inter17Bold,
            ),
          ),
        ],
      ),
    );
  }
}
