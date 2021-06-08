import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CrearActividad extends StatefulWidget {
  CrearActividad({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _CrearActividadState createState() => _CrearActividadState();
}

class _CrearActividadState extends State<CrearActividad> {
  CalendarController _controller;
  List<dynamic> _selectedEvents;
  Map<DateTime, List<dynamic>> _events;
  TextEditingController _eventController;
  TextEditingController _eventosController;
  TextEditingController _descriController;
  Stream events;
  var cantGente;
  String titulo = "";
  String usuario = "";
  String horaI = "12";
  String horaF = "24";
  String minI = "1";
  String minF = "1";
  String nombreEvento = "";
  String descEvento = "";
  SharedPreferences prefs;
  var Minutos = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50',
    '51',
    '52',
    '53',
    '54',
    '55',
    '56',
    '57',
    '58',
    '59',
    '60'
  ];
  var Horas = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24'
  ];
  String numero = "";

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _eventosController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    prefsDAta();
  }

  prefsDAta() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programar Horarios'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          TableCalendar(
            events: _events,
            initialCalendarFormat: CalendarFormat.month,
            calendarStyle: CalendarStyle(
                canEventMarkersOverflow: true,
                todayColor: Colors.deepPurple,
                selectedColor: Theme.of(context).primaryColor,
                todayStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.greenAccent)),
            headerStyle: HeaderStyle(
              centerHeaderTitle: true,
              formatButtonDecoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(50.0),
              ),
              formatButtonTextStyle: TextStyle(color: Colors.greenAccent),
              formatButtonShowsNext: false,
            ),
            startingDayOfWeek: StartingDayOfWeek.sunday,
            onDaySelected: (date, events, holidays) {
              setState(() {
                _selectedEvents = events;
              });
            },
            builders: CalendarBuilders(
              selectedDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.greenAccent),
                  )),
              todayDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.greenAccent),
                  )),
            ),
            calendarController: _controller,
          ),
          ..._selectedEvents.map((event) => ListTile(
                title: Text(
                  "\n " + event + "   \n",
                  style: TextStyle(
                    backgroundColor: Colors.blue,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
              )),
          Container(
            margin: EdgeInsets.only(left: 70.0, right: 70.0),
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                )),
            child: TextField(
              onChanged: (texto) {
                numero = texto;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: ' Aforo maximo de la clase? ',
                filled: true,
                fillColor: Colors.black,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ), 
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(left: 40.0, right: 35.0),
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                )),
            child: TextField(
              onChanged: (texto) {
                nombreEvento = texto;
              },
              controller: _eventosController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: ' Nombre de la actividad ',
                filled: true,
                fillColor: Colors.black,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(left: 40.0, right: 35.0),
            decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                )),
            child: TextField(
              onChanged: (texto) {
                descEvento = texto;
              },
              controller: _descriController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: ' Descripción de la actividad ',
                filled: true,
                fillColor: Colors.black,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.all(30.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                border: Border.all(
                  color: Colors.black,
                  width: 5,
                )),
            child: Text(
              '\nSelecciona el horario de la actividad\n',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            child: Text(
              ' De:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 15),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hora:  ',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.black, border: Border.all()),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: Horas.map((String a) {
                          return DropdownMenuItem(value: a, child: Text(a));
                        }).toList(),
                        onChanged: (_value) => {
                          setState(() {
                            this.horaI = _value;
                          })
                        },
                        value: horaI,
                        dropdownColor: Colors.black,
                        isExpanded: false,
                        hint: Text("Hora"),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    ' :  ',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.black, border: Border.all()),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: Minutos.map((String a) {
                          return DropdownMenuItem(value: a, child: Text(a));
                        }).toList(),
                        onChanged: (_value) => {
                          setState(() {
                            this.minI = _value;
                          })
                        },
                        value: minI,
                        dropdownColor: Colors.black,
                        isExpanded: false,
                        hint: Text("Minutos"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 15),
          Container(
            child: Text(
              ' a:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hora:  ',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.black, border: Border.all()),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: Horas.map((String a) {
                          return DropdownMenuItem(value: a, child: Text(a));
                        }).toList(),
                        onChanged: (_value) => {
                          setState(() {
                            this.horaF = _value;
                          })
                        },
                        value: horaF,
                        dropdownColor: Colors.black,
                        isExpanded: false,
                        hint: Text("Hora"),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    ' :  ',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.black, border: Border.all()),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: Minutos.map((String a) {
                          return DropdownMenuItem(value: a, child: Text(a));
                        }).toList(),
                        onChanged: (_value) => {
                          setState(() {
                            this.minF = _value;
                          })
                        },
                        value: minF,
                        dropdownColor: Colors.black,
                        isExpanded: false,
                        hint: Text("Minutos"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.only(left: 100.0, right: 100.0),
            decoration:
                BoxDecoration(color: Colors.black, border: Border.all()),
            child: MaterialButton(
              minWidth: 20.0,
              height: 50.0,
              disabledColor: Colors.black,
              child: Text('Programar',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              splashColor: Colors.deepPurple,
              color: Colors.greenAccent,
              elevation: 30.0,
              onPressed: () {
                var controlF = _controller.selectedDay;
                var dia = controlF.day;
                var mes = controlF.month;
                var ano = controlF.year;
                print('$dia/$mes/$ano');
                int num = int.parse(numero);
                bool esta = existeActividad(dia, mes, ano, horaI,
                    minI, horaF, minF, nombreEvento, descEvento, num);
                print("$esta");
                if (esta == true) {
                  if (esta == true) {
                    dialogoProgramo(context);
                  }
                  if (_eventosController.text.isEmpty) return;

                  if (_events[_controller.selectedDay] != null) {
                    _events[_controller.selectedDay]
                        .add(_eventosController.text);
                  } else {
                    _events[_controller.selectedDay] = [
                      _eventosController.text
                    ];
                  }
                  prefs.setString("Ejercicios", json.encode(encodeMap(_events)));
                  _eventController.clear();
                }

                if (esta == false) {
                  dialogoAlerta(context);
                }
              },
            ),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }

  final databaseReference = Firestore.instance;

  void createRecord(DateTime fechaIni, DateTime fechaFin, String titulo,
      String descripcion, int capacidad) async {
    var listado = new List(capacidad);
    DocumentReference ref = await databaseReference.collection("Ejercicios").add({
      'Fecha Inicio': fechaIni,
      'Fecha Fin': fechaFin,
      'Titulo': titulo,
      'Descripcion': descripcion,
      'Capacidad': capacidad,
      'Participantes': listado,
      'Total participantes': 0,
    });
  }

  Future dialogoProgramo(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Actividad programada'),
          content: const Text('Exitosamente!!'),
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

  Future dialogoAlerta(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error!!'),
          content: const Text('No sé pudo programar la actividad'),
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

  bool existeActividad(
      var dia,
      var mes,
      var anno,
      String horaIni,
      String minIni,
      String horaFin,
      String minFin,
      String titulo,
      String descripcion,
      int cantidad) {
    bool esta;
    int HoraI = int.parse(horaIni);
    int MinI = int.parse(minIni);
    int HoraF = int.parse(horaFin);
    int MinF = int.parse(minFin);
    DateTime fechaHoy = DateTime.now();
    var diaHoy = fechaHoy.day;
    var mesHoy = fechaHoy.month;
    var fechaAgendada =
        DateTime.utc(anno, mes, dia, HoraI, MinI);

    if (diaHoy == dia && mesHoy == mes) {
      esta = false;
    } else {
      esta = true;
    }
    if (esta == true) {
      var fechaFin =
          DateTime.utc(anno, mes, dia, HoraF, MinF);
      print(
          '$dia / $mes / $anno/ $HoraI /$MinI / $HoraF / $MinF\n ');
      createRecord(fechaAgendada, fechaFin, titulo, descripcion, cantidad);
    }
    return esta;
  }
} 