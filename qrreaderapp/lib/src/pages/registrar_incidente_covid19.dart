/*import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrreaderapp/src/models/loginModel.dart';

class RegistrarIncidente extends StatefulWidget {
  RegistrarIncidente(this.id_vehiculo);
  final String id_vehiculo;

  @override
  _TipoIncidente createState() => _TipoIncidente(this.id_vehiculo);
}

class _TipoIncidente extends State<RegistrarIncidente> {
  String id_vehiculo;
  _TipoIncidente(this.id_vehiculo);
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  File foto;
  String _tipoIncidentes;
  String _descripciones;
  var picker = ImagePicker();
  bool _guardando = false;
  var tipoIncidentes = TextEditingController();
  var descripciones = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          'Registrar Incidente',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.photo_size_select_actual,
              color: Colors.white,
            ),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
            onPressed: _tomarFoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _mostrarFoto(),
                Padding(
                  padding: new EdgeInsets.only(top: 10.0),
                ),
                _creartipo(),
                Padding(
                  padding: new EdgeInsets.only(top: 15.0),
                ),
                _crearDescripcion(),
                Padding(
                  padding: new EdgeInsets.only(top: 20.0),
                ),
                _botonGuardar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _creartipo() {
    return Container(
        child: DropdownButtonFormField<String>(
      value: _tipoIncidentes,
      decoration: InputDecoration(
          hintText: "Tipo Incidente",
          labelText: "Tipo Incidente",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      // onSaved: (value) => registrar.indTipoIncidente = value,
      validator: (value) => value == null ? 'Seleccione un Incidente' : null,
      items: <String>[
        'Pasarce la luz roja del semáforo',
        'Accidente',
        'Exceso de velocidad',
        'Exceso de tiempo de espera',
        'Exceso de Tiempo',
        'Accidentes de tránsito'
      ].map((label) {
        return DropdownMenuItem<String>(
          child: Text(label),
          value: label,
        );
      }).toList(),

      onChanged: (value) {
        setState(() {
          _tipoIncidentes = value;
        });
      },
    ));
  }

  Widget _crearDescripcion() {
    return TextFormField(
        controller: descripciones,
        onChanged: ((String descripciones) {
          setState(() {
            _descripciones = descripciones;
          });
        }),
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        maxLines: 3,
        // initialValue: registrar.indDescripcion,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            hintText: "Descripción",
            labelText: "Descripción",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
        // onSaved: (value) => registrar.indDescripcion = value,
        validator: (value) {
          if (value.length < 3) {
            return 'Ingrese la descripción del incidente';
          } else {
            return null;
          }
        });
  }

  Widget _botonGuardar() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      color: Colors.lightBlueAccent,
      label: Text(
        'Guardar',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      icon: Icon(
        Icons.save,
        color: Colors.white,
      ),
      onPressed: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  title: Text('Registrar Incidente'),
                  content: Text('Desea Registrar el Incidente?'),
                  actions: <Widget>[
                    FlatButton(
                        child: Text('Sí'),
                        onPressed: (_guardando) ? null : _submit),
                    FlatButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ],
                ));
      },
    );
  }

  void _submit() async {
    _crearIncidente();

    formKey.currentState.save();
    setState(() {
      _guardando = true;
    });
    mostrarSnackbar('Registro guardado');
    setState(() {});
    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      duration: Duration(milliseconds: 2500),
      backgroundColor: Colors.blue[300],
      content: Row(
        children: [
          Icon(Icons.thumb_up),
          SizedBox(width: 30),
          Expanded(
            child: Text(mensaje),
          ),
        ],
      ),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
    setState(() {});
  }

  _mostrarFoto() {
    if (foto != null) {
      return Image.file(
        foto,
        height: 300,
        fit: BoxFit.cover,
      );
    }
    return Image.asset('assets/no-image.png');
  }

  _seleccionarFoto() async {
    procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    procesarImagen(ImageSource.camera);
  }

  Future procesarImagen(ImageSource origen) async {
    final pickedFile = await picker.getImage(source: origen);
    foto = File(pickedFile.path);
    if (pickedFile != null) {
      // incidente = null;
    } else {
      print('No image selected.');
    }
    setState(() {});
  }

  Future<void> _crearIncidente() async {
    var base64_image = base64Encode(foto.readAsBytesSync());

    final variable = await Authent.metodos();

    var formData = json.encode({
      "incidente_image": base64_image,
      "ID_Vehiculo": this.id_vehiculo,
      "ID_User": variable.toString().trim(),
      "IND_Descripcion": "indDescripcion",
      "Tipo_Incidente_Transp": "indTipoIncidente",
    });

    try {
      // http
      //     .post(
      //   "http://smartcityhyo.tk/api/Incidente/Insertar_Incidente.php",
      //   body: formData,
      // )
      //     .then((res) {
      //   print(res);
      // }).catchError((err) {
      //   print(err);
      // });
      // Future<String> uploadImage(foto, url) async {
      final variable = await Authent.metodos();
      var uri = Uri.parse(
          "https://incidentetransporte.000webhostapp.com/api/Incidente/Insertar_Incidente_Transp.php");
      var request = new http.MultipartRequest("POST", uri);
      final mimeType = mime(foto.path).split('/');
      request.fields['ID_Vehiculo'] = this.id_vehiculo;
      request.fields['ID_User'] = variable.toString().trim();
      request.fields['Tipo_Incidente_Transp'] = _tipoIncidentes;
      request.fields['IND_Descripcion'] = _descripciones;

      request.files.add(await http.MultipartFile.fromPath(
        'incidente_image',
        foto.path,
      ));

      request.send().then((response) {
        if (response.statusCode == 201) print("Uploaded!");
      });
      // }
    } catch (e) {
      print(e);
    }
  }

  Future<File> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
*/
