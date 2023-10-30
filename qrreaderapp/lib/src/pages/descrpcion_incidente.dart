import 'package:flutter/material.dart';

class DescripcionIncidente extends StatelessWidget {
  DateTime fecha;
  String tipo_incidente;
  int id_incidente;

  DescripcionIncidente(this.fecha, this.tipo_incidente, this.id_incidente, {super.key});

  @override
  Widget build(BuildContext context) {
    final descripcion = Container(
      margin: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
      child: Text(
        id_incidente.toString(),
        style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF56575a)),
      ),
    );

    final label = Container(
      margin: const EdgeInsets.only(top: 10.0, left: 5.0, right: 3.0),
      child: Text(
        tipo_incidente,
        style: const TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF56575a)),
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[label, descripcion],
    );
  }
}
