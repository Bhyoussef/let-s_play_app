import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/common/extensions/string_extensions.dart';
import 'package:lets_play/data/core/http/api_constants.dart';
import 'package:lets_play/features/profile/cubit/user_cubit.dart';
import 'package:lets_play/models/server/playground_model.dart';

import '../../common/constants/assets_images.dart';

class FavPlaygroundsScreen extends StatelessWidget {
  final listKey = GlobalKey<SliverAnimatedListState>();

  @override
  Widget build(BuildContext context) {
    final UserCubit userCubit = context.watch<UserCubit>();
    List<PlaygroundModel> items =
        List.from(userCubit.state.user!.favoritePlaygrounds!);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.purple,
          elevation: 2,
          centerTitle: false,
          title: const Text("Favorite playgrounds",
              style: AppStyles.mont23SemiBold),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Center(
                child: Image.asset(
                  Assets.backBtn,
                  height: 22,
                  color: Colors.white,
                ),
              )),
        ),
        body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              if (items.isEmpty) EmptyPlaygroundsWidget(),
              if (items.isNotEmpty)
                SliverAnimatedList(
                  initialItemCount: items.length,
                  key: listKey,
                  itemBuilder: (context, index, animation) => buildItem(
                      items, items[index], index, animation, userCubit),
                ),
            ]));
  }

  buildItem(List<PlaygroundModel> items, PlaygroundModel item, int index,
      Animation<double> animation, UserCubit userCubit) {
    return PlaygroundCard(
      item: item,
      animation: animation,
      onDelete: () {
        removeItem(index, items, userCubit);
        userCubit.removeFavoritePlayground(
            playgroundId: item.id, lastItem: items.isEmpty);
      },
    );
  }

  void removeItem(int index, List<PlaygroundModel> items, UserCubit userCubit) {
    final item = items.removeAt(index);

    listKey.currentState!.removeItem(
      index,
      (context, animation) =>
          buildItem(items, item, index, animation, userCubit),
    );
  }
}

class PlaygroundCard extends StatelessWidget {
  final PlaygroundModel? item;
  final VoidCallback? onDelete;
  final Animation<double>? animation;

  const PlaygroundCard({
    this.item,
    this.onDelete,
    this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: const Offset(0, 0),
      ).animate(animation!),
      child: FadeTransition(
        opacity: animation!,
        child: ScaleTransition(
          scale: animation!,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: RemovablePlaygroundCard(
                field: item!,
                onDelete: onDelete,
              )),
        ),
      ),
    );
  }
}

class RemovablePlaygroundCard extends StatelessWidget {
  const RemovablePlaygroundCard({Key? key, required this.field, this.onDelete})
      : super(key: key);
  final PlaygroundModel field;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${field.nameEn}", style: AppStyles.mont17Bold),
              InkWell(
                onTap: () {
                  onDelete!();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Remove", style: AppStyles.mont17Bold),
                ),
              ),
            ],
          ),
          Text(field.fullAddress!.capitalizeEveryWord,
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
                        image:
                            NetworkImage(ApiConstants.imageUrl + field.image!),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (false)
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
                        child: Text('${field.matchesCount} Courts Available',
                            style:
                                AppStyles.inter11w500.withColor(Colors.black)),
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
    );
  }
}

class EmptyPlaygroundsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          Flexible(
            flex: 5,
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/empty_favs.webp',
                width: 400.w,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: const Text(
              'No favorite playgrounds added!',
              textAlign: TextAlign.center,
              style: AppStyles.inter17Bold,
            ),
          ),
          const Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }
}
