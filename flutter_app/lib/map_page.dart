import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Using Google Maps Flutter for displaying the map

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  final String mapboxAccessToken = 'sk.eyJ1Ijoic3JpZ293cmktMTMiLCJhIjoiY2x4N2oxNmsyMDEweDJxcjRjdGVwNmh1ZSJ9.XwIjR1v-MOiBLfkoQ-6-Nw';
  final String searchEndpoint = 'https://api.mapbox.com/search/searchbox/v1/forward';
  final String searchKeyword = 'therapist';
  Position? _currentPosition;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
if (!serviceEnabled) {
  return Future.error('Location services are disabled.');
}

permission = await Geolocator.checkPermission();
if (permission == LocationPermission.denied) {
  permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.denied) {
    return Future.error('Location permissions are denied.');
  }
}

if (permission == LocationPermission.deniedForever) {
  return Future.error('Location permissions are permanently denied.');
}

Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
setState(() {
  _currentPosition = position;
});
_fetchNearbyPlaces(position);
  }

  Future<void> _fetchNearbyPlaces(Position position) async {
    final location = '${position.longitude},${position.latitude}';
    final url = '$searchEndpoint?q=$searchKeyword&proximity=$location&access_token=$mapboxAccessToken';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
  final data = json.decode(response.body);
  _addMarkers(data['features']);
} else {
  setState(() {
    _currentPosition = null;
  });
}
  }

  void _addMarkers(List features) {
    for (var feature in features) {
      final lat = feature['geometry']['coordinates'][1];
      final lng = feature['geometry']['coordinates'][0];
      final marker = Marker(
        markerId: MarkerId(feature['id']),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: feature['text'],
          snippet: feature['place_name'],
        ),
      );
      setState(() {
        _markers.add(marker);
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Therapists'),
      ),
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                zoom: 14.0,
              ),
              markers: _markers,
            ),
    );
  }
}
