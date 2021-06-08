import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ClasesProgramadas extends StatefulWidget {
  ClasesProgramadas({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _ClasesProgramadasState createState() => _ClasesProgramadasState();
}

class _ClasesProgramadasState extends State<ClasesProgramadas> {
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
                          auxF,
                          capacidad);
                        print("$elec");
                      },
                      onLongPress: () {
                      capacidad = ds['Capacidad'];
                      id = ds.documentID;
                      listado = ds['Participantes'];
                      totalParticipantes = ds['Total participantes'];
                      elec = index;
                      nombre = ds['Titulo'];
                      descripcion = ds['Descripcion'];
                      DateTime auxI = (snapshot.data.documents[index].data['Fecha Inicio']).toDate();
                      DateTime auxF = (snapshot.data.documents[index].data['Fecha Fin']).toDate();
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
                          auxF,
                          capacidad);
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
        listadoImpr += "${i + 1}. " + aux[i] + "\n";
        contador++;
      }
    }
    if (contador == capacidad - 1) {
      claseLlena = "Actividad llena";
    } else {
      claseLlena = "Aún hay cupos";
    }
    print("$lista");
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'RESERVAS\n',
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Aforo Maximo: $capacidad \nDeportistas registrados: $contador \n$listadoImpr \n',
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
          title: Text('Descripcion de la clase'),
          content: Text(
            'Titulo: $titulo \nDescripcion: $des \nHorario: \n$ini a \n$fin\nAforo Maximo: $capacidad\nDeportistas Registrados: $contador',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          actions: [
            MaterialButton(
                child: Text(
                  'Ver reservas',
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