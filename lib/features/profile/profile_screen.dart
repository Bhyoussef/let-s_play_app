import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_play/common/components/yellow_banner/clickable_yellow_banner.dart';
import 'package:lets_play/common/constants/assets_images.dart';
import 'package:lets_play/common/extensions/string_extensions.dart';
import 'package:lets_play/features/profile/components/clubs_list.dart';
import 'package:lets_play/features/profile/components/level_item.dart';
import 'package:lets_play/features/profile/components/played_with_list.dart';
import 'package:lets_play/features/profile/components/sports_played_list.dart';
import 'package:lets_play/features/profile/cubit/user_cubit.dart';
import '../../common/components/MyNetworkImage.dart';
import '../../common/constants/app_constants.dart';
import '../../routes/routes_list.dart';
import 'components/played_matches_list.dart';
import 'components/selector_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Profile', style: AppStyles.mont27bold),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
                child: ClickableYellowBanner(
                    title: "+ Add Score",
                    callback: () {
                      Navigator.pushNamed(context, RouteList.addScoreScreen);
                    }),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteList.profileSettings);
                  },
                  icon: Image.asset(
                    Assets.settingsIcon,
                    height: 20,
                    color: Colors.black,
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 23),
                  height: 153,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          ClipOval(
                            child: MyNetworkImage(
                              picPath: userState.user!.avatar,
                              fallBackAssetPath: Assets.emoji,
                              height: 63,
                              width: 63,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userState.user!.firstname!.capitalize +
                                      ' ' +
                                      userState.user!.lastname!.capitalize,
                                  style: AppStyles.mont17Bold,
                                ),
                                if (false)
                                  const SizedBox(
                                    height: 8,
                                  ),
                                if (false)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    height: 22,
                                    decoration: BoxDecoration(
                                        color: AppColors.lightPurple,
                                        borderRadius: const BorderRadius.all(Radius.circular(11))),
                                    child: Center(
                                      child: Text("Level 2.4",
                                          style: AppStyles.inter12w500.withColor(Colors.white)),
                                    ),
                                  )

                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                      if (userState.user!.userEngagementCounts != null)
                        Padding(
                            padding: const EdgeInsets.only(left: 71, top: 20),
                            child: Row(
                              children: [
                                Text(
                                  userState.user!.userEngagementCounts!.matchesCount!.toString(),
                                  style: AppStyles.mont17Bold,
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  "Matches",
                                  style: AppStyles.mont14Medium,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 16),
                                  color: AppColors.backGrey,
                                  width: 1,
                                  height: 20,
                                ),
                                Text(
                                  userState.user!.userEngagementCounts!.friendsCount!.toString(),
                                  style: AppStyles.mont17Bold,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  "Friends",
                                  style: AppStyles.mont14Medium,
                                ),
                              ],
                            ))
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                ///Level
                if (false)
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 23),
                      height: 247,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Level",
                            style: AppStyles.mont23Bold,
                          ),
                          const SizedBox(
                            height: 44,
                          ),
                          Row(
                            children: [
                              const Text(
                                "34",
                                style: AppStyles.mont17Bold,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              const Text(
                                "Matches",
                                style: AppStyles.mont14Medium,
                              ),
                              const SizedBox(
                                width: 19,
                              ),
                              LevelBanner(
                                  title: "24",
                                  subtitle: "win",
                                  color: AppColors.purple,
                                  textColor: Colors.white),
                              const SizedBox(
                                width: 10,
                              ),
                              LevelBanner(
                                  title: "19",
                                  subtitle: "loss",
                                  color: AppColors.grey,
                                  textColor: Colors.black)
                            ],
                          ),
                          const SizedBox(
                            height: 44,
                          ),
                          Stack(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 34),
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      progressContainer(
                                          MediaQuery.of(context).size.width, AppColors.grey),
                                      progressContainer(MediaQuery.of(context).size.width * 0.63,
                                          AppColors.lightPurple),
                                      progressContainer(MediaQuery.of(context).size.width * 0.36,
                                          AppColors.purple)
                                    ],
                                  )),

                              ///make calculation for the progress to update padding 82
                              const Padding(
                                padding: EdgeInsets.only(left: 82),
                                child: SelectorItem(
                                  title: "Level 2.4",
                                ),
                              )
                            ],
                          )
                        ],
                      )),


                if (userState.user!.userEngagementCounts != null)
                  if (userState.user!.userEngagementCounts!.createdMatches!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 28, horizontal: 30),
                            child: Text(
                              "Created Matches",
                              style: AppStyles.mont23SemiBold,
                            )),
                        PlayedMatchesList(
                          matches: userState.user!.userEngagementCounts!.createdMatches!,
                        ),
                      ],
                    ),
                if (userState.user!.userEngagementCounts != null)
                  if (userState.user!.userEngagementCounts!.joinedMatches!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 28, horizontal: 30),
                            child: Text(
                              "Joined Matches",
                              style: AppStyles.mont23SemiBold,
                            )),
                        PlayedMatchesList(
                          matches: userState.user!.userEngagementCounts!.joinedMatches!,
                        ),
                      ],
                    ),

                ///Sports Played
                if (userState.user!.sportsPlayed != null)
                  if (userState.user!.sportsPlayed!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 28, horizontal: 30),
                            child: Text(
                              "Sports Played",
                              style: AppStyles.mont23SemiBold,
                            )),
                        SportsPlayedList(sports: userState.user!.sportsPlayed!),
                      ],
                    ),

                ///Played with
                const SizedBox(height: 20),
                if (userState.user!.frequentPlayers != null)
                  if (userState.user!.frequentPlayers!.isNotEmpty)
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 22),
                        height: 173,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 23),
                                child: Text(
                                  "Frequently Played With",
                                  style: AppStyles.mont23Bold,
                                )),
                            const SizedBox(
                              height: 22,
                            ),
                            PlayedWithList(
                              frequentPlayers: userState.user!.frequentPlayers!,
                            )
                          ],
                        )),
                const SizedBox(
                  height: 10,
                ),

                ///Clubs
                if (userState.user!.clubs != null)
                  if (userState.user!.clubs!.isNotEmpty)
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 22),
                        height: 246,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 23),
                                child: Text(
                                  "Clubs",
                                  style: AppStyles.mont23Bold,
                                )),
                            const SizedBox(
                              height: 22,
                            ),
                            ClubsLIst(clubs: userState.user!.clubs!)
                          ],
                        )),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget progressContainer(double width, Color color) {
    return Container(
      height: 16,
      width: width,
      decoration:
          BoxDecoration(color: color, borderRadius: const BorderRadius.all(Radius.circular(8))),
    );
  }
}
