import 'dart:io';
import 'package:ayudafinal/pages/addName.dart';
import 'package:ayudafinal/pages/MyAsistencia.dart';
import 'package:ayudafinal/pages/agendamiento.dart';
import 'package:ayudafinal/pages/agendarEspecial.dart';
import 'package:ayudafinal/pages/verPerfil.dart';
import 'package:ayudafinal/pagesAdmin/verTiposUsuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ayudafinal/pages/Sports.dart';
import 'package:ayudafinal/pages/login_signup.dart';
import 'package:ayudafinal/pages/reservas.dart';

void main() => runApp(Gym());

class Gym extends StatefulWidget {
  const Gym({this.onSignedOut, this.codigo});
  final VoidCallback onSignedOut;
  final String codigo;
  @override
  State<StatefulWidget> createState() => _GymState();
}

class _GymState extends State<Gym> {
  final String code;
  _GymState({this.code});
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
      home: new LoginSignUpPage(),
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
                      'Perfil',
                    ),
                    subtitle: Text('Completa o edita tu perfil'),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new CompletPerfil()));
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
                      'Reservar Cita Usuario Normal',
                    ),
                    subtitle: Text('Mira las actividades que hay disponibles y reserva!'),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new ReservarCita()));
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
                      'Reservar Entrenamiento Libre',
                    ),
                    subtitle: Text('Reserva para usuario VIP'),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Reserves()));
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
                      'Asistencia',
                    ),
                    subtitle: Text('Marca tu asistencia al gym'),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new MyAsistence()));
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
                      'Matricularse',
                    ),
                    subtitle: Text('Matriculate con tu membresia'),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new VerTiposUsuarios()));
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
                    leading: Icon(Icons.info),
                    title: Text('SPORTS TRAINING'),
                    subtitle: Text(
                        'Echa un vistazo a los horarios y actividades.'),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Info()));
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
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>new PerfilUsuario()));
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text('Reservar'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new ReservarCita()));
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text('Asistencia'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new MyAsistence()));
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text('SPORTS TRAINING'),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new Info()));
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