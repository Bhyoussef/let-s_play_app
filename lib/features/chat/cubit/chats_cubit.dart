import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_play/features/pick_teams/models/player_model.dart';
import 'package:lets_play/models/mainStatus.dart';
import 'package:lets_play/models/server/match_model.dart';
import 'package:lets_play/data/services/chat.dart' as chatService;
import 'package:lets_play/services/kiwi_container.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../data/core/errors/failures.dart';
part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(ChatsState.initial());
  late PusherChannelsFlutter pusher;
  Future getMatchesChatRooms() async {
    final Either<Failure, List<MatchModel>> response = await chatService.getMatchesChatRooms();

    emit(response.fold(
        (Failure failure) => state.copyWith(mainStatus: MainStatus.failure),
        (List<MatchModel> matchRooms) =>
            state.copyWith(matchRooms: matchRooms, mainStatus: MainStatus.loaded)));
  }

  Future getFriendsChatRooms() async {
    final Either<Failure, List<PlayerModel>> response = await chatService.getFriendsChatRooms();

    emit(response.fold(
        (Failure failure) => state.copyWith(mainStatus: MainStatus.failure),
        (List<PlayerModel> friendRooms) =>
            state.copyWith(friendRooms: friendRooms, mainStatus: MainStatus.loaded)));
  }

  Future getAllChatRooms() async {
    await Future.wait([
      getMatchesChatRooms(),
      getFriendsChatRooms(),
    ]);
  }

  initializePusher() async {
    pusher = container.resolve<PusherChannelsFlutter>();
    int tries = 0;
    bool isConnected = false;
    await pusher.init(
      apiKey: '6f5a5569d1697cc923ae',
      cluster: 'ap2',
      onEvent: (event) {},
    );
    do {
      await pusher.connect();
      isConnected = pusher.connectionState == "CONNECTED";
      tries++;
    } while (!isConnected && tries < 100);
    log(tries.toString());
    log(isConnected.toString());
  }

  Future leaveChatMatch({required int roomId}) async {
    final result = await chatService.leaveChatRoom(roomId: roomId);
    result.fold((l) => {}, (r) => {getMatchesChatRooms()});
  }
}
