class Incidente {
  final String ID_Incidente;
  final String ID_Vehiculo;
  final String Placa_Vehiculo;
  final String ID_Usuario;
  final String Usuario_Nombres;
  final String ind_Descripcion;
  final String ind_Fecha_Incidente;
  final String ind_Tipo_incidente;
  final String ind_Fotografia;
  final String ind_Estado;

  Incidente(
      {
     required this.ID_Incidente,
     required this.ID_Vehiculo,
     required this.Placa_Vehiculo,
     required this.ID_Usuario,
     required this.Usuario_Nombres,
     required this.ind_Descripcion,
     required this.ind_Fecha_Incidente,
     required this.ind_Tipo_incidente,
     required this.ind_Fotografia,
     required this.ind_Estado});

  factory Incidente.fromJson(Map<String, dynamic> json) {
    return Incidente(
        ID_Incidente: json['ID_Incidente'],
        ID_Vehiculo: json['ID_Vehiculo'],
        Placa_Vehiculo: json['Placa_Vehiculo'],
        ID_Usuario: json['ID_Usuario'],
        Usuario_Nombres: json['Usuario_Nombres'],
        ind_Descripcion: json['ind_Descripcion'],
        ind_Fecha_Incidente: json['ind_Fecha_Incidente'],
        ind_Tipo_incidente: json['ind_Tipo_incidente'],
        ind_Fotografia: json['ind_Fotografia'],
        ind_Estado: json['ind_Estado']);
  }
}
