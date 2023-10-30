//import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class API {
  static Future obtenerIncidentes(String idvehiculo) {
    var url =
        "http://smartcityhyo.tk/api/Incidente/Consultar_Incidente_Fecha.php?ID_Vehiculo=$idvehiculo";
    print(url);
    return http.get(Uri.parse(url));
  }

  static Future getIncidente(String idIncidente) async {
    var url =
        "http://smartcityhyo.tk/api/Incidente/Consultar_Incidente_Fecha.php?ID_Vehiculo=$idIncidente";
    return await http.get(Uri.parse(url));
  }
}
