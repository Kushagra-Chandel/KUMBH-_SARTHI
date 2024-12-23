// TODO Implement this library.import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class KumbhMapScreen extends StatefulWidget {
  const KumbhMapScreen({super.key});

  @override
  _KumbhMapScreenState createState() => _KumbhMapScreenState();
}

class _KumbhMapScreenState extends State<KumbhMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kumbh Mela Map'),
      ),
      body: FlutterMap(
        options: const MapOptions(
          // Example Kumbh Mela coordinates
          minZoom: 15,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          const MarkerLayer(
            markers: [
              Marker(
                point: LatLng(25.4358, 81.8463), // Example coordinates
                width: 80.0,
                height: 80.0,
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red,
                ),
              ),
              Marker(
                point: LatLng(25.4362, 81.8469), // Example coordinates
                width: 80.0,
                height: 80.0,
                child: Icon(
                  Icons.local_hospital,
                  color: Colors.blue,
                ),
              ),
              // Add more markers for other services
            ],
          ),
        ],
      ),
    );
  }
}
