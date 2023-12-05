import 'package:flutter/material.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/common/extensions/string_extensions.dart';
import 'package:lets_play/data/core/http/api_constants.dart';
import 'package:lets_play/models/enums/public_private_type.dart';
import 'package:lets_play/models/server/playground_model.dart';
import 'package:lets_play/routes/routes_list.dart';

class PlaygroundCardWidget extends StatelessWidget {
  const PlaygroundCardWidget({super.key, required this.playground});
  final PlaygroundModel playground;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteList.playgroundDetailScreen,
            arguments: {
              'playgroundId': playground.id,
              'publicOrPrivate': PublicPrivateType.public
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child:
                      Text("${playground.nameEn}", style: AppStyles.mont17Bold),
                ),
                Text(playground.fullAddress!.capitalizeEveryWord,
                    style: AppStyles.inter12w400),
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 134,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: NetworkImage(
                                  ApiConstants.imageUrl + playground.image!),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 110, left: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      height: 23,
                      width: 110,
                      decoration: BoxDecoration(
                          color: AppColors.yellow,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Center(
                        child: Text("${playground.grassTypeEn}",
                            style:
                                AppStyles.inter12w500.withColor(Colors.black)),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          height: 23,
                          decoration: BoxDecoration(
                              color: AppColors.yellow,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: Text(
                                '${playground.matchesCount} Courts Available',
                                style: AppStyles.inter11w500
                                    .withColor(Colors.black)),
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      height: 23,
                      decoration: BoxDecoration(
                          color: AppColors.yellow,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Center(
                        child: Text('${playground.price} QAR',
                            style:
                                AppStyles.inter11w500.withColor(Colors.black)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
