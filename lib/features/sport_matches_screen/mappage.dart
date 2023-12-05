import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:permission_handler/permission_handler.dart';
/*
class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _controller;
  LocationData? _locationData;

  @override
  void initState() {
    super.initState();
    //_getLocation();
  }

*//*  Future<void> _getLocation() async {
    //final location = Location();
    final hasPermission = await location.requestPermission();
    if (hasPermission == PermissionStatus.granted) {
      final data = await location.getLocation();
      setState(() {
        _locationData = data;
        print(_locationData!.longitude);
        print(_locationData!.latitude);
      });
    }
  }*//*

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ma position'),
      ),
      body: _buildMap(),
    );
  }

  Widget _buildMap() {
*//*    if (_locationData == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }*//*

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(
          _locationData!.latitude!,
          _locationData!.longitude!,
        ),
        zoom: 13.0,
      ),
      myLocationEnabled: true,
      onMapCreated: (controller) => _controller = controller,
    );
  }
}*/
