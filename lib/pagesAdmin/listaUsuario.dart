import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DeportistasRegistrados extends StatefulWidget {
  DeportistasRegistrados({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _DeportistasRegistradosState createState() => _DeportistasRegistradosState();
}

class _DeportistasRegistradosState extends State<DeportistasRegistrados> {
  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: Text('Deportistas Registrados')),
      body: new StreamBuilder(
          stream: Firestore.instance.collection('Deportistas').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) const Text('Loading...');
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                padding: const EdgeInsets.all(25.0),
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.black),
                    child: Text(
                      ' Nombre: ${ds['Nombre']}\n Correo: '
                      '${ds['Correo']} \n Genero: ${ds['Genero']}\n Indentificación: ${ds['identificacion']} '
                      '--------------------------------------------------------',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  );
                });
          }),
    );
  }
}