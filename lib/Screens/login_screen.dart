import 'package:flutter/material.dart';
import 'package:flutter_login_basic/Services/login_service.dart' as login;
import 'package:flutter_login_basic/Widgets/ImagenBox.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usuarioControlador = TextEditingController();
  final passwordControlador = TextEditingController();
  bool usuarioValidacion = false;
  bool passwordValidacion = false;
  String? descripcionAlerta;

  @override
  void dispose() {
    usuarioControlador.dispose();
    passwordControlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Container(
        child: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
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
                      errorText: usuarioValidacion ? 'Agrega un usuario' : null,
                    ),
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
                          borderRadius: BorderRadius.circular(32.0)),
                      errorText:
                          passwordValidacion ? 'Agrega una contraseña' : null,
                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final resultadoUsuario = validarTextField(
                            usuarioControlador.text.trim(), "Usuario");
                        final resultadoPassword = validarTextField(
                            passwordControlador.text.trim(), "Password");
                        if (resultadoUsuario == false &&
                            resultadoPassword == false) {
                          //login.Login().loginHttpAsync(
                          //usuarioControlador.text.trim().toUpperCase(),
                          //passwordControlador.text.trim());
                          var resultLogin = await login.Login().loginHttpAsync(
                              usuarioControlador.text.trim().toUpperCase(),
                              passwordControlador.text.trim());
                          if (resultLogin.item1) {
                          } else {
                            descripcionAlerta = resultLogin.item2;
                            _mostrarAlerta(context);
                          }
                        }
                      },
                      child: const Text('Entrar'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validarTextField(String valor, String tipo) {
    if (tipo == "Usuario") {
      if (valor.isEmpty) {
        setState(() {
          usuarioValidacion = true;
        });
      } else {
        setState(() {
          usuarioValidacion = false;
        });
      }
    } else if (tipo == "Password") {
      if (valor.isEmpty) {
        setState(() {
          passwordValidacion = true;
        });
      } else {
        setState(() {
          passwordValidacion = false;
        });
      }
    }

    if (valor.isEmpty) {
      return true;
    } else {
      return false;
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
                    onPressed: () => {
                          Navigator.pop(context),
                        },
                    child: Text('Cancelar')),
                TextButton(
                    onPressed: () => {Navigator.pop(context)},
                    child: Text('Ok')),
              ],
            ));
  }
}
