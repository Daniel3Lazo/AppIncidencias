class LoginLists {
  List<LoginList> items = [];
  LoginLists();

  LoginLists.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final objetoCuenta = LoginList.fromJsonMap(item);
      items.add(objetoCuenta);
    }
  }
}

class LoginList {
  final String status;
  final String message;
  final String usuario;
  final String email;
  final String password;
//  "status": true,
//     "message": "Login Satisfactorio!",
//     "ID_Usuario": "250",
//     "US_Email": "luis@gmail.com"
  LoginList({
   required this.status,
   required this.message,
   required this.usuario,
   required this.email,
   required this.password,
  });

  factory LoginList.fromJsonMap(Map<String, dynamic> json) {
    return LoginList(
      status: json['status'],
      message: json['message'],
      usuario: json['ID_Usuario'],
      email: json['US_Email'],
      password: json['Contrasena'],
    );
  }
}
