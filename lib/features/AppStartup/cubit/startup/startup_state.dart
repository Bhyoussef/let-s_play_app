part of 'startup_cubit.dart';

enum NotificationType {
  noInternet,
  serverMaintenance,
  appUpdate,
}

class StartupState extends Equatable {
  final bool? showSplash;
  final bool? isAuthed;
  final bool? isLocated;

  final NotificationType? notification;
  factory StartupState.initial() {
    return const StartupState(
      notification: null,
      showSplash: true,
      isAuthed: false,
      isLocated: false,
    );
  }

  const StartupState(
      {this.isLocated, this.showSplash, this.notification, this.isAuthed});

  StartupState copyWith({
    final bool? showSplash,
    final bool? isAuthed,
    final bool? isLocated,
    final NotificationType? notification,
  }) {
    return StartupState(
      showSplash: showSplash ?? this.showSplash,
      isAuthed: isAuthed ?? this.isAuthed,
      isLocated: isLocated ?? this.isLocated,
      notification: notification,
    );
  }

  @override
  List<Object?> get props => [showSplash, notification, isAuthed, isLocated];
}
