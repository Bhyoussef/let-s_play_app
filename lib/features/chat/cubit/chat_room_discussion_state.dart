part of 'chat_room_discussion_cubit.dart';

class ChatRoomDiscussionState extends Equatable {
  final List<types.Message>? roomMessages;
  final MainStatus? mainStatus;
  final CubitOperation? cubitOperation;
  factory ChatRoomDiscussionState.initial() {
    return const ChatRoomDiscussionState(
      roomMessages: [],
      mainStatus: MainStatus.initial,
    );
  }

  const ChatRoomDiscussionState({this.roomMessages, this.mainStatus, this.cubitOperation});

  ChatRoomDiscussionState copyWith({
    List<types.Message>? roomMessages,
    MainStatus? mainStatus,
    CubitOperation? cubitOperation,
  }) {
    return ChatRoomDiscussionState(
      mainStatus: mainStatus ?? this.mainStatus,
      cubitOperation: cubitOperation ?? this.cubitOperation,
      roomMessages: roomMessages ?? this.roomMessages,
    );
  }

  @override
  List<Object?> get props => [roomMessages, mainStatus, cubitOperation];
}
