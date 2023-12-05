import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../common/components/MyNetworkImage.dart';
import '../../common/constants/assets_images.dart';
import '../../models/local/coaching_model.dart';
import '../../models/server/match_model.dart';

class NearbyFieldsScreen extends StatelessWidget {
  const NearbyFieldsScreen({
    Key? key,
    required this.privateMatches,
    required this.publicMatches,
    required this.coachings,
  }) : super(key: key);

  final List<MatchModel> privateMatches;
  final List<MatchModel> publicMatches;
  final List<CoachingModel> coachings;



@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
        title: Row(
          children: [
            Text(""),

          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Image.asset(
            Assets.backBtn,
            height: 21,
          ),
        ),
        actions: [

          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => NearbyFieldsScreen(privateMatches: [], publicMatches: [], coachings: [],
                    /*    privateMatches: privateMatchesCubit.state.matches,
                      publicMatches: publicMatchesCubit.state.matches,
                      coachings: coachingsCubit.state.coachings,*/
                  ),
                ),
              );
            },
            icon: Image.asset(
              Assets.mapIcon,
              height: 21,
            ),
          ),
        ],
        ),
    body: GoogleMap(
      initialCameraPosition: CameraPosition(
        target: const LatLng(37.7749, -122.4194), // San Francisco
        zoom: 12,
      ),
      /*markers: {
        for (final match in privateMatches)
          Marker(
            markerId: MarkerId(match.id.toString()),
            position: LatLng(match.playground!.latitude as double, match.playground!.longitude as double),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueViolet,
            ),
            infoWindow: InfoWindow(
              title: match.pgNameAr,
              snippet: 'Private Match',
            ),
          ),
        for (final match in publicMatches)
          Marker(
            markerId: MarkerId(match.id.toString()),
            position: LatLng(match.playground!.latitude as double,
                match.playground!.longitude as double),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
            infoWindow: InfoWindow(
              title: match.pgNameEn,
              snippet: 'Public Match',
            ),
          ),
        for (final coaching in coachings)
          Marker(
            markerId: MarkerId(coaching.id.toString()),
           // position: LatLng(coaching., coaching.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen,
            ),
            infoWindow: InfoWindow(
              title: coaching.name,
              snippet: 'Coaching',
            ),
          ),
      },*/
    ),
  );
}
}
