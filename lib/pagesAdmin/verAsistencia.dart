import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';

////////////////////////////////////////////////////////////////////////////////////////////////
class DeporAsistieron extends StatefulWidget{
  DeporAsistieron({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _DeporAsistieronState createState() => _DeporAsistieronState();
}

class _DeporAsistieronState extends State<DeporAsistieron> {
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

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: Text('Listado de Asistencia')),
      body: new StreamBuilder(
          stream: Firestore.instance.collection('Asistencia').snapshots(),
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
                      '         ${ds['Usuario']} \n'
                      '--------------------------------------------------------',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  );
                });
          }),
    );
  }
}