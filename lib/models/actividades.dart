import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class rutina extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GridView.count(
            crossAxisCount: 2,
            children: <Widget>[
              Muestra(
                child: RaisedButton(
                  child: Image(
                    height: 100,
                    image: AssetImage("imagenes/yoga.jpg"),
                  ),
                  onPressed: (){
                    print('epa');
                  },
                ),
                text:'Yoga',
              ),
              Muestra(
                child: RaisedButton(
                  child: Image(
                    height: 100,
                    image: AssetImage("imagenes/pilates.jpg"),
                  ),
                  onPressed: (){
                    print('epa');
                  },
                ),
                text:'Pilates',
              ),
              Muestra(
                child: RaisedButton(
                  child: Image(
                    height: 100,
                    image: AssetImage("imagenes/crossfit.jpg"),
                  ),
                  onPressed: (){
                    print('epa');
                  },
                ),
                text:'Crossfit',
              ),
              Muestra(
                child: RaisedButton(
                  child: Image(
                    height: 100,
                    image: AssetImage("imagenes/boxing.jpg"),
                  ),
                  onPressed: (){
                    print('epa');
                  },
                ),
                text:'Boxing',
              ),
              Muestra(
                child: RaisedButton(
                  child: Image(
                    height: 100,
                    image: AssetImage("imagenes/spining.png"),
                  ),
                  onPressed: (){
                    print('epa');
                  },
                ),
                text:'Spining',
              ),
              Muestra(
                child: RaisedButton(
                  child: Image(
                    height: 100,
                    image: AssetImage("imagenes/stretching.jpg"),
                  ),
                  onPressed: (){
                    print('epa');
                  },
                ),
                text:'Stretching',
              ),
              Muestra(
                child: RaisedButton(
                  child: Image(
                    height: 100,
                    image: AssetImage("imagenes/aerorumba.png"),
                  ),
                  onPressed: (){
                    print('epa');
                  },
                ),
                text:'Aerorumba',
              ),
              Muestra(
                child: RaisedButton(
                  child: Image(
                    height: 100,
                    image: AssetImage("imagenes/combat.jpg"),
                  ),
                  onPressed: (){
                    print('epa');
                  },
                ),
                text:'Body combat',
              ),
            ],
        ),
      ),
    );
  }
}

class Muestra extends StatelessWidget {
  final Widget child;
  final String text;
  const Muestra({
    Key key,
    @required this.child,
    @required this.text,
}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              this.child,
              SizedBox(height: 15),
              Text(this.text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
