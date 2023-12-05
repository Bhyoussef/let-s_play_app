import 'package:flutter/material.dart';

import '../features/pick_teams/models/player_model.dart';
import '../features/pick_teams/widgets/badminton_field_style.dart';
import '../features/pick_teams/widgets/basketball_field_style.dart';
import '../features/pick_teams/widgets/football_11p_field_style.dart';
import '../features/pick_teams/widgets/football_7p_field_style.dart';
import '../features/pick_teams/widgets/padbol_field_style.dart';
import '../features/pick_teams/widgets/padel_field_style.dart';
import '../features/pick_teams/widgets/squash_field_style.dart';
import '../features/pick_teams/widgets/tennis_1p_field_style.dart';
import '../features/pick_teams/widgets/tennis_2p_field_style.dart';
import '../features/pick_teams/widgets/volleyball_field_style.dart';
import '../models/enums/sport_type.dart';

class MatchFieldsUtils {
  static Widget getFieldFromSportAndPLayerCount({
    required SportType sportType,
    required int playerCount,
    required List<PlayerModel?> listFilledUsers,
    required Function(int) callback,
  }) {
    switch (sportType) {
      case SportType.football:
        return playerCount == 7
            ? Football7PFieldStyle(
                callback: callback,
                listFilledUsers: listFilledUsers,
              )
            : Football11PFieldStyle(
                callback: callback,
                listFilledUsers: listFilledUsers,
              );
      case SportType.basketball:
        return BasketBallFieldStyle(
          callback: callback,
          listFilledUsers: listFilledUsers,
        );
      case SportType.volleyball:
        return VolleyBallFieldStyle(
          callback: callback,
          listFilledUsers: listFilledUsers,
        );

      case SportType.tennis:
        return playerCount == 1
            ? Tennis1PFieldStyle(
                callback: callback,
                listFilledUsers: listFilledUsers,
              )
            : Tennis2PFieldStyle(
                callback: callback,
                listFilledUsers: listFilledUsers,
              );

      case SportType.squash:
        return SquashFieldStyle(
          callback: callback,
          listFilledUsers: listFilledUsers,
        );

      case SportType.padel:
        return PadelFieldStyle(
          callback: callback,
          listFilledUsers: listFilledUsers,
        );

      case SportType.padbol:
        return PadbolFieldStyle(
          callback: callback,
          listFilledUsers: listFilledUsers,
        );

      case SportType.badminton:
        return BadmintonFieldStyle(
          callback: callback,
          listFilledUsers: listFilledUsers,
        );
    }
  }
}
