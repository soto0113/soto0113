import 'package:ayudafinal/actividades.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Info extends StatelessWidget {
  static const String _title = 'SPORTS TRAINING';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        home: Scaffold(
          appBar: AppBar(
            title: Text(_title),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),
          ),
          body: MyStatelessWidget(),
        ),
        theme: ThemeData(
          brightness: Brightness.dark,
        ));
  }
}

class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Image.asset(
              'imagenes/principal.jpg',
              width: 600.0,
              height: 240.0,
              fit: BoxFit.cover,
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 20,
          ),
          child: Text(
            'Horario',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Abrimos de Lunes a Viernes de 6:00 a 17:00',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            )),
        Padding(
          padding: const EdgeInsets.all(29.0),//EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
          child: SizedBox(
            height: 50.0,
            child: new RaisedButton(
            //elevation: 5.0,
              child: Text('ACTIVIDADES',
                      style:
                      TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white
                      ),
                    ),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(29.0)),
              color: Colors.white12,
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> rutina(), )
                );
              },
          ),
        )),
      ],
    );
  }
} 