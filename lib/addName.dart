import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CompletPerfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return(
    PerfilPage(title: 'Perfil')
    );
  }
}

class PerfilPage extends StatefulWidget {
  PerfilPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {

  final DatabaseReference=Firestore.instance;


  void createRecord() async{
      String userEmail;

      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      userEmail = user.email;
      await DatabaseReference.collection("Deportistas")
      .document(userEmail)
      .setData({
        'Correo': userEmail,
        'Nombre': nombre,
        'Celular': cel,
        'Identificacion': identificacion,
      });
      
      DocumentReference ref = await DatabaseReference.collection("Deportistas")
      .add({
        'Correo': userEmail,
        'Nombre': nombre,
        'Celular': cel,
        'Identificacion': identificacion,
      });
      print(ref.documentID);
  }
  @override
  String msjCrear = "\n";
  String nombre = "";
  String cel = "";
  String identificacion = "";
  //String genero = "";
  

  //var _listGeneros = ['Hombre', 'Mujer', 'Otro'];
  //String _vista = 'Selecciona una opción';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
          children: <Widget>[
            _showPantalla(),
          ],
        ));
  }

   Widget _showPantalla() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _showName(),
              _showCelular(),
              _showIdentificacion(),
              _buttonSave(),
            ],
          ),
        ));
  }

  Widget _buttonSave(){
    return new RaisedButton(
        elevation: 4.0,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(29.0)),
        color: Colors.blueAccent,
        onPressed: createRecord, 
        child: Row(
            children: <Widget>[
            Text('             Guardar ', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
            Icon(Icons.save, color: Colors.black,),
            ],
        ),
      );
  }

  Widget _showName() {
    return Padding(
      padding: const EdgeInsets.all(29.0),//const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Nombre Completo',
            icon: new Icon(
              Icons.person,
              color: Colors.blue
            ),
            border: InputBorder.none,
          ),
        validator: (value) =>
            value.isEmpty ? 'El campo no puede estar vacío' : null,
        onSaved: (value) => nombre = value,
      ),
    );
  }

  Widget _showCelular() {
    return Padding(
      padding: const EdgeInsets.all(29.0),//const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Contacto',
            icon: new Icon(
              Icons.phone,
              color: Colors.blue
            ),
            border: InputBorder.none,
          ),
        validator: (value) =>
            value.isEmpty ? 'El campo no puede estar vacío' : null,
        onSaved: (value) => cel = value,
      ),
    );
  }

  Widget _showIdentificacion() {
    return Padding(
      padding: const EdgeInsets.all(29.0),//const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Documento de identidad',
            icon: new Icon(
              Icons.perm_identity,
              color: Colors.blue
            ),
            border: InputBorder.none,
          ),
        validator: (value) =>
            value.isEmpty ? 'El campo no puede estar vacío' : null,
        onSaved: (value) => nombre = value,
      ),
    );
  }
}
