// This is where all your instances and factories are stored
// ignore: import_of_legacy_library_into_null_safe
import 'package:kiwi/kiwi.dart';
import 'package:lets_play/services/date_time_service.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

KiwiContainer container = KiwiContainer();

/// register IoC instances
void setupKiwiContainer() {
  container.registerSingleton((KiwiContainer container) => DateTimeService());
  container.registerSingleton((KiwiContainer container) => PusherChannelsFlutter.getInstance());
}
