import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/common/extensions/string_extensions.dart';
import 'package:lets_play/features/payment/models/dibsy_card.dart';
import 'package:lets_play/features/profile/cubit/user_cubit.dart';

import '../../common/constants/assets_images.dart';

class PaymentCardsScreen extends StatelessWidget {
  final listKey = GlobalKey<SliverAnimatedListState>();

  @override
  Widget build(BuildContext context) {
    final UserCubit userCubit = context.watch<UserCubit>();
    List<DibsyCard> items = List.from(userCubit.state.user!.savedCards!);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.purple,
          elevation: 2,
          centerTitle: false,
          title: const Text("Saved Cards", style: AppStyles.mont23SemiBold),
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
              if (items.isEmpty) EmptyCardsWidget(),
              if (items.isNotEmpty)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  sliver: SliverAnimatedList(
                    initialItemCount: items.length,
                    key: listKey,
                    itemBuilder: (context, index, animation) => buildItem(
                        items, items[index], index, animation, userCubit),
                  ),
                ),
            ]));
  }

  buildItem(List<DibsyCard> items, DibsyCard item, int index,
      Animation<double> animation, UserCubit userCubit) {
    return PaymentCardWidget(
      item: item,
      animation: animation,
      onDelete: () {
        removeItem(index, items, userCubit);
        userCubit.removeSavedCard(
            cardToken: item.token, lastItem: items.isEmpty);
      },
    );
  }

  void removeItem(int index, List<DibsyCard> items, UserCubit userCubit) {
    final item = items.removeAt(index);

    listKey.currentState!.removeItem(
      index,
      (context, animation) =>
          buildItem(items, item, index, animation, userCubit),
    );
  }
}

class PaymentCardWidget extends StatelessWidget {
  final DibsyCard? item;
  final VoidCallback? onDelete;
  final Animation<double>? animation;

  const PaymentCardWidget({
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
              child: RemovablePaymentCard(
                card: item!,
                onDelete: onDelete,
              )),
        ),
      ),
    );
  }
}

class RemovablePaymentCard extends StatelessWidget {
  const RemovablePaymentCard({Key? key, required this.card, this.onDelete})
      : super(key: key);
  final DibsyCard card;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final isVisa = card.providerType.toLowerCase().contains('visa');
    final isMasterCard = card.providerType.toLowerCase().contains('master');
    final isAmericanEx = card.providerType.toLowerCase().contains('merica');
    return SizedBox(
      height: 230.h,
      child: Card(
        shadowColor: Colors.transparent,
        color: isVisa
            ? const Color(0xFF1A1F71)
            : isMasterCard
                ? const Color(0xFFF7B600)
                : isAmericanEx
                    ? AppColors.lightBlue
                    : AppColors.purple,
        elevation: 4,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          children: [
            if (isVisa || isAmericanEx || isMasterCard)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.asset(
                      isVisa
                          ? 'assets/images/visa.png'
                          : isMasterCard
                              ? 'assets/images/mastercard.png'
                              : 'assets/images/american_express.png',
                      height: 50.w,
                      width: 50.w,
                    ),
                    IconButton(
                        onPressed: () async {
                          bool confirm = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirm"),
                                content: const Text(
                                    "Are you sure you wish to delete this card ?"),
                                actions: <Widget>[
                                  TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: AppColors.purple,
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text("DELETE")),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.black,
                                    ),
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("CANCEL"),
                                  ),
                                ],
                              );
                            },
                          );
                          if (confirm) {
                            onDelete!();
                          }
                        },
                        icon: Icon(
                          Icons.delete,
                          size: 30.w,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            Container(
                margin: EdgeInsets.only(top: 26.h, left: 30.w, right: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        card.firstDigits.substring(0, 4),
                        textAlign: TextAlign.center,
                        style: AppStyles.inter17Bold.copyWith(
                            color: isVisa ? Colors.white : Colors.black),
                      ),
                    ),
                    Expanded(
                      child: SvgPicture.asset(
                        'assets/images/4dots.svg',
                        height: 12.sp,
                      ),
                    ),
                    Expanded(
                      child: SvgPicture.asset(
                        'assets/images/4dots.svg',
                        height: 12.sp,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        card.lastDigits,
                        style: AppStyles.inter17Bold.copyWith(
                            color: isVisa ? Colors.white : Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.all(30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          card.holderName.capitalizeEveryWord,
                          style: AppStyles.mont17Bold.copyWith(
                            color: isVisa ? Colors.white : Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EmptyCardsWidget extends StatelessWidget {
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
              'No cards have been saved!',
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
