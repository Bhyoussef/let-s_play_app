part of 'user_cubit.dart';

class UserState extends Equatable {
  const UserState({this.user, this.isAuthed, this.userPosition});
  final User? user;
  final bool? isAuthed;
  final Position? userPosition;
  factory UserState.initial() {
    return const UserState(
      isAuthed: false,
    );
  }

  UserState copyWith({
    User? user,
    bool? isAuthed,
    Position? userPosition,
  }) {
    return UserState(
      user: user ?? this.user,
      isAuthed: isAuthed ?? this.isAuthed,
      userPosition: userPosition ?? this.userPosition,
    );
  }

  @override
  List<Object?> get props => [user, isAuthed, userPosition];
}
