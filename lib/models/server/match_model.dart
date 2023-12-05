import 'package:lets_play/common/constants/constants.dart';
import 'package:lets_play/common/extensions/string_extensions.dart';
import 'package:lets_play/models/server/playground_model.dart';
import '../../features/pick_teams/models/player_model.dart';
import '../enums/public_private_type.dart';
import '../sport_category_model.dart';

class MatchModel {
  MatchModel({
    this.id,
    this.type,
    this.startDate,
    this.endDate,
    this.playersPerTeam,
    this.price,
    this.duration,
    this.pgNameEn,
    this.pgNameAr,
    this.sportCat,
    required this.position,
    this.fromUserDistance,
    this.playground,
    this.isCreator,
    this.isParticipating,
    this.isInvited,
    this.teamAId,
    this.teamBId,
    this.roomId,
    this.isChatJoined,
  });
  late final int? id;
  late final List<PlayerModel?> position;
  late final PublicPrivateType? type;
  late final DateTime? startDate;
  late final DateTime? endDate;
  late final int? playersPerTeam;
  late final num? price;
  late final int? duration;
  late final String? pgNameEn;
  late final String? pgNameAr;
  late final SportCategoryModel? sportCat;
  late final double? fromUserDistance;
  late final PlaygroundModel? playground;
  late final bool? isCreator;
  late final bool? isParticipating;
  late final bool? isInvited;
  late final int? teamAId;
  late final int? teamBId;
  late final int? roomId; // for Chat
  late final bool? isChatJoined;
}

// List<PlayerModel?> items = [];
//   if (map['position'] != null) {
//     for (final player in jsonDecode(map['position'])) {
//       if (player != null) {
//         items.add(formatPlayer(player));
//       } else {
//         items.add(null);
//       }
//     }
//   }
MatchModel formatMatchModel(map) {
  final List<PlayerModel?> allPlayers = [];
  final List<PlayerModel?> arrangedPLayers = List.from(emptyPlayersSpotsArray);
  if (map['teams'] != null) {
    if (map['teams'][0]['participants'] != null) {
      for (final team in map['teams']) {
        for (final player in team['participants']) {
          allPlayers.add(formatPlayerFromParticipantJson(player));
        }
      }
      for (var i = 0; i < arrangedPLayers.length; i++) {
        for (var j = 0; j < allPlayers.length; j++) {
          if (i == allPlayers[j]!.fieldPosition) {
            arrangedPLayers[i] = allPlayers[j];
          }
        }
      }
    }
  }
  return MatchModel(
    id: map['id'],
    type: formatPublicPrivate(map['type']),
    position: arrangedPLayers,
    startDate: (map['start_date'] ?? map['start_at']).toString().defaultFomatToDateTime(),
    endDate: map['end_date'] != null ? map['end_date'].toString().defaultFomatToDateTime() : null,
    playersPerTeam: (map['category_number_player'] != null)
        ? map['category_number_player']['players_count']
        : null,
    price: map['price'],
    duration: map['category_duration'] != null ? map['category_duration']['duration'] : null,
    fromUserDistance: map['distance'],
    sportCat: map['category'] != null ? formatSportCategory(map['category']) : null,
    pgNameEn: map['en_name'],
    pgNameAr: map['ar_name'],
    playground: map['playground'] != null ? PlaygroundModel.fromJson(map['playground']) : null,
    isCreator: map['isCreator'],
    isInvited: map['isInvited'],
    isParticipating: map['isParticipating'],
    teamAId: map['teams'] != null ? map['teams'][0]['id'] : null,
    teamBId: map['teams'] != null ? map['teams'][1]['id'] : null,
    roomId: map['room_id'],
    isChatJoined: map['isChatJoined'],
  );
}
