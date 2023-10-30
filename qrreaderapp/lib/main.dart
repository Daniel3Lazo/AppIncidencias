import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrreaderapp/src/pages/geolocalizacion.dart';
import 'package:qrreaderapp/src/pages/home_page.dart';
import 'package:qrreaderapp/src/pages/login_page.dart';
import 'package:qrreaderapp/src/pages/register_page.dart';
import 'package:qrreaderapp/src/pages/registrar_incidente.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRReader',
      home: const LoginPage(),
      routes: {
        HomePage.routeName: (BuildContext context) => HomePage(),
        RegisterPage.routeName: (_) => const RegisterPage(),
        LoginPage.routeName: (_) => const LoginPage(),
        'Geocalizacion': (BuildContext context) => const MapSample(),
        'registrar': (BuildContext context) =>
            const RegistrarIncidente(title: 'id_vehiculo'),
      },
      theme: ThemeData(primaryColor: Colors.lightBlue),
    );
  }
}
