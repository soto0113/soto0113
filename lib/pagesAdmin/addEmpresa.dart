import 'package:flutter/material.dart';
import 'package:ayudafinal/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class addEmpresa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Addadministrador(String empresa, String dueno, String cel, String identi) async {
      String userEmail;

      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      userEmail = user.email;
      Firestore.instance.collection(Constants.adminCollectionId).document(userEmail)
      .setData({'Correo':userEmail,'Empresa':empresa, 'Propietario': dueno, 
      'Contacto':cel, 'Documento de identidad':identi
      });
    }

    final myControllerE = TextEditingController();
    final myControllerP = TextEditingController();
    final myControllerC = TextEditingController();
    final myControllerD = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("SPORTS TRAINING"),
      ),
      body: Center(
        child: Column(children: <Widget>[
          
          SizedBox(height: 30.0),
          TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              controller: myControllerE,
              decoration: new InputDecoration(
                hintText: 'Nombre del centro deportivo',
                      icon: new Icon(
                        Icons.sports,
                        color: Colors.redAccent
                      ),
                border: InputBorder.none,
              ),
              validator: (value) =>
                  value.isEmpty ? 'El campo no puede estar vacio' : null,
              onSaved: (value) => value,
          ),
          SizedBox(height: 30.0),
          TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              controller: myControllerP,
              decoration: new InputDecoration(
                hintText: 'Nombre del propietario',
                      icon: new Icon(
                        Icons.perm_identity,
                        color: Colors.redAccent
                      ),
                border: InputBorder.none,
              ),
              validator: (value) =>
                  value.isEmpty ? 'El campo no puede estar vacio' : null,
              onSaved: (value) => value,
          ),
          SizedBox(height: 30.0),
          TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              controller: myControllerC,
              decoration: new InputDecoration(
                hintText: 'Contacto',
                      icon: new Icon(
                        Icons.phone,
                        color: Colors.redAccent
                      ),
                border: InputBorder.none,
              ),
              validator: (value) =>
                  value.isEmpty ? 'El campo no puede estar vacio' : null,
              onSaved: (value) => value,
          ),
          SizedBox(height: 30.0),
          TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              controller: myControllerD,
              decoration: new InputDecoration(
                hintText: 'Identificación',
                      icon: new Icon(
                        Icons.phone,
                        color: Colors.redAccent
                      ),
                border: InputBorder.none,
              ),
              validator: (value) =>
                  value.isEmpty ? 'El campo no puede estar vacio' : null,
              onSaved: (value) => value,
          ),
          SizedBox(height: 30.0),
          RaisedButton(
              elevation: 4.0,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(29.0)),
              color: Colors.orangeAccent,
                  onPressed: () {
                    Addadministrador(myControllerE.text,myControllerP.text,myControllerC.text,myControllerD.text);
                    Navigator.pop(context, false);
                  },
              child: Row(
                  children: <Widget>[
                  Text('             Guardar ', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                  Icon(Icons.save, color: Colors.black,),
                  ],
              ),
          ),
         ]),
      ),
    );
  }
}
