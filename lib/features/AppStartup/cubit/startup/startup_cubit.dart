import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lets_play/main.dart';

import '../../../../common/constants/storage_contants.dart';
import '../../../../utils/geoLocation.dart';
import '../../../profile/cubit/user_cubit.dart';
import '../utility/utility_cubit.dart';

part 'startup_state.dart';

class StartupCubit extends Cubit<StartupState> {
  StartupCubit({
    required this.utilityCubit,
    required this.userCubit,
  }) : super(StartupState.initial());
  final UserCubit userCubit;
  final UtilityCubit utilityCubit;

  initializeApp() async {
    print('print app initializer');
    Position? userPosition;
    //internet checker
    try {
      await InternetAddress.lookup('google.com');
    } catch (_) {
      emit(state.copyWith(
        notification: NotificationType.noInternet,
      ));
      return;
    }

    // auth checker
    try {
      if (userBox.get(StorageConstants.userToken) != null) {
        final validToken = await userCubit.checkTokenValidity();
        if (validToken) {
          await userCubit.getUserProfile();
          userPosition = await GeoUtils.getPositionIfEnabled();
          userCubit.setProfile(isAuthed: true, userPosition: userPosition);
          await Future.wait([
            userCubit.getUserFavSports(),
            userCubit.getUserFavPlaygrounds(),
            userCubit.getUserSavedCards(),
            userCubit.getUserEngagementsDetails(),
          ]);
        } else {
          userCubit.logout();
        }
      }
    } catch (_) {
      userCubit.logout();
    }

    // unawaited startup fetches
    utilityCubit.getSportCategoriesList();

    emit(state.copyWith(
        showSplash: false, isAuthed: userCubit.state.isAuthed, isLocated: userPosition != null));
  }
}
