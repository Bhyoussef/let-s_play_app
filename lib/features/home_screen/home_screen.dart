import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_play/common/extensions/string_extensions.dart';
import 'package:lets_play/features/Loading/loading_screen.dart';
import 'package:lets_play/features/home_screen/component/offers_list.dart';
import 'package:lets_play/features/home_screen/component/sports_list.dart';
import 'package:lets_play/features/profile/cubit/user_cubit.dart';
import 'package:lets_play/routes/routes_list.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/assets_images.dart';
import 'component/available_public_matches_list.dart';
import 'cubit/home_cubit.dart';

final HomeCubit homeCubit = HomeCubit();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    homeCubit.getHomeDetails(context.read<UserCubit>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGrey,
      extendBodyBehindAppBar: true,
      body: BlocProvider.value(value: homeCubit, child: const HomeScreenContent()),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, homeState) {
        final promos = homeState.promos!;
        if (homeState is ErrorState) return const LoadingScreen();
        return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: promos.isNotEmpty ? 400.h : 280.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          image: DecorationImage(
                              image: AssetImage(Assets.homeBackground), fit: BoxFit.fill)),
                    ),
                    Container(
                        height: promos.isNotEmpty ? 400.h : 280.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppColors.purple.withOpacity(0.7),
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                        )),
                    Column(
                      children: [
                        Container(
                          height: 100.h,
                          padding: EdgeInsets.fromLTRB(20, 50.h, 20, 0),
                          width: MediaQuery.of(context).size.width,
                          color: AppColors.purple.withOpacity(0.2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BlocBuilder<UserCubit, UserState>(
                                builder: (context, state) {
                                  return Text('Hi ${state.user!.firstname!.capitalize}',
                                      style: AppStyles.inter17w500);
                                },
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, RouteList.homeSearchScreen,
                                        arguments: {"homeSportCats": homeState.homeSportCats!});

                                    // Navigator.pushNamed(
                                    //     context, RouteList.searchScreen);
                                  },
                                  icon: Image.asset(
                                    Assets.loopIcon,
                                    height: 25,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              text: 'Let’s find the best',
                              style: AppStyles.sf37Bold,
                              children: <TextSpan>[
                                TextSpan(
                                    text: " Court ",
                                    style: AppStyles.sf37Bold.withColor(AppColors.yellow)),
                                const TextSpan(text: "for you", style: AppStyles.sf37Bold),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        if (promos.isNotEmpty)
                          const Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Special Promo', style: AppStyles.mont12Regular),
                                      // Text('See All', style: AppStyles.mont12Regular)
                                    ],
                                  )),
                              SpecialOfferList(),
                            ],
                          ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Let’s Play', style: AppStyles.mont19BoldBlack),
                          if (false)
                            TextButton(
                              onPressed: () {
                                ///
                              },
                              child: const Text('Show All', style: AppStyles.mont12RegularBlack),
                            )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 120,
                      child: SportsList(),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 31),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Available Public Matches',
                                style: AppStyles.mont19BoldBlack),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RouteList.availablePublicMatchesShowAll);
                              },
                              child: const Text('Show All', style: AppStyles.mont12RegularBlack),
                            )
                          ],
                        )),
                    const AvailablePublicMatchesList(),
                    const SizedBox(
                      height: 32,
                    )
                  ],
                ),
              ],
            ));
      },
    );
  }
}
