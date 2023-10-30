import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/models/Incidente.dart';
import 'package:qrreaderapp/src/pages/descripcion.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class IncidentePage extends StatelessWidget {
  final String? idIncidente;
  final Future<Incidente>? futureIncidente;

  const IncidentePage( {super.key, this.idIncidente, this.futureIncidente});

  @override
  Widget build(BuildContext context) {
    final futureIncidente = fetchIncidente(idIncidente!);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text("Información del Incidente",
            style: TextStyle(
              color: Colors.white,
            )),
      ),
      body: Center(
        child: FutureBuilder<Incidente>(
          future: futureIncidente,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      // ListView(
                      // padding: EdgeInsets.fromLTRB(15, 20, 5, 0),
                      //  mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 50),
                          child: Column(
                            children: <Widget>[
                              Descripcion("Usuario:",
                                  "${snapshot.data!.Usuario_Nombres}\n"),
                              Descripcion("Fecha:",
                                  "${snapshot.data!.ind_Fecha_Incidente}\n"),
                              Descripcion("Descripcion:",
                                  "${snapshot.data!.ind_Descripcion}\n"),
                              Descripcion(
                                  "ESTADO:", "${snapshot.data!.ind_Estado}\n"),
                            ],
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          margin: const EdgeInsets.all(15),
                          elevation: 10,

                          // Dentro de esta propiedad usamos ClipRRect
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),

                            // EL widget hijo que será recortado segun la propiedad anterior
                            child: Column(
                              children: <Widget>[
                                Image.network(
                                  snapshot.data!.ind_Fotografia,
                                  loadingBuilder: (context, child, progress) {
                                    return progress == null
                                        ? child
                                        : const LinearProgressIndicator();
                                  },
                                  fit: BoxFit.cover,
                                  semanticLabel: 'Evidencia del Incidente',
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(" ESTADO  ${snapshot.data!.ind_Estado}"),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              MaterialButton(
                                color: Colors.lightBlue,
                                elevation: 10,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 30),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Regresar',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ]),
                      ],
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Future<Incidente> fetchIncidente(String idIncidente) async {
    final response = await http.get(
        Uri.parse("http://smartcityhyo.tk/api/Incidente/Consultar_Incidentes.php?ID_Incidente=$idIncidente"));

    if (response.statusCode == 200) {
      return Incidente.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error en obtener información del incidente');
    }
  }
}
