import 'package:flutter/material.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/common/constants/assets_images.dart';
import 'package:lets_play/common/extensions/string_extensions.dart';
import 'package:lets_play/models/mainStatus.dart';
import 'package:lets_play/models/sport_category_model.dart';
import 'package:lets_play/routes/routes_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/core/http/api_constants.dart';
import '../../models/enums/public_private_type.dart';
import '../Loading/loading_screen.dart';
import 'cubit/public_matches_cubit.dart';

class PublicMatches extends StatelessWidget {
  final SportCategoryModel sport;
  const PublicMatches({Key? key, required this.sport}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGrey,
      body: Column(
        children: [
          Container(
            height: 2,
            color: Colors.white,
          ),
          if (false)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              color: AppColors.purple,
              child: Row(
                children: [
                  Image.asset(
                    Assets.filterIcon,
                    height: 20,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text("Wednesday 31 Aug", style: AppStyles.mont13Medium.withColor(Colors.white))
                ],
              ),
            ),
          Expanded(
              child: BlocBuilder<PublicMatchesCubit, PublicMatchesCubitState>(
            builder: (context, state) {
              if (state.mainStatus == MainStatus.loaded) {
                return ListView.builder(
                  itemCount: state.publicPlaygrounds!.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final field = state.publicPlaygrounds![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteList.playgroundDetailScreen, arguments: {
                          'playgroundId': field.id,
                          'publicOrPrivate': PublicPrivateType.public
                        });
                      },
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(field.nameEn!.capitalizeEveryWord,
                                    style: AppStyles.mont17Bold),
                                // FavWidget(
                                //   onChange: (value) {},
                                //   selectedInitially: field.isFav!,
                                // ),
                              ],
                            ),
                            Text(
                                '${field.fromUserDistance!.toInt()} KM - ${field.fullAddress!.capitalizeEveryWord}',
                                style: AppStyles.inter12w400),
                            Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(vertical: 20),
                                  height: 134,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          image: NetworkImage(ApiConstants.imageUrl + field.image!),
                                          fit: BoxFit.cover)),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 121, left: 8),
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  height: 23,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      color: AppColors.yellow,
                                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                                  child: Center(
                                    child: Text("${field.grassTypeEn}",
                                        style: AppStyles.inter12w500.withColor(Colors.black)),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      height: 23,
                                      decoration: BoxDecoration(
                                          color: AppColors.yellow,
                                          borderRadius: const BorderRadius.all(Radius.circular(5))),
                                      child: Center(
                                        child: Text('${field.matchesCount} Courts Available',
                                            style: AppStyles.inter11w500.withColor(Colors.black)),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    /*if (field.womenOnly)
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(horizontal: 8),
                                                height: 23,
                                                decoration: BoxDecoration(
                                                    color: AppColors.yellow,
                                                    borderRadius: const BorderRadius.all(
                                                        Radius.circular(5))),
                                                child: Center(
                                                  child: Text('Women Only',
                                                      style: AppStyles.inter11w500
                                                          .withColor(Colors.black)),
                                                ),
                                              ),*/
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  height: 23,
                                  decoration: BoxDecoration(
                                      color: AppColors.yellow,
                                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                                  child: Center(
                                    child: Text('${field.price} QAR',
                                        style: AppStyles.inter11w500.withColor(Colors.black)),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return const LoadingScreen();
            },
          ))
        ],
      ),
    );
  }
}
