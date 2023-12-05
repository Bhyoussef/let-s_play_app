import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:maps_launcher/maps_launcher.dart';

class PlaygroundUtils {
  static Future callNumber(number) async {
    try {
      await FlutterPhoneDirectCaller.callNumber(number);
    } catch (e) {
      print(e);
    }
  }

  static Future launchMap(double latitude, double longitude) async {
    try {
      MapsLauncher.launchCoordinates(latitude, longitude);
    } catch (e) {
      print(e);
    }
  }
}
