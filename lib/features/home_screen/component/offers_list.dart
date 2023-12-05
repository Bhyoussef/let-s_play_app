import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_play/common/components/MyNetworkImage.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/features/home_screen/cubit/home_cubit.dart';
import 'package:lets_play/features/home_screen/models/Promo.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SpecialOfferList extends StatefulWidget {
  const SpecialOfferList({Key? key}) : super(key: key);
  @override
  State<SpecialOfferList> createState() => _SpecialOfferListState();
}

class _SpecialOfferListState extends State<SpecialOfferList> {
  ScrollController controller = ScrollController();
  int _currentItem = -1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final promos = state.promos!;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 75.h,
              child: ListView.builder(
                  itemCount: state.promos!.length,
                  scrollDirection: Axis.horizontal,
                  controller: controller,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final promo = promos[index];
                    return VisibilityDetector(
                        key: Key(index.toString()),
                        onVisibilityChanged: (VisibilityInfo info) {
                          if (info.visibleFraction == 1) {
                            setState(() {
                              _currentItem = index;
                              print(_currentItem);
                            });
                          }
                        },
                        child:Container(
                      margin: index == 0
                          ? const EdgeInsets.only(right: 12, left: 20)
                          : const EdgeInsets.only(right: 12),
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8)),
                            child: SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width * 0.5) - 2,
                              child: Center(
                                child: MyNetworkImage(
                                    width: (MediaQuery.of(context).size.width *
                                            0.5) -
                                        2,
                                    picPath: promo.image),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              for (int i = 0; i < 20; i++)
                                Flexible(
                                  child: Container(
                                    height: 5.h,
                                    width: 2,
                                    color: i % 2 == 0
                                        ? AppColors.purple
                                        : AppColors.yellow,
                                  ),
                                )
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 25),
                            width: MediaQuery.of(context).size.width * 0.3,
                            decoration: BoxDecoration(
                                color: AppColors.yellow,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8))),
                            child: Center(
                              child: Text('Up to ${promo.value}% Discount',
                                  style: AppStyles.sf17Regular),
                            ),
                          )
                        ],
                      ),
                    ));
                  }),
            ),
            SizedBox(height: 15.h),
            if(state.promos != null )SizedBox(
              height: 10.h,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < state.promos!.length; i++)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 4.h,
                      width: i == _currentItem ? 32 : 10,
                      decoration: BoxDecoration(
                          color: i == _currentItem ? AppColors.yellow : Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(2))),
                    )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
