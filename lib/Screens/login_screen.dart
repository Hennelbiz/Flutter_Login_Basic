import 'package:flutter/material.dart';
import 'package:flutter_login_basic/Services/login_service.dart';
import 'package:flutter_login_basic/Widgets/ImagenBox.dart';
import 'package:flutter_login_basic/Screens/usuario_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usuarioControlador = TextEditingController();
  final passwordControlador = TextEditingController();
  bool isUserCorrect = true;
  bool isPasswordCorrect = true;
  String? descripcionAlerta;
  bool loginSucess = false;
  bool isLoading = false;

  @override
  void dispose() {
    usuarioControlador.dispose();
    passwordControlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                imagenBox(),
                SizedBox(
                  height: 45.0,
                ),
                TextField(
                  controller: usuarioControlador,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Usuario",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      errorText: isUserCorrect ? null : 'Agrega un usuario'),
                ),
                SizedBox(
                  height: 25.0,
                ),
                TextField(
                  controller: passwordControlador,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Contraseña",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32)),
                      errorText:
                          isPasswordCorrect ? null : 'Agrega una contraseña'),
                ),
                SizedBox(
                  height: 35.0,
                ),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          _validacionDatos();
                          if (!isUserCorrect && !isPasswordCorrect) {
                            descripcionAlerta =
                                "Error en el usuario y/o contraseña";
                            _mostrarAlerta(context);
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            await _handleSignIn();
                            setState(() {
                              isLoading = false;
                            });
                          }

                          if (loginSucess) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UsuarioScreen()));
                          } else {
                            _mostrarAlerta(context);
                          }
                        },
                        child: const Text('Entrar'),
                      )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  _handleSignIn() async {
    var resultadoLogin = await LoginService().loginHttpAsync(
        usuarioControlador.text.trim().toUpperCase(), passwordControlador.text);

    if (!resultadoLogin.item1) {
      setState(() {
        descripcionAlerta = resultadoLogin.item2;
        loginSucess = resultadoLogin.item1;
      });
    } else {
      setState(() {
        loginSucess = resultadoLogin.item1;
      });
    }
  }

  _validacionDatos() {
    if (usuarioControlador.text.isEmpty) {
      setState(() {
        isUserCorrect = false;
      });
    } else {
      setState(() {
        isUserCorrect = true;
      });
    }

    if (passwordControlador.text.isEmpty) {
      setState(() {
        isPasswordCorrect = false;
      });
    } else {
      setState(() {
        isPasswordCorrect = true;
      });
    }
  }

  void _mostrarAlerta(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Error'),
              content: Text('$descripcionAlerta'),
              actions: [
                TextButton(
                    onPressed: () => {Navigator.pop(context)},
                    child: Text('Ok')),
              ],
            ));
  }
}
