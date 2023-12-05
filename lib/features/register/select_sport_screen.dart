import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lets_play/common/components/app_bar/app_bar_with_back_btn.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/data/core/http/api_constants.dart';
import 'package:lets_play/features/AppStartup/cubit/utility/utility_cubit.dart';
import 'package:lets_play/routes/routes_list.dart';

import '../../utils/geoLocation.dart';
import '../landing/cubit/auth_cubit.dart';
import '../profile/cubit/user_cubit.dart';

class SelectSportScreen extends StatefulWidget {
  const SelectSportScreen({Key? key, this.isUpdate = false}) : super(key: key);
  final bool isUpdate;
  @override
  State<SelectSportScreen> createState() => _SelectSportScreenState();
}

class _SelectSportScreenState extends State<SelectSportScreen> {
  late bool isUpdate;
  @override
  void initState() {
    super.initState();
    isUpdate = widget.isUpdate;
    if (isUpdate) _fillPreSelected();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _fillPreSelected() {
    final user = context.read<UserCubit>().state.user!;
    for (var favCat in user.favoriteSportCategories!) {
      _selectSport(favCat.id);
    }
  }

  final Set<int> _selectedSports = {};

  void _selectSport(int index) {
    if (_selectedSports.contains(index)) {
      _selectedSports.remove(index);
      return;
    }
    _selectedSports.add(index);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future<bool>.value(isUpdate),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: isUpdate
            ? appBarWithBackBtn(context: context, title: '')
            : AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
              ),
        body: SafeArea(
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) async {
              if (state is AuthInitial) {
                EasyLoading.show(dismissOnTap: false);
              }

              if (state is SuccessFavCategoriesUpdatedState) {
                if (isUpdate == false) {
                  EasyLoading.dismiss();
                  final userPosition = await GeoUtils.getPositionIfEnabled();
                  if (userPosition != null) {
                    final userCubit = context.read<UserCubit>();
                    userCubit.setProfile(isAuthed: true, userPosition: userPosition);
                    Navigator.pushReplacementNamed(context, RouteList.homeBottomTabbar);
                  } else {
                    Navigator.pushReplacementNamed(context, RouteList.enableLocation);
                  }
                } else {
                  EasyLoading.dismiss();
                  EasyLoading.showSuccess('Preferences saved');
                  await Future.delayed(const Duration(seconds: 3));
                  Navigator.pop(context);
                }
              }
              if (state is ErrorState) {
                EasyLoading.dismiss();
                EasyLoading.showError(state.error);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Select your favorite sports?",
                  style:
                      TextStyle(color: AppColors.purple, fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(child: BlocBuilder<UtilityCubit, UtilityState>(
                  builder: (context, state) {
                    return ListView.separated(
                      itemCount: state.sCategoriesList!.length,
                      itemBuilder: ((context, index) {
                        var _sport = state.sCategoriesList![index];
                        return InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              _selectSport(_sport.id);
                            });
                          },
                          child: Container(
                            decoration: _selectedSports.contains(_sport.id)
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(width: 2, color: const Color(0xFF511E9B)))
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: const Color(0xFFDCDFE6))),
                            height: 56,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Image.network(
                                      ApiConstants.imageUrl + _sport.icon!,
                                      height: 40,
                                      width: 40,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Text(
                                    _sport.nameEn!,
                                    style: const TextStyle(color: Color(0xFF11002B), fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      separatorBuilder: ((context, index) {
                        return const SizedBox(
                          height: 16,
                        );
                      }),
                    );
                  },
                )),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () {
                      print(_selectedSports.toList());
                      if (_selectedSports.isNotEmpty) {
                        context.read<AuthCubit>().updateUserFavCategories(
                            indexes: _selectedSports.toList(), isUpdate: isUpdate);
                      }
                    },
                    child: Text(
                      isUpdate ? 'Save' : 'Next',
                      style: AppStyles.largeButtonTextStyle,
                    ),
                    style: AppStyles.elevatedButtonDefaultStyle),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
