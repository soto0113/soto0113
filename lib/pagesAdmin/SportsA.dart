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
      ],
    );
  }
}