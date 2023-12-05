import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lets_play/features/pick_teams/models/player_model.dart';
import 'package:lets_play/models/mainStatus.dart';
import 'package:lets_play/models/server/match_model.dart';
import 'package:lets_play/data/services/chat.dart' as chatService;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:lets_play/models/user.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../data/core/errors/failures.dart';
import '../../../services/kiwi_container.dart';

part 'chat_room_discussion_state.dart';

enum ChatModelType { match, friend }

class ChatRoomDiscussionCubit extends Cubit<ChatRoomDiscussionState> {
  final MatchModel? match;
  final PlayerModel? friend;
  final User meUser;
  ChatRoomDiscussionCubit({required this.friend, required this.meUser, required this.match})
      : super(ChatRoomDiscussionState.initial());
  final TextEditingController chatController = TextEditingController();
  final pusher = container.resolve<PusherChannelsFlutter>();

  ChatModelType get chatModelType => match != null ? ChatModelType.match : ChatModelType.friend;

  getRoomMessages() {
    inspect(match);
    if (chatModelType == ChatModelType.match) {
      getMatchRoomMessages();
    } else {
      getFriendRoomMessages();
    }
  }

  Future getMatchRoomMessages() async {
    final Either<Failure, List<types.Message>> response =
        await chatService.getMatchRoomMessages(match!.roomId!);
    emit(response.fold(
        (Failure failure) => state.copyWith(mainStatus: MainStatus.failure),
        (List<types.Message> roomMessages) =>
            state.copyWith(roomMessages: roomMessages, mainStatus: MainStatus.loaded)));
  }

  Future getFriendRoomMessages() async {
    final Either<Failure, List<types.Message>> response =
        await chatService.getFriendRoomMessages(friend!.roomId!);
    emit(response.fold(
        (Failure failure) => state.copyWith(mainStatus: MainStatus.failure),
        (List<types.Message> roomMessages) =>
            state.copyWith(roomMessages: roomMessages, mainStatus: MainStatus.loaded)));
  }

  handleSendPressed() async {
    if (chatController.text.trim().isNotEmpty) {
      final _chatUser = types.User(id: meUser.id.toString(), imageUrl: meUser.avatar);

      final textMessage = types.TextMessage(
        author: _chatUser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: chatController.text,
      );

      emit(state.copyWith(roomMessages: [textMessage, ...state.roomMessages!]));
      chatController.clear();
      if (chatModelType == ChatModelType.match) {
        await chatService.sendMatchMessage(
          roomId: match!.roomId!,
          message: textMessage.text,
        );
      } else {
        await chatService.sendFriendMessage(
          roomId: friend!.roomId!,
          message: textMessage.text,
        );
      }
    }
  }

  initializePusherChannel() async {
    final channelName =
        'chat.${chatModelType == ChatModelType.match ? match!.roomId : friend!.roomId}';
    log(channelName + 'subbed');
    await pusher.subscribe(
      channelName: channelName,
      onMemberAdded: (member) {
        print("Member added: $member");
      },
      onMemberRemoved: (member) {
        print("Member removed: $member");
      },
      onEvent: (event) {
        inspect(event);
        _handleOnSocketMessageReceived(event);
      },
    );
  }

  @override
  Future<void> close() async {
    final channelName =
        'chat.${chatModelType == ChatModelType.match ? match!.roomId : friend!.roomId}';
    log(channelName + 'unsubscribe');

    await pusher.unsubscribe(channelName: channelName);
    return super.close();
  }

  void _handleOnSocketMessageReceived(event) {
    final message = types.TextMessage.fromJson(json.decode(event.data)['message']);
    inspect(message);
    final isfromMe = message.author.id == meUser.id.toString();
    if (!isfromMe) {
      emit(state.copyWith(roomMessages: [message, ...state.roomMessages!]));
    }
  }
}
