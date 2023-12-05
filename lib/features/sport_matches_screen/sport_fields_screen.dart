import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_play/common/constants/assets_images.dart';
import 'package:lets_play/features/profile/cubit/user_cubit.dart';
import 'package:lets_play/features/sport_matches_screen/public_matches.dart';
import '../../common/components/MyNetworkImage.dart';
import '../../common/constants/app_constants.dart';
import '../../models/sport_category_model.dart';
import '../coaching_screen/coaching_screen.dart';
import 'cubit/coachings_cubit.dart';
import 'cubit/private_matches_cubit.dart';
import 'cubit/public_matches_cubit.dart';
import 'mappage.dart';
import 'nearby_fields_screen.dart';
import 'private_matches.dart';

class SportFieldsScreen extends StatefulWidget {
  const SportFieldsScreen({Key? key, required this.sportCat}) : super(key: key);
  final SportCategoryModel sportCat;
  @override
  State<StatefulWidget> createState() {
    return SportFieldsScreenState();
  }
}

class SportFieldsScreenState extends State<SportFieldsScreen>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 3, vsync: this);
  late PrivateMatchesCubit privateMatchesCubit;
  late PublicMatchesCubit publicMatchesCubit;
  late CoachingsCubit coachingsCubit;

  @override
  void initState() {
    super.initState();
    privateMatchesCubit = PrivateMatchesCubit(context.read<UserCubit>())
      ..getMatches(widget.sportCat.id);
    publicMatchesCubit = PublicMatchesCubit(context.read<UserCubit>())
      ..getMatches(widget.sportCat.id);
    coachingsCubit = CoachingsCubit();
  }

  @override
  void dispose() {
    privateMatchesCubit.close();
    publicMatchesCubit.close();
    coachingsCubit.close();
    super.dispose();
  }

  TabBar get _tabBar => TabBar(
        indicatorColor: AppColors.yellow,
        controller: _tabController,
        labelStyle: AppStyles.mont13Medium,
        tabs: const <Widget>[
          Tab(
            text: 'Private Match',
          ),
          Tab(
            text: 'Public Match',
          ),
          Tab(
            text: 'Coaching',
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final _sport = ModalRoute.of(context)!.settings.arguments as SportCategoryModel;

    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
              Text("${_sport.nameEn}", style: AppStyles.mont27bold),
              const SizedBox(width: 12),
              ClipOval(
                child: MyNetworkImage(
                  picPath: _sport.icon!,
                  width: 30.h,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Image.asset(
              Assets.backBtn,
              height: 21,
            ),
          ),
          actions: [

            IconButton(
              onPressed: () {
         /*       Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MapPage(

                  *//*    privateMatches: privateMatchesCubit.state.matches,
                      publicMatches: publicMatchesCubit.state.matches,
                      coachings: coachingsCubit.state.coachings,*//*
                    ),
                  ),
                );*/
              },
              icon: Image.asset(
                Assets.mapIcon,
                height: 21,
              ),
            ),
          ],
          bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: ColoredBox(
                color: AppColors.purple,
                child: _tabBar,
              ))),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<PrivateMatchesCubit>.value(value: privateMatchesCubit),
          BlocProvider<PublicMatchesCubit>.value(value: publicMatchesCubit),
          BlocProvider<CoachingsCubit>.value(value: coachingsCubit),
        ],
        child: TabBarView(
          controller: _tabController,
          children: [
            PrivateMatches(sport: _sport),
            PublicMatches(sport: _sport),
            const CoachingScreen(),
          ],
        ),
      ),
    );
  }
}
