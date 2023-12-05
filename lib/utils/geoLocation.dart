import 'package:geolocator/geolocator.dart';

class GeoUtils {
  static Future<Position?> getPositionIfEnabled() async {
    try {
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      return null;
    }
  }
}
