import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lets_play/features/create_match/models/DurationModel.dart';
import 'package:lets_play/features/pick_teams/models/player_model.dart';
import '../../main.dart';
import '../core/errors/failures.dart';

Future<Either<Failure, SettingsModel>> getCreateMatchSettings({required int sportId}) async {
  try {
    Response response = await myDio.instance.get('/matches/create/settings/$sportId');

    if (response.statusCode == 200) {
      var item = SettingsModel.fromJson(response.data);
      return Right(item);
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    return Left(ServerFailure());
  }
}

Future<Either<Failure, bool>> checkCreateMatchPgAvailability({
  required int playgroundId,
  required int durationId,
  required String dateTime,
}) async {
  try {
    Response response = await myDio.instance.post('/matches/available-playground', data: {
      "start_at": dateTime,
      "duration_id": durationId,
      "playground_id": playgroundId,
    });

    if (response.statusCode == 200) {
      return Right(response.data['playground']);
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    return Left(ServerFailure());
  }
}

Future<Either<Failure, List<PlayerModel>>> getListPlayers({String? searchTerm}) async {
  try {
    Response response = await myDio.instance.get(
      '/matches/players',
      queryParameters: {
        if (searchTerm != null) 'search': searchTerm,
      },
    );

    if (response.statusCode == 200) {
      var items = List.from(response.data).map((e) => formatPlayer(e)).toList();
      return Right(items);
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    return Left(ServerFailure());
  }
}

Future<Either<Failure, Map<String, dynamic>>> createMatch(
    {required Map<String, dynamic> params}) async {
  try {
    Response response = await myDio.instance.post('/matches/create', data: params);

    if (response.statusCode == 201) {
      var map = Map<String, dynamic>.from(response.data);
      return Right(map);
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    return Left(ServerFailure());
  }
}
