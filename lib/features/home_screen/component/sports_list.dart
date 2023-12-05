import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_play/common/components/MyNetworkImage.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/common/extensions/string_extensions.dart';
import 'package:lets_play/features/home_screen/cubit/home_cubit.dart';

import '../../../routes/routes_list.dart';

class SportsList extends StatelessWidget {
  const SportsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return ListView.builder(
            itemCount: state.homeSportCats?.length ?? 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var _sport = state.homeSportCats?[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteList.sportFieldsScreen,
                      arguments: _sport);
                },
                child: Container(
                  margin: index == 0
                      ? const EdgeInsets.only(right: 12, left: 20)
                      : const EdgeInsets.only(right: 12),
                  height: 120,
                  width: 90,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: MyNetworkImage(
                          picPath: _sport!.icon!,
                          width: 50.h,
                          height: 50.h,
                        ),
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      Text(_sport.nameEn!.capitalize,
                          style: AppStyles.mont13RegularBlack),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
