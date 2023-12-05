import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_play/common/components/MyNetworkImage.dart';
import 'package:lets_play/common/constants/assets_images.dart';
import 'package:lets_play/common/extensions/dateTime_extensions.dart';
import 'package:lets_play/common/extensions/string_extensions.dart';
import 'package:lets_play/features/Loading/loading_screen.dart';
import 'package:lets_play/features/chat/cubit/chats_cubit.dart';
import 'package:lets_play/features/pick_teams/models/player_model.dart';
import 'package:lets_play/models/mainStatus.dart';
import 'package:lets_play/models/server/match_model.dart';
import '../../common/constants/app_constants.dart';
import '../../routes/routes_list.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => ChatsCubit()
        ..getAllChatRooms()
        ..initializePusher(),
      child: const ChatsScreenContent(),
    );
  }
}

class ChatsScreenContent extends StatefulWidget {
  const ChatsScreenContent({super.key});

  @override
  State<ChatsScreenContent> createState() => _ChatsScreenContentState();
}

class _ChatsScreenContentState extends State<ChatsScreenContent>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Let's Chat", style: AppStyles.mont27bold),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(100.h),
              child: ColoredBox(
                color: AppColors.purple,
                child: TabBar(
                  indicatorColor: AppColors.yellow,
                  indicatorWeight: 6.h,
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  labelStyle: AppStyles.mont17Bold,
                  tabs: <Widget>[
                    Tab(
                      text: 'Friends',
                      height: 70.h,
                    ),
                    Tab(
                      text: 'Matches',
                      height: 70.h,
                    ),
                  ],
                ),
              ))),
      body: BlocBuilder<ChatsCubit, ChatsState>(
        builder: (context, state) {
          if (state.mainStatus == MainStatus.loaded) {
            return TabBarView(
              controller: _tabController,
              children: [
                FriendsChatsListView(friendsRooms: state.friendRooms!),
                MatchesChatsListView(matchRooms: state.matchRooms!),
              ],
            );
          }
          return const LoadingScreen();
        },
      ),
    );
  }
}

class FriendsChatsListView extends StatelessWidget {
  const FriendsChatsListView({super.key, required this.friendsRooms});
  final List<PlayerModel> friendsRooms;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: friendsRooms.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final friend = friendsRooms[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteList.chatDetails, arguments: {"friend": friend});
          },
          child: Container(
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.all(20),
            height: 125.h,
            width: MediaQuery.of(context).size.width * 0.8,
            color: Colors.white,
            child: Row(
              children: [
                ClipOval(
                  child: MyNetworkImage(
                    picPath: friend.avatar,
                    fallBackAssetPath: Assets.emoji,
                    height: 50,
                    width: 50,
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(right: 23.w),
                          child: Text(
                            friend.firstName + ' ' + friend.lastName,
                            style: AppStyles.inter15Bold,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      if (friend.updatedAt != null)
                        Text(
                            '${friend.updatedAt!.defaultFomatToDateTime()!.toDayWeekdayMonthAbrDayFormatted()} | ${friend.updatedAt!.defaultFomatToDateTime()!.toDefaultTimeHMFormatted()}',
                            style: AppStyles.inter12w500.withColor(AppColors.greyText)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MatchesChatsListView extends StatelessWidget {
  const MatchesChatsListView({super.key, required this.matchRooms});
  final List<MatchModel> matchRooms;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: matchRooms.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final match = matchRooms[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteList.chatDetails, arguments: {"match": match});
          },
          child: Container(
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.all(20),
            height: 117,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      ClipOval(
                        child: MyNetworkImage(
                          picPath: match.playground!.image,
                          fallBackAssetPath: Assets.fieldImage,
                          height: 50,
                          width: 50,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${match.playground!.nameEn}", style: AppStyles.inter15Bold),
                          const SizedBox(height: 4),
                          Text(
                              '${match.startDate!.toDayWeekdayMonthAbrDayFormatted()} | ${match.startDate!.toDefaultTimeHMFormatted()}',
                              style: AppStyles.inter12w500.withColor(AppColors.greyText)),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            height: 0.5,
                            color: Colors.grey,
                          ),
                          Text(match.type.toString().capitalize + ' match',
                              style: AppStyles.inter12Bold.withColor(AppColors.purple)),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    final chatsCubit = context.read<ChatsCubit>();
                    chatsCubit.leaveChatMatch(roomId: match.roomId!);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: AppColors.yellowDisabled,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout,
                              color: AppColors.mainRed,
                              size: 20.sp,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'Leave chat',
                              style: AppStyles.inter11w500
                                  .copyWith(fontWeight: FontWeight.bold, color: AppColors.purple),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
