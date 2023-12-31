import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  static const CameraPosition _ubicacionInicial = CameraPosition(
    target: LatLng(-0.180653, -78.467834),
    zoom: 14.4746,
  );

  static CameraPosition camPosicionUbicacion = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-0.180653, -78.467834),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: _markers,
        mapType: MapType.normal,
        initialCameraPosition: _ubicacionInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('Mi ubicacion!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    _getUbicacionActual();
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(camPosicionUbicacion));
  }

  Future<void> _getUbicacionActual() async {
    //objeto geolocator que obtendra la ubicaciionactual

    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      setState(() {
        //imprimir la posicion actual en log
        print(position);
        //Actualizar  camera position
        camPosicionUbicacion = CameraPosition(
            bearing: 192.8334901395799,
            target: LatLng(position.latitude, position.longitude),
            tilt: 59.440717697143555,
            zoom: 19.151926040649414);
      });
      //agregar marcador con ubicacion actual
      _markers.add(
        Marker(
          markerId: const MarkerId('newyork'),
          position: LatLng(position.latitude, position.longitude),
        ),
      );
      //crear controller google map
      final GoogleMapController controller = await _controller.future;
      controller
          .animateCamera(CameraUpdate.newCameraPosition(camPosicionUbicacion));
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> _goToNewYork() async {
    double lat = 40.7128;
    double long = -74.0060;
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), 10));
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('Tu ubicacion'),
          position: LatLng(lat, long),
        ),
      );
    });
  }
}
