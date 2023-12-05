import 'package:flutter/material.dart';
import 'package:lets_play/common/components/MyNetworkImage.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/common/constants/assets_images.dart';
import 'package:lets_play/common/extensions/string_extensions.dart';
import 'package:lets_play/models/server/playground_model.dart';

class ClubsLIst extends StatelessWidget {
  const ClubsLIst({Key? key, required this.clubs}) : super(key: key);
  final List<PlaygroundModel> clubs;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      child: ListView.builder(
          itemCount: clubs.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                margin: index == 0
                    ? const EdgeInsets.only(right: 12, left: 20)
                    : const EdgeInsets.only(right: 12),
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: MyNetworkImage(
                        picPath: clubs[index].image,
                        fallBackAssetPath: Assets.fieldImage,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(clubs[index].nameEn!.capitalizeEveryWord,
                        style: AppStyles.inter13SemiBold),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
