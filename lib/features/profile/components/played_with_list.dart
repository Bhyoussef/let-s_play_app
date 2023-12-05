import 'package:flutter/material.dart';
import 'package:lets_play/common/components/MyNetworkImage.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/common/constants/assets_images.dart';
import 'package:lets_play/features/pick_teams/models/player_model.dart';

class PlayedWithList extends StatelessWidget {
  const PlayedWithList({Key? key, required this.frequentPlayers}) : super(key: key);
  final List<PlayerModel> frequentPlayers;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
          itemCount: frequentPlayers.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                margin: index == 0
                    ? const EdgeInsets.only(right: 12, left: 20)
                    : const EdgeInsets.only(right: 12),
                height: 70,
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: MyNetworkImage(
                        picPath: frequentPlayers[index].avatar,
                        fallBackAssetPath: Assets.emoji,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(frequentPlayers[index].firstName, style: AppStyles.inter13SemiBold),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
