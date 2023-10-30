import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/models/vehiculo.dart';
import 'package:qrreaderapp/src/pages/descripcion.dart';

import 'dart:async';

import 'package:qrreaderapp/src/pages/lista_inicdentes.dart';
import 'package:qrreaderapp/src/pages/registrar_incidente.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:qrreaderapp/src/pages/lista_inicdentes.dart';

class VehiculoPage extends StatelessWidget {
  Future<Vehiculo> futureVehiculo;

  VehiculoPage(this.futureVehiculo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          "Información del Vehículo",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: FutureBuilder<Vehiculo>(
          future: futureVehiculo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  Center(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(70, 30, 5, 0),
                      children: <Widget>[
                        Descripcion("Placa:",
                            "       ${snapshot.data!.VEH_Placa}\n"),
                        Descripcion("Color:",
                            "       ${snapshot.data!.VEH_Color}\n"),
                        Descripcion("Modelo:",
                            "    ${snapshot.data!.VEH_Modelo}\n"),
                        Descripcion("Marca:",
                            "      ${snapshot.data!.VEH_Marca}\n"),
                        Descripcion(
                            "Conductor:", snapshot.data!.Nombre_Conductor),
                        // Descripcion("ID", snapshot.data.ID_Vehiculo),
                      ],
                    ),
                  ),
                  Center(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 300),
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          textDirection: TextDirection.ltr,
                          children: <Widget>[
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(10.0)),
                              color: Colors.lightBlueAccent,
                              elevation: 5,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 65),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Scanner',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.filter_center_focus,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(10.0)),
                              color: Colors.lightBlueAccent,
                              elevation: 5,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Registrar incidente',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegistrarIncidente(
                                                title: snapshot
                                                    .data!.ID_Vehiculo)));
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(10.0)),
                              color: Colors.lightBlueAccent,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              elevation: 5,
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Lista de Incidentes',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.list_alt_rounded,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ListaIncidentes(
                                           idVehiculo: snapshot.data!.ID_Vehiculo)));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.phone),
          onPressed: () {
            launch('tel://968613222');
          }),
    );
  }
}

//  Navigator.pop(context);
