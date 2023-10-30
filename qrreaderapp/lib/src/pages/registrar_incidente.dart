import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrreaderapp/src/models/loginModel.dart';

class RegistrarIncidente extends StatefulWidget {
  const RegistrarIncidente({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _TipoIncidente createState() => _TipoIncidente();
}

class _TipoIncidente extends State<RegistrarIncidente> {
   String? id_vehiculo;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  File? foto;
  String? _tipoIncidentes;
  String? _descripciones;
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
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          'Registrar Incidente',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.photo_size_select_actual,
              color: Colors.white,
            ),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: const Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
            onPressed: _tomarFoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _mostrarFoto(),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                _creartipo(),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                ),
                _crearDescripcion(),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
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
        'Sobre carga de pasajeros',
        'Exceso de velocidad',
        'Exceso de tiempo de espera',
        'Maltrato físico del conductor',
        'Accidentes de tránsito'
      ].map((label) {
        return DropdownMenuItem<String>(
          value: label,
          child: Text(label),
        );
      }).toList(),

      onChanged: (value) {
        setState(() {
          _tipoIncidentes = value!;
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
          if (value!.length < 3) {
            return 'Ingrese la descripción del incidente';
          } else {
            return null;
          }
        });
  }

  Widget _botonGuardar() {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      color: Colors.lightBlueAccent,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Guardar',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Icon(
            Icons.save,
            color: Colors.white,
          ),
        ],
      ),
      onPressed: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  title: const Text('Registrar Incidente'),
                  content: const Text('Desea Registrar el Incidente?'),
                  actions: <Widget>[
                    MaterialButton(
                        onPressed: (_guardando) ? null : _submit,
                        child: const Text('Sí')),
                    MaterialButton(
                        child: const Text('No'),
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

    formKey.currentState!.save();
    setState(() {
      _guardando = true;
    });
    mostrarSnackbar('Registro guardado');
    setState(() {});
    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 1500),
        content: Text(
          mensaje,
        ),
      ),
    );
  }

  _mostrarFoto() {
    if (foto != null) {
      return Image.file(
        foto!,
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
    final pickedFile = await picker.pickImage(source: origen);
    foto = File(pickedFile!.path);
    if (pickedFile != null) {
      // incidente = null;
    } else {
      print('No image selected.');
    }
    setState(() {});
  }

  Future<void> _crearIncidente() async {
    var base64Image = base64Encode(foto!.readAsBytesSync());

    final variable = await Authent.metodos();

    var formData = json.encode({
      "incidente_image": base64Image,
      "ID_Vehiculo": id_vehiculo,
      "ID_Usuario": variable.toString().trim(),
      "ind_Descripcion": "indTipoIncidente",
      "ind_Tipo_incidente": "indDescripcion",
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
          "http://smartcityhyo.tk/api/Incidente/Insertar_Incidente.php");
      var request = http.MultipartRequest("POST", uri);
      final mimeType = mime(foto!.path)?.split('/');
      request.fields['ID_Vehiculo'] = id_vehiculo!;
      request.fields['ID_Usuario'] = variable.toString().trim();
      request.fields['ind_Descripcion'] = _descripciones!;
      request.fields['ind_Tipo_incidente'] = _tipoIncidentes!;

      request.files.add(await http.MultipartFile.fromPath(
        'incidente_image',
        foto!.path,
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
    return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
