import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PerfilUsuario extends StatefulWidget {
  PerfilUsuario({Key key, this.title, this.codigo}) : super(key: key);
  final String codigo;
  final String title;

  @override
  _PerfilUsuarioState createState() =>
      _PerfilUsuarioState(correo: codigo);
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
  _PerfilUsuarioState({this.correo});
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
          stream: Firestore.instance.collection('Deportistas').snapshots(),
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
                    "Perfil de ${ds['Nombre']}\n\n"
                    ' Nombre: ${ds['Nombre']}\n Correo: '
                      '${ds['Correo']} \n Genero: ${ds['Genero']}\n Identificación: ${ds['identificacion']} ',
                    style: TextStyle(fontSize: 20),
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