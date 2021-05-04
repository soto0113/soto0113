import 'package:ayudafinal/pages/root_page.dart';
import 'package:ayudafinal/pagesAdmin/root_pageA.dart';
import 'package:flutter/material.dart';
import 'package:ayudafinal/services/authentication.dart';

class comenzar extends StatefulWidget {
  @override
  _comenzarState createState() => _comenzarState();
}

class _comenzarState extends State<comenzar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 81.0),
            RichText(
                text: TextSpan(
                  text:'          BIENVENIDO A \n     SPORTS TRAINING      ', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
                )
            ),
            SizedBox(height: 15.0),
            Container(
              width: 360,
              height: 250,
              child: Image(
                image: AssetImage("imagenes/principal.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 50.0),
            Column( mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 85),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=> new RootPage(auth: new Auth()), )
                      );
                    },
                    child: Text('USUARIO',
                      style:
                      TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.black
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(29.0),
                    ),
                    color: Colors.redAccent
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=> new RootPageA(auth: new Auth(),))
                      );
                    },
                    child: Text('ADMINISTRADOR',
                      style:
                      TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.black
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(29.0),
                    ),
                    color: Colors.redAccent
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
