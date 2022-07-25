import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Maps extends StatefulWidget {
  double latitude, longitude;

  // ignore: use_key_in_widget_constructors
  Maps({required this.latitude, required this.longitude});

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final Set<Polyline> polyline = {};

  String google_api_key = "AIzaSyDRXFXG3TkkP2It1Kf2TCSl6KTPutNzbWM";
  GoogleMapController? _controller;

  static const LatLng sourceLocation = LatLng(39.8927, 32.8152);
  static const LatLng destination = LatLng(39.8890, 32.8161);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  Location location = Location();

  void getCurrentLocation() {
    location.getLocation().then((loc) {
      currentLocation = loc;
    });

    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      setState(() {});
    });
  }

  void getPolylines() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    getCurrentLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: currentLocation == null
            ? const Center(child: CircularProgressIndicator())
            : GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    currentLocation!.latitude!,
                    currentLocation!.longitude!,
                  ),
                  zoom: 16,
                ),
                polylines: {
                  Polyline(
                    polylineId: const PolylineId("Route"),
                    points: polylineCoordinates,
                    color: Colors.blue,
                    width: 6,
                  )
                },
                tiltGesturesEnabled: true,
                compassEnabled: true,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                onMapCreated: _onCreateMap,
                markers: {
                  const Marker(
                    markerId: MarkerId("Source"),
                    position: sourceLocation,
                  ),
                  const Marker(
                    markerId: MarkerId("Destinition"),
                    position: destination,
                  ),
                },
              ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Başla"),
              onPressed: () {
                getPolylines();
              },
            ),
            const SizedBox(
              width: 4,
            ),
            ElevatedButton(
              child: Text(calculateDistance(
                      sourceLocation.latitude,
                      sourceLocation.longitude,
                      destination.latitude,
                      destination.longitude)
                  .toString()),
              onPressed: () {},
            ),
          ],
        ));
  }

  void _onCreateMap(GoogleMapController controller) {
    _controller = controller;
    location.onLocationChanged.listen((l) {
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 16),
        ),
      );
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
