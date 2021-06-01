import 'package:ayudafinal/pagesAdmin/home_pageA.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class configuracionA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SPORTS TRAINING"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Card(
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(Icons.add),
                    title: Text(
                      'ESTABLECER HORARIOS',
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => null));
                    },
                  )
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(Icons.add),
                    title: Text(
                      'VERIFICAR ASISTENCIA',
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => null));
                    },
                  )
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(Icons.add),
                    title: Text(
                      'TIPOS DE USUARIOS',
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => null));
                    },
                  )
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(Icons.add),
                    title: Text(
                      'VOLVER AL MENÚ',
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => GymA()));
                    },
                  )
                ],
              ),
            ),
            ],
          ),
        ));
  }
}