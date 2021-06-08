import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AddMembresias extends StatefulWidget {
  AddMembresias({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _AddMembresiasState createState() => _AddMembresiasState();
}

class _AddMembresiasState extends State<AddMembresias> {
  String titulo = "";
  String usuario = "";
  String costo = "";
  String nombreEvento = "";
  String descEvento = "";
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _title;
  TextEditingController _description;
  TextEditingController _costo;
  TextEditingController _numero;
  Stream events;
  SharedPreferences prefs;
  String numero = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Membresias'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _title,
                  validator: (value) =>
                      (value.isEmpty) ? "Ingresa el titulo" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Titulo",
                      filled: true,
                      fillColor: Colors.black12,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _description,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) =>
                      (value.isEmpty) ? "Ingresa descripción" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Descripción",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _numero,
                  validator: (value) =>
                      (value.isEmpty) ? "Costo del evento:" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Precio",
                      filled: true,
                      fillColor: Colors.black12,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              /*Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _costo,
                  validator: (value) =>
                      (value.isEmpty) ? "Cantidad" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Cantidad",
                      filled: true,
                      fillColor: Colors.black12,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),*/
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 100.0, right: 100.0),
            decoration:
                BoxDecoration(color: Colors.orange[50], border: Border.all()),
            child: RaisedButton(
              disabledColor: Colors.grey,
              child: Text('Guardar',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              splashColor: Colors.purple,
              color: Colors.lightBlueAccent[100],
              elevation: 30.0,
              onPressed: () {
                int num = int.parse(numero);
                bool val = validarEvento(nombreEvento, descEvento, costo, num);
                print("$val");
                if (val == true) {
                  if (val == true) {
                    msjConfirmar(context);
                  }
                } 

                if (val == false) {
                  msjError(context);
                }
              },
            ),
          ),

          SizedBox(height: 100),
        ],

      ),
    );
  }

  final databaseReference = Firestore.instance;
  void createRecord(String titulo,
      String descripcion, String costo, int capacidad) async {
    var listado = new List(capacidad);

    DocumentReference ref = await databaseReference.collection("membresia").add({
      'Titulo': titulo,
      'Descripcion': descripcion,
      'Costo': costo,
      'Capacidad':capacidad,
      'Miembros': listado,
      'Total miembros': 0,
    });
  }

  bool validarEvento(
      String titulo,
      String descripcion,
      String costo,
      int cantidad
      ) {
    createRecord(titulo, descripcion, costo, cantidad);
    }
  

  Future msjConfirmar(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exitoso'),
          content: const Text('Las membresias se guardaron'),
          actions: [
            MaterialButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future msjError(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: const Text('No se guardo la membresia'),
          actions: [
            MaterialButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}