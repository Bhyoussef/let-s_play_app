part of 'chats_cubit.dart';

class ChatsState extends Equatable {
  final List<MatchModel>? matchRooms;
  final List<PlayerModel>? friendRooms;
  final MainStatus? mainStatus;
  final CubitOperation? cubitOperation;
  factory ChatsState.initial() {
    return const ChatsState(
      matchRooms: [],
      friendRooms: [],
      mainStatus: MainStatus.initial,
    );
  }

  const ChatsState({
    this.matchRooms,
    this.friendRooms,
    this.mainStatus,
    this.cubitOperation,
  });

  ChatsState copyWith({
    List<MatchModel>? matchRooms,
    List<PlayerModel>? friendRooms,
    MainStatus? mainStatus,
    CubitOperation? cubitOperation,
  }) {
    return ChatsState(
      mainStatus: mainStatus ?? this.mainStatus,
      cubitOperation: cubitOperation ?? this.cubitOperation,
      matchRooms: matchRooms ?? this.matchRooms,
      friendRooms: friendRooms ?? this.friendRooms,
    );
  }

  @override
  List<Object?> get props => [friendRooms, matchRooms, mainStatus, cubitOperation];
}
