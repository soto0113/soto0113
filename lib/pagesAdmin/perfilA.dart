import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PerfilAdmin extends StatefulWidget {
  PerfilAdmin({Key key, this.title, this.codigo}) : super(key: key);
  final String codigo;
  final String title;

  @override
  _PerfilAdminState createState() =>
      _PerfilAdminState(correo: codigo);
}

class _PerfilAdminState extends State<PerfilAdmin> {
  _PerfilAdminState({this.correo});
  final String correo;
  final databaseReference = Firestore.instance;  
  int limite;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  @override
  
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Perfil'),
          ),
          body: 
          StreamBuilder(
          stream: Firestore.instance.collection('administrador').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) const Text('Loading...');
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                padding: const EdgeInsets.all(25.0),
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  if (!snapshot.hasData) {
                  return new Text("Loading");
                }
                if(ds['Correo']=='${user?.email}'){
                  return Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.black, border: Border.all()),
                  child: Text(
                    " Perfil de ${ds['Propietario']}\n\n"
                    'Propietario: ${ds["Propietario"]}\nEmpresa: ${ds["Empresa"]}\n'
                    'Identificación: ${ds["Documento de identidad"]}\nContacto: ${ds['Contacto']}',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                );
                }else{
                  return Container(
                    child: Text(
                      '',
                    ),
                  );
                }
                },
            );
          }
          )        
    );
  }
} 
/*import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PerfilAdmin extends StatefulWidget {
  PerfilAdmin({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _PerfilAdminState createState() => _PerfilAdminState();
}

class _PerfilAdminState extends State<PerfilAdmin> {
  final databaseReference = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: Text('Mi Perfil')),
      body: new StreamBuilder(
          stream: Firestore.instance.collection('administrador').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) const Text('Loading...');
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                padding: const EdgeInsets.all(25.0),
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[0];
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.black),
                    child: Text(
                      'Propietario: ${ds["dueno"]}\nEmpresa: ${ds["empresa"]}\n'
                      'Identificación: ${ds["identi"]}\nContacto: ${ds['cel']}',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  );
                });
          }),
        
    );
  }
}
*/
/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PerfilAdmin extends StatefulWidget {
  PerfilAdmin({Key key, this.title, this.codigo}) : super(key: key);
  final String title;
  final String codigo;
  @override
  _PerfilAdminState createState() => _PerfilAdminState(codes: codigo);
}

class _PerfilAdminState extends State<PerfilAdmin> {
  _PerfilAdminState({this.codes});
  String codes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Perfil'),
      ),
      body: ListView(
        children: [
          new StreamBuilder(
              stream: Firestore.instance
                  .collection('administrador')
                  .document(codes)
                  .snapshots(),
              builder: (context, snapshot) {
                //var user = snapshot.data;
                DocumentSnapshot ds = snapshot.data.documents[snapshot];
                if (!snapshot.hasData) {
                  return new Text("Loading");
                }
                return new Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.black, border: Border.all()),
                  child: Text(
                    'Propietario: ${ds["dueno"]}\nEmpresa: ${ds["empresa"]}\n'
                    'Identificación: ${ds["identi"]}\nContacto: ${ds['cel']}',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }),
        ],
      ),
    );
  }
}*/