import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'infoUsua.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CompletPerfil extends StatefulWidget {
  CompletPerfil({Key key, this.title, this.users2}) : super(key: key);
  final classUsuarios users2;
  final String title;
  @override
  _CompletPerfilState createState() => _CompletPerfilState();
}

class _CompletPerfilState extends State<CompletPerfil> {
  final databaseReference = Firestore.instance;

  void createRecord() async {
    String userEmail;

      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      userEmail = user.email;
    DocumentReference ref = await databaseReference.collection("Deportistas").add({
      'Correo':userEmail,
      'Nombre': nombre,
      'Celular': cel,
      'identificacion': identificacion,
      'Genero': genero,
    });
    print("/////////////////////////////////\n" +
        ref.documentID +
        "\n/////////////////////////////////////////////////");
  }

  @override
  List<classUsuarios> users = new List<classUsuarios>();
  String msjCrear = "***************************************\n";
  String nombre = "";
  String cel = "";
  String identificacion = "";
  String genero = "Hombre";
  var _listGeneros = ['Hombre', 'Mujer', 'Otro'];
  String _vista = 'Selecciona una opción';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SPORTS TRAINING'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          Text(
            'PERFIL DEPORTISTA',
            style: TextStyle(
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child: TextField(
              onChanged: (texto) {
                nombre = texto;
              },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: ' Escribe tu nombre ',
                filled: true,
                fillColor: Colors.black,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(29)),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child: TextField(
              onChanged: (texto) {
                cel = texto;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: ' Escribe tu número de celular ',
                filled: true,
                fillColor: Colors.black,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(29)),
                  borderSide: BorderSide(color: Colors.black),
                ), 
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child: TextField(
              onChanged: (texto) {
                identificacion = texto;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: ' Escribe tu número de identidad ',
                filled: true,
                fillColor: Colors.black,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(29)),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            '¿Cuál es tu género?',
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 100.0, right: 100.0),
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(150)),
                color: Colors.black,
                border: Border.all()),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                items: _listGeneros.map((String a) {
                  return DropdownMenuItem(value: a, child: Text(a));
                }).toList(),
                onChanged: (_value) => {
                  setState(() {
                    this.genero = _value;
                  })
                },
                value: genero,
                dropdownColor: Colors.black,
                isExpanded: false,
                hint: Text(_vista),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(left: 100.0, right: 100.0),
            decoration:
                BoxDecoration(color: Colors.black, border: Border.all()),
            child: MaterialButton(
              minWidth: 20.0,
              height: 50.0,
              disabledColor: Colors.red,
              child: Text('Guardar',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              splashColor: Colors.redAccent,
              color: Colors.blueAccent,
              elevation: 30.0,
              onPressed: () {
                
                    classUsuarios objUsuario = new classUsuarios(
                        nombre,
                        cel,
                        identificacion,
                        genero);
                    users.add(objUsuario);
                    createRecord();
                    Navigator.pop(context);
                    
              },
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  bool llenarFormulario(String name, String lastName, String celphone,
      String docCC, String mail, String contrasena) {
    bool completo = false;
    if (name != "" &&
        lastName != "" &&
        celphone != "" &&
        docCC != "" &&
        mail != "" &&
        contrasena != "") {
      completo = true;
    }
    return completo;
  }

  List<classUsuarios> devLista() {
    return users;
  }

  Future msjErroneo(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: const Text(
              'Alguna casilla esta vacía por favor vuelve a revisar'),
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
