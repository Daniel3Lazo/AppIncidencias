import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/models/Incidente.dart';

import 'package:http/http.dart' as http;
import 'package:qrreaderapp/src/pages/incidente_page.dart';

class ListaIncidentes extends StatelessWidget {
 final String idVehiculo;

  const ListaIncidentes({super.key, required this.idVehiculo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListIncidentesSreen(idVehiculo));
  }
}

class ListIncidentesSreen extends StatefulWidget {
  final String idvehiculo;
  const ListIncidentesSreen(this.idvehiculo, {super.key});
  @override
  createState() => _ListIncidentesSreen(idvehiculo);
}

class _ListIncidentesSreen extends State {
  var incidentes = [];
  String idvehiculo;

  _ListIncidentesSreen(this.idvehiculo);
  _getIncidentes() async {
    var url =
        "http://smartcityhyo.tk/api/Incidente/Consultar_Incidente_Fecha.php?ID_Vehiculo=$idvehiculo";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body)['records'];
      incidentes = list.map((model) => Incidente.fromJson(model)).toList();
      // print(incidentes[0].Usuario_Nombres);  por el momneto para porbar setstate
    }
    setState(() {
      print(incidentes[0].Usuario_Nombres);
    });
    await Future.delayed(const Duration(seconds: 1));
    return null;
  }

  @override
  initState() {
    super.initState();
    _getIncidentes();
  }

  @override
  dispose() {
    super.dispose();
  }

  Future<dynamic> _refreshList() async {
    setState(() {
      print(incidentes[0].Usuario_Nombres);
    });

    return _getIncidentes();
  }

  @override
  Widget build(context) {
    print("lista de incidentes");
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: const Text("Lista de incidentes",
              style: TextStyle(
                color: Colors.white,
              )),
          actions: <Widget>[
            IconButton(
              tooltip: 'Refresh',
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: () => _refreshList(),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => _refreshList(),
          child: ListView.builder(
            itemCount: incidentes.length,
            itemBuilder: (context, int index) {
              return Card(
                  elevation: 10,
                  child: ListTile(
                    leading: const Icon(Icons.format_list_bulleted),
                    trailing: Column(
                      children: <Widget>[
                        Container(
                          width: 82,
                          height: 25,
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: MaterialButton(
                            color: Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: const Text(
                              'ver más',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => IncidentePage(
                                          idIncidente:
                                              incidentes[index].ID_Incidente)));
                            },
                          ),
                        ),
                      ],
                    ),
                    title: Text("N°$index" " " +
                        incidentes[index].ind_Tipo_incidente),
                    subtitle: Text(incidentes[index].Usuario_Nombres +
                        "\n" +
                        incidentes[index].ind_Estado),
                    isThreeLine: true,
                    dense: true,
                    selectedTileColor: Colors.lightBlue,
                  ));
            },
          ),
        ));
  }
}
