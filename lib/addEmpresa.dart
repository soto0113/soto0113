import 'package:ayudafinal/conf.dart';
import 'package:ayudafinal/pagesAdmin/home_pageA.dart';
import 'package:flutter/material.dart';
//import 'package:niggagym/tercer_pantalla.dart';
//import 'sexta_pantalla.dart';
//import 'treceava_pantalla.dart';
import 'package:ayudafinal/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class addEmpresa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map data;
    Addadministrador(String texto) {
      Firestore.instance.collection(Constants.adminCollectionId).document()
      .setData({'empresa':texto});
    }

    final myController = TextEditingController();
    int elecion;
    return Scaffold(
      appBar: AppBar(
        title: Text("SPORTS TRAINING"),
      ),
      body: Center(
        child: Column(children: <Widget>[
          SizedBox(height: 70.0),
          Container(
              width: 300.0,
              height: 240.0,
              child: Image(
                image: AssetImage("imagenes/menudepor.png"),
                fit: BoxFit.cover,
              ),
            ),
          
          SizedBox(height: 30.0),
          TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              controller: myController,
              decoration: new InputDecoration(
                  labelText: 'Nombre del centro deportivo ?',
                  border: OutlineInputBorder(),
                ),
              validator: (value) =>
                  value.isEmpty ? 'El campo no puede estar vacio' : null,
            //  onSaved: (value) => value,
          ),
        
          SizedBox(height: 30.0),
          RaisedButton(
            child: Text("AGREGAR",
                      style:
                      TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.black
                      ),),
                      
            color: Colors.orangeAccent,
            onPressed: () {
              Addadministrador(myController.text);
              elecion = 2;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => configuracionA()),
              );
            },
          ),
         ]),
      ),
    );
  }
}
