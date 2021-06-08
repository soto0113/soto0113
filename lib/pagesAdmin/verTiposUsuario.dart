import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class VerTiposUsuarios extends StatefulWidget {
  VerTiposUsuarios({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _VerTiposUsuariosState createState() => _VerTiposUsuariosState();
}

class _VerTiposUsuariosState extends State<VerTiposUsuarios> {
  String nombreUsuario = "";
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
          stream: Firestore.instance.collection('membresia').snapshots(),
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
                  String costo;
                  var fechaIni;
                  var fechaFin;
                  var listado;
                  return ListTile(
                    title: Text(
                      '${ds['Miembro']} ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      '${ds['Descripción']}\n${ds['Precio']} ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                     onTap: () {
                      ///aqui en adelanto guardo cada dato segun el usuario digite
                      listado = ds['Miembros'];
                      capacidad = ds['Capacidad'];

                      ///id guarda el id de cada documento en la coleccion,ayuda para direccionar
                      id = ds.documentID;
                      totalParticipantes = ds['Total miembros'];
                      if (capacidad == 10) {}
                      elec = index;
                      nombre = ds['Miembro'];
                      descripcion = ds['Descripción'];
                      costo = ds['Precio'];
                      DateTime auxI =
                          (snapshot.data.documents[index].data['Fecha Inicio'])
                              .toDate();
                      DateTime auxF =
                          (snapshot.data.documents[index].data['Fecha Fin'])
                              .toDate();
                      fechaIni = DateFormat('yyyy-MM-dd – kk:mm').format(auxI);

                      String fechaFin =
                          DateFormat('yyyy-MM-dd – kk:mm').format(auxF);

                      infoClase(
                          context,
                          nombre,
                          descripcion,
                          costo,
                          fechaIni,
                          fechaFin,
                          totalParticipantes,
                          nombreUsuario,
                          id,
                          listado,
                          capacidad,
                          auxI,
                          auxF,
                          capacidad);
                      print("$elec");
                    },

                    onLongPress: () {
                      capacidad = ds['Capacidad'];
                      id = ds.documentID;
                      listado = ds['Miembros'];
                      totalParticipantes = ds['Total miembros'];
                      elec = index;
                      nombre = ds['Miembro'];
                      descripcion = ds['Descripción'];
                      costo = ds['Precio'];
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
                          costo,
                          fechaIni,
                          fechaFin,
                          totalParticipantes,
                          nombre,
                          id,
                          listado,
                          capacidad,
                          auxI,
                          auxF,
                          capacidad);

                      ///fijate que uso el elec como si fuera indicador o pues la posicion que eligio el usuario
                      print("$elec");
                    },
                  );
                });
          }),
    );
  }

  Future mostrarListado(var lista, int limite) {
    String listadoImpr = "";
    var aux = lista;
    int contador = 0;
    String claseLlena = "";
    for (int i = 0; i < limite; i++) {
      if (aux[i] != null) {
        listadoImpr += ">> ${i + 1}: " + aux[i] + "\n";
        contador++;
        //print("$i : ${aux[i]}");
      }
    }
    if (contador == capacidad - 1) {
      claseLlena = "Clase llena";
    }
    print("-> $lista");
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'MIEMBROS\n ',
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Deportistas Registrados: $contador \n$listadoImpr \n',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          actions: [
            MaterialButton(
              child: Text(
                'Regresar',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Future infoClase(
      BuildContext context,
      String titulo,
      String des,
      String costo,
      var ini,
      var fin,
      int lugar,
      String nombreUsuario,
      String id,
      var listado,
      int capacidad,
      DateTime fechaIG,
      DateTime fechaFG,
      int cantidadRegistrados) {
    var aux = listado;
    int contador = 0;
    for (int i = 0; i < capacidad; i++) {
      if (aux[i] != null) {
        contador++;
      }
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Descripcion de la membresia'),
          content: Text(
            'Titulo: $titulo \nDescripcion:\n $des \nCosto: $costo\nDeportistas Registrados: $contador',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          actions: [
            MaterialButton(
                child: Text(
                  'Ver miembros',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  mostrarListado(listado, capacidad);
                }),
            MaterialButton(
              child: Text(
                'Regresar',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}