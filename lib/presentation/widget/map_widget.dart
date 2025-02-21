import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tp_final/bloc/maps/maps_bloc.dart';
import 'package:tp_final/bloc/maps/maps_state.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapsBloc, MapsState>(builder: (context, state) {
      if (state is MapsLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is MapsSuccess) {
        print(state.mapsPoints);

        List<Marker> markers = state.mapsPoints.entries.map((entry) {
          return Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(
              entry.value['lat']?.toDouble() ?? 0.0, 
              entry.value['lng']?.toDouble() ?? 0.0
            ), 
            child: const Icon(
              Icons.location_pin,
              color: Colors.red,
              size: 40.0,
            ),
          );
        }).toList();

        // Déterminer le centre de la carte
        LatLng initialCenter = const LatLng(48.1173, -1.6778); // Coordonnées par défaut (Rennes)
        double initialZoom = 10.0; // Zoom par défaut
        
        if (markers.length == 1) {
          initialCenter = markers.first.point; // Centrer sur l'unique point
          initialZoom = 15.0; // Zoom plus proche
        }

        return SizedBox(
          height: 300,
          child: FlutterMap(
            options: MapOptions(
              initialCenter: initialCenter,
              initialZoom: initialZoom,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(markers: markers),
            ],
          ),
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
