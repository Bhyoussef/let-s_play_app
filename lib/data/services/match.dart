import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lets_play/data/core/errors/failures.dart';
import 'package:lets_play/features/home_screen/public_matches_show_all/models/matchesResultModel.dart';
import 'package:lets_play/models/server/match_model.dart';
import '../../main.dart';

Future<Either<Failure, MatchModel>> matchDetails({required int matchId}) async {
  try {
    Response response = await myDio.instance.get('matches/details/$matchId');

    if (response.statusCode == 200) {
      var match = formatMatchModel(response.data);

      return Right(match);
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    print('error parsing : $e');
    return Left(ServerFailure());
  }
}

Future<Either<Failure, MatchResultModel>> fetchAvailablePublicMatches(
    {required double latitude, required double longitude, int page = 1}) async {
  try {
    Response response = await myDio.instance.post('matches/public/?page=$page', queryParameters: {
      'latitude': latitude,
      'longitude': longitude,
    });

    if (response.statusCode == 200) {
      return Right(formatMatchResultModel(response.data['matches']));
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    print('error parsing : $e');
    return Left(ServerFailure());
  }
}

Future<Either<Failure, Map<String, dynamic>>> joinMatch(
    {required int matchId, required int teamId, required int position}) async {
  try {
    Response response = await myDio.instance.post(
      '/matches/join',
      data: {
        'match_id': matchId,
        'team_id': teamId,
        'position': position,
      },
    );

    if (response.statusCode == 201) {
      return Right(Map.from(response.data));
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    print('error parsing : $e');
    return Left(ServerFailure());
  }
}

Future<Either<Failure, Map<String, dynamic>>> invitePlayerToMatch(
    {required int playerId,
    required int matchId,
    required int teamId,
    required int position}) async {
  try {
    Response response = await myDio.instance.post(
      '/matches/invitation',
      data: {
        'match_id': matchId,
        'team_id': teamId,
        'position': position,
        'user_id': playerId,
      },
    );

    if (response.statusCode == 201) {
      return Right(Map.from(response.data));
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    print('error parsing : $e');
    return Left(ServerFailure());
  }
}

Future<Either<Failure, Map<String, dynamic>>> rejectInvite({
  required int matchId,
}) async {
  try {
    Response response = await myDio.instance.post(
      '/matches/invitation/cancel/$matchId',
    );

    if (response.statusCode == 201) {
      return Right(Map.from(response.data));
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    print('error parsing : $e');
    return Left(ServerFailure());
  }
}

Future<Either<Failure, Map<String, dynamic>>> creatorCancelsAPendingPlayer({
  required int matchId,
  required int playerId,
}) async {
  try {
    Response response = await myDio.instance
        .post('/matches/participant/cancel/$matchId', data: {"player": playerId});

    if (response.statusCode == 201) {
      return Right(Map.from(response.data));
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    print('error parsing : $e');
    return Left(ServerFailure());
  }
}

Future<Either<Failure, List<MatchModel>>> getScorableMatches() async {
  try {
    Response response = await myDio.instance.get('/matches/score');

    if (response.statusCode == 200) {
      final items = List.from(response.data['data']).map(formatMatchModel).toList();
      return Right(items);
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    print('error parsing : $e');
    return Left(ServerFailure());
  }
}

Future<Either<Failure, bool>> sendMatchesScores({
  required int matchId,
  required List sets,
}) async {
  try {
    Response response = await myDio.instance.post('/matches/add-score', data: {
      "match_id": matchId,
      "sets": sets,
    });

    if (response.statusCode == 201) {
      return const Right(true);
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    print('error parsing : $e');
    return Left(ServerFailure());
  }
}
