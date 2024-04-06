import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ItineraireVersIUTPage extends StatelessWidget {
  final double iutLatitude = 48.6828;
  final double iutLongitude = 6.1611;
  final Completer<GoogleMapController> _controller = Completer();
  final GlobalKey _mapKey = GlobalKey();

  ItineraireVersIUTPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Itinéraire vers l\'IUT'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GoogleMap(
              key: _mapKey,
              initialCameraPosition: CameraPosition(
                target: LatLng(iutLatitude, iutLongitude),
                zoom: 12,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('iut'),
                  position: LatLng(iutLatitude, iutLongitude),
                  infoWindow: const InfoWindow(
                    title: 'IUT',
                    snippet: 'Institut Universitaire de Technologie',
                  ),
                ),
              },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Distance: XXX km',
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Temps de trajet: XXX min',
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  onPressed: () {
                    _launchMaps();
                  },
                  child: const Text('Voir l\'itinéraire sur Google Maps'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchMaps() async {
    final url =
        'https://www.google.com/maps/dir/?api=1&destination=$iutLatitude,$iutLongitude';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
