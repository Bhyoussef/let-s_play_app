import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_play/common/constants/app_constants.dart';

import '../models/DurationModel.dart';

class PlayersList extends StatefulWidget {
  final SettingsModel settings;
  final Function(int, int) selectCallback;

  const PlayersList(
      {Key? key, required this.settings, required this.selectCallback})
      : super(key: key);
  @override
  State<PlayersList> createState() => _PlayersListState();
}

class _PlayersListState extends State<PlayersList> {
  ScrollController controller = ScrollController();
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final playersCountChoices = widget.settings.numberPlayers;
    if (playersCountChoices.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 50.h,
      child: ListView.builder(
          padding: const EdgeInsets.only(top: 8),
          itemCount: playersCountChoices.length,
          scrollDirection: Axis.horizontal,
          controller: controller,
          itemBuilder: (context, index) {
            final item = playersCountChoices[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.selectCallback(item.id, index);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                margin: const EdgeInsets.only(
                  right: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    color: selectedIndex == index
                        ? AppColors.purple
                        : AppColors.greyText, // red as border color
                  ),
                ),
                child: Center(
                  child: Text("${item.playersCount}X${item.playersCount}",
                      style: AppStyles.mont14Medium.withColor(
                          selectedIndex == index
                              ? AppColors.purple
                              : AppColors.greyText)),
                ),
              ),
            );
          }),
    );
  }
}
