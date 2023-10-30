import 'package:shared_preferences/shared_preferences.dart';

class Authent {
  static Future<void> metodo(String idUsuario) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('ID_Usuario', idUsuario);
      //return prefs.getString('id');
      //prefs.remove('id');
    } catch (err) {}
  }

  static Future<String> metodos() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('ID_Usuario') ?? '';
    } catch (err) {
      throw Exception('Error getting ID_Usuario from SharedPreferences');
    }
  }
}
