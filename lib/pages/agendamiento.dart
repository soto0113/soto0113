import 'package:ayudafinal/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';

class ReservarCita extends StatefulWidget {
  ReservarCita({Key key, this.title, this.nombre}) : super(key: key);
  final String nombre;
  final String title;
  @override
  _ReservarCitaState createState() => _ReservarCitaState(nombreUsuario: nombre);
}

class _ReservarCitaState extends State<ReservarCita> {
  String nombreUsuario = "";
  final databaseReference = Firestore.instance;
  _ReservarCitaState({this.nombreUsuario});
  String id;
  int totalParticipantes;
  int capacidad;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SPORTS TRAINING'),
      ),
      body: new StreamBuilder(
          stream: Firestore.instance.collection('Ejercicios').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) const Text('Loading...');
                return ListView.builder(
                itemCount: snapshot.data.documents.length,
                padding: const EdgeInsets.all(25.0),
                itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                  int elec;
                  String nombre;
                  String descripcion;
                  var fechaIni;
                  var fechaFin;
                  var listado;
                  return ListTile(
                    title: Text(
                      '${ds['Titulo']} ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      '${ds['Descripcion']}\n ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      listado = ds['Participantes'];
                      capacidad = ds['Capacidad'];
                      id = ds.documentID;
                      totalParticipantes = ds['Total participantes'];
                      if (capacidad == 10) {}
                      elec = index;
                      nombre = ds['Titulo'];
                      for (int i = 0; i < 10; i++) {
                        print(ds['Titulo']);
                      }
                      descripcion = ds['Descripcion'];
                      DateTime auxI = (snapshot.data.documents[index].data['Fecha Inicio']).toDate();
                      DateTime auxF = (snapshot.data.documents[index].data['Fecha Fin']).toDate();
                      fechaIni = DateFormat('yyyy-MM-dd – kk:mm').format(auxI);
                      String fechaFin = DateFormat('yyyy-MM-dd – kk:mm').format(auxF);
                      infoClase(
                          context,
                          nombre,
                          descripcion,
                          fechaIni,
                          fechaFin,
                          totalParticipantes,
                          nombreUsuario,
                          id,
                          listado,
                          capacidad,
                          auxI,
                          auxF);
                      print("- $elec");
                    },
                    onLongPress: () {
                      capacidad = ds['Capacidad'];
                      id = ds.documentID;
                      listado = ds['Participantes'];
                      totalParticipantes = ds['Total participantes'];
                      elec = index;
                      nombre = ds['Titulo'];
                      descripcion = ds['Descripcion'];
                      DateTime auxI =
                          (snapshot.data.documents[index].data['Fecha Inicio'])
                              .toDate();
                      DateTime auxF =
                          (snapshot.data.documents[index].data['Fecha Fin'])
                              .toDate();
                      fechaIni = DateFormat('yyyy-MM-dd – kk:mm').format(auxI);
                      fechaFin = DateFormat('yyyy-MM-dd – kk:mm').format(auxF);

                      infoClase(
                          context,
                          nombre,
                          descripcion,
                          fechaIni,
                          fechaFin,
                          totalParticipantes,
                          nombre,
                          id,
                          listado,
                          capacidad,
                          auxI,
                          auxF);
                      print("$elec");
                    },
                  );
                });
          }),
    );
  }
  Future infoClase(
      BuildContext context,
      String titulo,
      String des,
      var ini,
      var fin,
      int lugar,
      String nombreUsuario,
      String id,
      var listado,
      int capacidad,
      DateTime fechaIG,
      DateTime fechaFG) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Descripción de la clase'),
          content: Text(
            'Titulo: $titulo \nDescripción:\n$des\nHorario:\n$ini a\n$fin',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          actions: [
            MaterialButton(
              child: Text(
                'Reservar',
                style: TextStyle(
                  color: Colors.tealAccent[700],
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                var diaClase = fechaIG.day;
                bool confirmarDia = mismoDia(diaClase);
                if (confirmarDia == true) {
                  agendarse(titulo, des, fechaIG, fechaFG, nombreUsuario, id,
                      lugar, listado, capacidad);
                } else if(confirmarDia == false) {
                  msjMismoDia(context);
                }
                //Navigator.pop(context);
              },
            ),
            MaterialButton(
              child: Text(
                'No reservar',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new Gym()));
              },
            )
          ],
        );
      },
    );
  }
  Future agendarse(
      String titulo,
      String des,
      DateTime fechaini,
      DateTime fechafin,
      String nombreUsuario,
      String id,
      int lugar,
      var listado,
      int capacidad) async {
      int lugarNuevo = lugar + 1;
      String userEmail;
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      userEmail = user.email;
      if (lugarNuevo <= capacidad) {
        listado[lugar] = userEmail;
        print('id: $listado ');
        await databaseReference.collection('Ejercicios').document(id).setData({
          'Capacidad': capacidad,
          'Titulo': titulo,
          'Descripcion': des,
          'Fecha Inicio': fechaini,
          'Fecha Fin': fechafin,
          'Total participantes': lugarNuevo,
          'Participantes': listado,
        });
        msjReservado(context);
      } else {
        msjClaseLlena(context);
      }
  }

  bool mismoDia(var fechaClase) {
    DateTime fecha = DateTime.now();
    var hoy = fecha.day;
    print("****** hoy: $hoy, fecha clase: $fechaClase");
    if (fechaClase == hoy) {
      return false;
    } else {
      return true;
    }
  }

  Future msjClaseLlena(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: const Text('La actividad esta llena, No es posible reservar'),
          actions: [
            MaterialButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future msjReservado(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exitoso'),
          content: const Text('Has reservado para esta actividad'),
          actions: [
            MaterialButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Gym()));
              },
            ),
          ],
        );
      },
    );
  }

  Future msjMismoDia(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: const Text(
              'Recuerda que solo puedes programar citas un día antes de estas'),
          actions: [
            MaterialButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
