import 'package:flutter/material.dart';

import '../../../common/constants/constants.dart';

class MapImage extends StatelessWidget {
  const MapImage({
    Key? key,
    this.latitude,
    this.longitude,
  }) : super(key: key);
  final double? latitude;
  final double? longitude;

  @override
  Widget build(BuildContext context) {
    var imageUrl =
        "https://maps.googleapis.com/maps/api/staticmap?size=540x180&path=color:0x4f80ff&key=$GOOGLE_MAP_KEY";
    imageUrl +=
    "&markers=scale:3|icon:https://img.icons8.com/external-tanah-basah-glyph-tanah-basah/2x/external-map-marker-user-interface-tanah-basah-glyph-tanah-basah.png|$latitude, $longitude";

    return SizedBox(
      height: 133,
      child: Image.network(imageUrl),
    );
  }
}
