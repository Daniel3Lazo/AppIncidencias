import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qrreaderapp/src/models/loginModel.dart';
import 'package:qrreaderapp/src/models/vehiculo.dart';
import 'package:qrreaderapp/src/pages/informacion.dart';
import 'package:qrreaderapp/src/pages/geolocalizacion.dart';
import 'package:qrreaderapp/src/pages/login_page.dart';
import 'package:qrreaderapp/src/pages/viehiculo_page.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  static const routeName = 'home';
  final prefs = Authent();

  HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        // title: Center(
        title: const Text(
          'Registro de Incidentes',
          // textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
              Colors.blueAccent,
              Colors.lightBlueAccent
            ])),
            child: Container(
              child: Column(
                children: <Widget>[
                  Material(
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    child: Image.asset(
                      'assets/usuario.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const Text(
                    'Registro de Incidentes',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text(
              'Perfil',
              style: TextStyle(color: Colors.lightBlueAccent),
            ),
            leading: const Icon(Icons.supervised_user_circle,
                color: Colors.lightBlueAccent),
            onTap: () {
              Navigator.popAndPushNamed(context, '....');
            },
          ),
          // Divider(
          //   color: Colors.blue[100],
          //   thickness: 2,
          // ),
          ListTile(
            title: const Text(
              'Scannear QR',
              style: TextStyle(color: Colors.lightBlueAccent),
            ),
            leading:
                const Icon(Icons.filter_center_focus, color: Colors.lightBlueAccent),
            onLongPress: _scanQR,
          ),

          ListTile(
            title: const Text(
              'Localización',
              style: TextStyle(color: Colors.lightBlueAccent),
            ),
            leading:
                const Icon(Icons.location_history, color: Colors.lightBlueAccent),
            onTap: () {
              Navigator.popAndPushNamed(context, 'Geocalizacion');
            },
          ),
          // Divider(
          //   color: Colors.blue[100],
          //   thickness: 2,
          // ),
          ListTile(
            title: const Text(
              'Configuración',
              style: TextStyle(color: Colors.lightBlueAccent),
            ),
            leading: const Icon(Icons.settings, color: Colors.lightBlueAccent),
            onTap: () {
              Navigator.popAndPushNamed(context, '....');
            },
          ),
          ListTile(
            title: const Text(
              'Cerrar Sesión',
              style: TextStyle(color: Colors.lightBlueAccent),
            ),
            leading: const Icon(Icons.logout, color: Colors.lightBlueAccent),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                LoginPage.routeName,
                (_) => false,
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(70, 30, 5, 0),
            child: Text(
              'V0.1.0',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ]),
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _scanQR,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.filter_center_focus),
      ),
    );
  }

  _scanQR() async {
    String futureString;

    try {
      futureString = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancelar', true, ScanMode.QR);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VehiculoPage(fetchVehiculo(futureString))));
    } catch (e) {
      throw Exception('Error en leer el código QR');
    }
  }

  Future<Vehiculo> fetchVehiculo(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Vehiculo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error en obtener información del vehículo');
    }
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return const CerrarSesion();
      case 1:
        return const MapSample();

      default:
        return const CerrarSesion();
    }
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            // ignore: deprecated_member_use
           label:'Información'),
        BottomNavigationBarItem(
            icon: Icon(Icons.location_history),
            // ignore: deprecated_member_use
            label: 'Localización'),
      ],
    );
  }
}
