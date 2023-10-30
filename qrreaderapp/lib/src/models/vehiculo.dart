class Vehiculo {
  final String ID_Vehiculo;
  final String VEH_Placa;
  final String VEH_Color;
  final String VEH_Modelo;
  final String VEH_Marca;
  final String ID_Tipo_Vehiculo;
  final String Tipo_Vehiculo;
  final String ID_Conductor;
  final String Nombre_Conductor;

  Vehiculo(
      {
     required   this.ID_Vehiculo,
     required this.VEH_Placa,
     required this.VEH_Color,
     required this.VEH_Modelo,
     required this.VEH_Marca,
     required this.Tipo_Vehiculo,
     required this.ID_Tipo_Vehiculo,
     required this.ID_Conductor,
     required this.Nombre_Conductor});

  factory Vehiculo.fromJson(Map<String, dynamic> json) {
    return Vehiculo(
        ID_Vehiculo: json['ID_Vehiculo'],
        VEH_Placa: json['VEH_Placa'],
        VEH_Color: json['VEH_Color'],
        VEH_Modelo: json['VEH_Modelo'],
        VEH_Marca: json['VEH_Marca'],
        Tipo_Vehiculo: json['Tipo_Vehiculo'],
        ID_Tipo_Vehiculo: json['ID_Tipo_Vehiculo'],
        ID_Conductor: json['ID_Conductor'],
        Nombre_Conductor: json['Nombre_Conductor']);
  }
}
