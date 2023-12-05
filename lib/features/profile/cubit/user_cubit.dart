import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lets_play/features/pick_teams/models/player_model.dart';
import 'package:lets_play/models/server/match_model.dart';
import 'package:lets_play/models/server/playground_model.dart';

import '../../../common/constants/storage_contants.dart';
import '../../../main.dart';
import '../../../models/sport_category_model.dart';
import '../../../models/user.dart';
import 'package:lets_play/data/services/auth.dart' as authService;
import 'package:lets_play/data/services/userProfile.dart' as userProfileService;
import 'package:lets_play/data/services/playground.dart' as playgroundService;
import 'package:lets_play/data/services/payment.dart' as paymentService;

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState.initial());
  setProfile({User? user, bool? isAuthed, Position? userPosition}) {
    emit(state.copyWith(
      isAuthed: isAuthed,
      user: user,
      userPosition: userPosition,
    ));
  }

  Future getUserProfile() async {
    try {
      final data = await userProfileService.fetchProfile();
      final User user = formatUser(data);
      setProfile(user: user);
    } catch (e) {
      print(e);
    }
  }

  logout() {
    userBox.delete(StorageConstants.userToken);
    emit(state.copyWith(isAuthed: false));
  }

  Future<bool> checkTokenValidity() async {
    final validToken = await authService.checkAccessTokenValidity();
    return validToken;
  }

  Future getUserFavSports() async {
    try {
      final categoriesList = await userProfileService.fetchUserFavSports();
      final List<SportCategoryModel> sCategories =
          categoriesList.map((e) => formatSportCategory(e['category'])).toList();
      setProfile(user: state.user!.copyWith(favoriteSportCategories: sCategories));
    } catch (e) {
      print(e);
    }
  }

  Future updateFavCategories({required List<int> indexes}) async {
    try {
      final data = await userProfileService.updateFavCategories(indexes: indexes);
    } catch (e) {
      print(e);
    }
  }

  Future changeProfileAvatar({required String pickedAvatarPath}) async {
    try {
      final response =
          await userProfileService.changeProfileAvatar(pickedAvatarPath: pickedAvatarPath);
      setProfile(user: state.user!.copyWith(avatar: response['picture']));
    } catch (e) {
      print(e);
    }
  }

  Future updateProfileInfo({
    required String firstname,
    required String lastname,
    required String email,
    required String gender,
  }) async {
    try {
      EasyLoading.show(dismissOnTap: true);

      await userProfileService.editProfile(
          email: email, firstname: firstname, lastname: lastname, gender: gender);
      final data = await userProfileService.fetchProfile();
      final User updateduser = formatUser(data);
      setProfile(
          user: state.user!.copyWith(
        firstname: updateduser.firstname,
        lastname: updateduser.lastname,
        email: updateduser.email,
        gender: updateduser.gender,
        phone: updateduser.phone,
      ));

      EasyLoading.showSuccess('Profile Updated successfully');
    } catch (e) {
      EasyLoading.showError('Something went wrong');
    }
  }

  Future changePassword({
    required String currentPw,
    required String newPw,
  }) async {
    try {
      EasyLoading.show(dismissOnTap: true);

      await userProfileService.changePassword(
        currentPw: currentPw,
        newPw: newPw,
      );
      EasyLoading.showSuccess('Password changed successfully');
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 401) {
          EasyLoading.showError('Incorrect current password');
        } else {
          EasyLoading.showError('Something went wrong');
        }
      } else {
        EasyLoading.showError('Something went wrong');
      }
    }
  }

  Future getUserFavPlaygrounds() async {
    try {
      final playgroundsList = await userProfileService.fetchUserFavPlaygrounds();
      final List<PlaygroundModel> playgrounds =
          playgroundsList.map((e) => (PlaygroundModel.fromJson(e))).toList();
      setProfile(user: state.user!.copyWith(favoritePlaygrounds: playgrounds));
    } catch (e) {
      print(e);
    }
  }

  Future removeFavoritePlayground({required int playgroundId, bool lastItem = false}) async {
    if (lastItem) {
      await Future.delayed(const Duration(milliseconds: 400));
      setProfile(user: state.user!.copyWith(favoritePlaygrounds: []));
    }
    await playgroundService.setFavourite(playgroundId: playgroundId, isFaved: false);
    getUserFavPlaygrounds();
  }

  Future getUserSavedCards() async {
    try {
      final eitherResponse = await paymentService.getUserPaymentCards();

      eitherResponse.fold((l) => null, (cards) {
        setProfile(user: state.user!.copyWith(savedCards: cards));
      });
    } catch (e) {
      print(e);
    }
  }

  Future removeSavedCard({required String cardToken, bool lastItem = false}) async {
    if (lastItem) {
      await Future.delayed(const Duration(milliseconds: 400));
      setProfile(user: state.user!.copyWith(savedCards: []));
    }
    await paymentService.deleteUserSavedCard(cardToken);
    getUserSavedCards();
  }

  Future getUserEngagementsDetails() async {
    try {
      final multiFetchResponse = await Future.wait([
        userProfileService.fetchUserEngagementCounts(),
        userProfileService.fetchUserSportsEngaged(),
        userProfileService.fetchUserClubsList(),
        userProfileService.fetchUserFrequentPlayersList(),
      ]);
      final List sportsList = multiFetchResponse[1] as List;
      final sports = sportsList.map((e) => formatSportCategory(e)).toList();
      final List clubsList = multiFetchResponse[2] as List;
      final clubs = clubsList.map((e) => PlaygroundModel.fromJson(e)).toList();
      final List playersList = multiFetchResponse[3] as List;
      final players = playersList.map((e) => formatPlayer(e)).toList();
      final Map<String, dynamic> matchesResult = multiFetchResponse[0] as Map<String, dynamic>;
      final UserEngagementCounts engagementCounts = UserEngagementCounts(
        matchesCount: matchesResult['matches'],
        friendsCount: (matchesResult['friends'] as List).length,
        createdMatches: (matchesResult['created_matches']['data'] as List)
            .map((e) => formatMatchModel(e))
            .toList(),
        joinedMatches: (matchesResult['joined_matches']['data'] as List)
            .map((e) => formatMatchModel(e))
            .toList(),
      );
      setProfile(
          user: state.user!.copyWith(
        userEngagementCounts: engagementCounts,
        sportsPlayed: sports,
        clubs: clubs,
        frequentPlayers: players,
      ));
    } catch (e) {
      print(e);
    }
  }
}
