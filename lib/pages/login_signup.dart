import 'package:flutter/material.dart';
import 'package:ayudafinal/services/authentication.dart';

// Clase que implementa el inicio de sesión y el registro de usuarios
class LoginSignUpPage extends StatefulWidget {
  LoginSignUpPage({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _LoginSignUpPageState();
}

enum FormMode { LOGIN, SIGNUP }

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  // clave del formulario
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;

  // inicializa el formulario del login
  FormMode _formMode = FormMode.LOGIN;

  bool _isLoading;

  // comprueba si el formulario es valido antes de iniciar sesión o registro
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Inicia sesión o se registra
  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (_validateAndSave()) {
      String userId = "";
      try {
        if (_formMode == FormMode.LOGIN) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          widget.auth.sendEmailVerification();
          _showVerifyEmailSentDialog();
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 &&
            userId != null &&
            _formMode == FormMode.LOGIN) {
          widget.onSignedIn();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  // cambia al formulario de registro
  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  // cambia al formulario de login
  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }

  // muestra el interfaz
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('LOGIN DEPORTISTA'),
        ),
        body: Stack(
          children: <Widget>[
            _showBody(),
            _showCircularProgress(),
          ],
        ));
  }

  // muestra un loading
  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  // envia un correo de verificación
  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Verifica tu correo"),
          content: new Text("Hemos enviado un link a tu cuenta de correo"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Cerrar"),
              onPressed: () {
                _changeFormToLogin();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // muestra el cuerpo de la ventana logo, inputs, y botones
  Widget _showBody() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _showLogo(),
              _showEmailInput(),
              _showPasswordInput(),
              _showPrimaryButton(),
              _showSecondaryButton(),
              _showErrorMessage(),
            ],
          ),
        ));
  }

  // muestra mensaje de error
  Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  // muestra el logo
  Widget _showLogo() {
    return new Hero(
      tag: 'hero',
      child: Container(
              height: 250,
              child: Image(
                image: AssetImage("imagenes/deportista.jpg"),
                fit: BoxFit.cover,
              ),
            ),
    );
  }

  // muestra el input email
  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.all(29.0),//const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.email,
              color: Colors.blue
            ),
            border: InputBorder.none,
          ),
        validator: (value) =>
            value.isEmpty ? 'Email no puede estar vacío' : null,
        onSaved: (value) => _email = value,
      ),
    );
  }

  // muestra el input de contraseña
  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.all(29.0),//const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Contraseña',
            icon: new Icon(
              Icons.lock,
              color: Colors.blue,
            ),
            suffixIcon: Icon(
                Icons.visibility,
                color: Colors.blue,
            ),
            border: InputBorder.none,
          ),
        validator: (value) =>
            value.isEmpty ? 'Contraseña no puede estar vacía' : null,
        onSaved: (value) => _password = value,
      ),
    );
  }

  // muestra un boton para crear cuenta
  Widget _showSecondaryButton() {
    return new FlatButton(
      child: _formMode == FormMode.LOGIN
          ? new Text('¿No tienes una cuenta? Registrate',
              style: new TextStyle(fontSize: 15.0, color: Colors.blueAccent, fontWeight: FontWeight.bold))
          : new Text('¿Tienes una cuenta? Inicia Sesión',
              style:
                  new TextStyle(fontSize: 15.0, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
      onPressed: _formMode == FormMode.LOGIN
          ? _changeFormToSignUp
          : _changeFormToLogin,
    );
  }

  // muestra boton de iniciar sesion
  Widget _showPrimaryButton() {
    Size size = MediaQuery.of(context).size;
    return new Padding(
        padding: const EdgeInsets.all(29.0),//EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          width: size.width * 0.8,
          height: 50.0,
          child: new RaisedButton(
            //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            //elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(29.0)),
            color: Colors.blueAccent,
            child: _formMode == FormMode.LOGIN
                ? new Text('INICIAR SESIÓN',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white))
                : new Text('REGISTRARSE',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: _validateAndSubmit,
          ),
        ));
  }
}