import 'package:flutter/material.dart';
import 'package:lets_play/common/components/MyNetworkImage.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/models/sport_category_model.dart';

class SportsPlayedList extends StatelessWidget {
  const SportsPlayedList({Key? key, required this.sports}) : super(key: key);
  final List<SportCategoryModel> sports;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
          itemCount: sports.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var _sport = sports[index];
            return GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, RouteList.sportFieldsScreen);
              },
              child: Container(
                margin: index == 0
                    ? const EdgeInsets.only(right: 12, left: 20)
                    : const EdgeInsets.only(right: 12),
                width: 90,
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyNetworkImage(picPath: _sport.icon, height: 80),
                    const SizedBox(height: 7),
                    Text(_sport.nameEn!.toUpperCase(), style: AppStyles.mont13RegularBlack),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
