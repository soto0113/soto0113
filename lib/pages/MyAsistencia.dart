import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyAsistence extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return(
    MyHomePage(title: 'Marcar Asistencia')
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  final DatabaseReference=Firestore.instance;


  void createRecord() async{
      String userEmail;

      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      userEmail = user.email;
      DocumentReference ref = await DatabaseReference.collection("Asistencia")
      .add({
        'Usuario': userEmail,
      });
      print(ref.documentID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(children: <Widget>[
          SizedBox(height: 40.0),
          Container(
              width: 360,
              height: 250,
              child: Image(
                image: AssetImage("imagenes/principal.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          
          SizedBox(height: 30.0),
            Text(
              '    Oprime el botón para \n    marcar tu asistencia',
              style: 
              TextStyle(
                fontSize: 30, 
                color: Colors.white,
                fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30.0),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(29.0)),
              color: Colors.blueAccent,
              onPressed:
                  createRecord,
              child: Icon(Icons.check, color: Colors.black,), 
            )
          ],
        ),
      ),
    );
  }
}
