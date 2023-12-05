import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lets_play/data/core/errors/failures.dart';
import 'package:lets_play/features/pick_teams/models/player_model.dart';
import 'package:lets_play/models/server/match_model.dart';
import '../../main.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

Future<Either<Failure, List<MatchModel>>> getMatchesChatRooms() async {
  try {
    Response response = await myDio.instance.get('rooms');

    if (response.statusCode == 200) {
      final items = List.from(response.data).map(formatMatchModel).toList();
      return Right(items);
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    print('error parsing : $e');
    return Left(ServerFailure());
  }
}

Future<Either<Failure, List<types.Message>>> getMatchRoomMessages(int matchId) async {
  try {
    Response response = await myDio.instance.get('rooms/$matchId');

    if (response.statusCode == 200) {
      final items = List.from(response.data)
          .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(items);
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    print('error parsing : $e');
    return Left(ServerFailure());
  }
}

Future<Either<Failure, bool>> sendMatchMessage(
    {required String message, required int roomId}) async {
  try {
    Response response = await myDio.instance.post(
      'rooms/send-message',
      data: {"message": message, "room_id": roomId},
    );

    if (response.statusCode == 200) {
      return const Right(true);
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    print('error parsing : $e');
    return Left(ServerFailure());
  }
}

Future<Either<Failure, List<PlayerModel>>> getFriendsChatRooms() async {
  try {
    Response response = await myDio.instance.get('friend_messages');

    if (response.statusCode == 200) {
      final items = List.from(response.data).map(formatPlayer).toList();
      return Right(items);
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    print('error parsing : $e');
    return Left(ServerFailure());
  }
}

Future<Either<Failure, List<types.Message>>> getFriendRoomMessages(int roomId) async {
  try {
    Response response = await myDio.instance.get('friend_messages/latest/$roomId');
    if (response.statusCode == 200) {
      final items = List.from(response.data)
          .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(items);
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    print('error parsing : $e');
    return Left(ServerFailure());
  }
}

Future<Either<Failure, bool>> sendFriendMessage(
    {required String message, required int roomId}) async {
  try {
    Response response = await myDio.instance.post(
      'friend_messages/send',
      data: {"message": message, "room_id": roomId},
    );

    if (response.statusCode == 200) {
      return const Right(true);
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    print('error parsing : $e');
    return Left(ServerFailure());
  }
}

Future<Either<Failure, bool>> joinChatRoom({required int roomId}) async {
  try {
    Response response = await myDio.instance.post('rooms/join/$roomId');

    if (response.statusCode == 200) {
      return const Right(true);
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    print('error parsing : $e');
    return Left(ServerFailure());
  }
}

Future<Either<Failure, bool>> leaveChatRoom({required int roomId}) async {
  try {
    Response response = await myDio.instance.post('rooms/leave/$roomId');

    if (response.statusCode == 200) {
      return const Right(true);
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    print('error parsing : $e');
    return Left(ServerFailure());
  }
}
