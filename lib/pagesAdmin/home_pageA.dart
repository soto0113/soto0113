import 'dart:io';
import 'package:ayudafinal/Calendario.dart/addActivity.dart';
import 'package:ayudafinal/pagesAdmin/addTiposUsua.dart';
import 'package:ayudafinal/pagesAdmin/addEmpresa.dart';
import 'package:ayudafinal/pagesAdmin/listaUsuario.dart';
import 'package:ayudafinal/pagesAdmin/listadoClases.dart';
import 'package:ayudafinal/pagesAdmin/login_signupA.dart';
import 'package:ayudafinal/pagesAdmin/perfilA.dart';
import 'package:ayudafinal/pagesAdmin/progHorarioGym.dart';
import 'package:ayudafinal/pagesAdmin/verAsistencia.dart';
import 'package:ayudafinal/pagesAdmin/verTiposUsuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(GymA());

class GymA extends StatefulWidget {
  const GymA({this.onSignedOut});
  final VoidCallback onSignedOut;
  @override
  State<StatefulWidget> createState() => _GymAState();
}

class _GymAState extends State<GymA> {
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

  // Cerrar sesión
  _signOut() async {
    await _auth.signOut();
    runApp(new MaterialApp(
      home: new LoginSignUpPageA(),
    ));
  }

  // muestra el menu y una lista con varios enlaces a otras ventanas
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('SPORTS TRAINING'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(Icons.add),
                    title: Text(
                      'Programar horarios',
                    ),
                    subtitle: Text('Programa los horarios y entrenamientos!'),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new CrearActividad()));
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
                      'Actividades del Gym',
                    ),
                    subtitle: Text('Observa las actividades que has programado'),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new ClasesProgramadas()));
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
                      'Listado de deportistas',
                    ),
                    subtitle: Text('Deportistas registrados'),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new DeportistasRegistrados()));
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
                      'Deportistas',
                    ),
                    subtitle: Text('Verifica la asistencia de los deportista'),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new DeporAsistieron()));
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
                      'Agregar empresa',
                    ),
                    subtitle: Text('Bienvenido administrador, puedes agregar tu negocio aqui'),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new addEmpresa()));
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
                      'Tipos de usuarios',
                    ),
                    subtitle: Text('Agrega los tipos de usuarios'),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new AddMembresias()));
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('http://i.pravatar.cc/300'),
              ),
              accountEmail: Text("${user?.email}"),
              accountName: null,
            ),
            ListTile(
              title: Text('Perfil'),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new PerfilAdmin()));
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text('Programar horarios'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new CrearActividad()));
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text('Actividades Gym'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new ClasesProgramadas()));
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text('Listado Deportistas'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new DeportistasRegistrados()));
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text('Deportistas'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new DeporAsistieron()));
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text('Membresias'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new VerTiposUsuarios()));
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text('Agregar empresa'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new addEmpresa()));
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
                title: Text('Cerrar sesión'),
                onTap: () {
                  _signOut();
                  exit(0);
                })
          ],
        ),
      ),
    );
  }
}