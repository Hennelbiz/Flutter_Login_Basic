import 'package:flutter/material.dart';
import 'package:flutter_login_basic/Services/login_service.dart' as login;

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

  @override
  void dispose() {
    usuarioControlador.dispose();
    passwordControlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text("Bienvenido"),
      ),*/
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
                  _imagenBox(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMzIkbensg1c8hPloLD7sWL62Yrg2zVSQHi6kDD180hAyETcUF1bLLt1UvwSLbTEQyFga9ckVdxqniUQ&usqp=CAU"),
                  SizedBox(
                    height: 45.0,
                  ),
                  //_campoEntradaUsuario("Usuario", usuarioControlador),
                  TextField(
                    controller: usuarioControlador,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Usuario",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      errorText: usuarioValidacion ? 'Agrega un usuario' : null,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  //_campoEntradaPassword("Contraseña"),
                  TextField(
                    controller: passwordControlador,
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
                      onPressed: () {
                        final resultadoUsuario = validarTextField(
                            usuarioControlador.text.trim(), "Usuario");
                        final resultadoPassword = validarTextField(
                            passwordControlador.text.trim(), "Password");
                        if (resultadoUsuario == false &&
                            resultadoPassword == false) {
                          login.Login().loginHttpAsync(
                              usuarioControlador.text.trim().toUpperCase(),
                              passwordControlador.text.trim());
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
}

Widget _imagenBox(String url) {
  return SizedBox(
      height: 155.0,
      child: Image.network(
        url,
        fit: BoxFit.contain,
      ));
}
