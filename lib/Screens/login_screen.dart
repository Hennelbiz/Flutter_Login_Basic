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
  bool resultadoValidacionUsuario = false;
  bool resultadoValidacionPassword = false;
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
    //final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0; //Obtiene la parte del display que esta obscura que suele ser del teclado en la parte de abajo y si es asi quita el logo

    return Scaffold(
      //resizeToAvoidBottomInset: false, //Para quitar el mensaje de overflow pero el teclado sigue apareciendo sobre los elementos
      body: Container(
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
                      errorText:
                          usuarioValidacion ? 'Agrega un usuario' : null),
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
                          passwordValidacion ? 'Agrega una contraseña' : null),
                ),
                SizedBox(
                  height: 35.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    resultadoValidacionUsuario = validarTextField(
                        usuarioControlador.text.trim(), "Usuario");
                    resultadoValidacionPassword = validarTextField(
                        passwordControlador.text.trim(), "Password");
                    if (!resultadoValidacionUsuario &&
                        !resultadoValidacionPassword) {
                      var resultadoLogin = await login.Login().loginHttpAsync(
                          usuarioControlador.text.trim().toUpperCase(),
                          passwordControlador.text);
                      if (resultadoLogin.item1) {
                        descripcionAlerta = resultadoLogin.item2;
                        _mostrarAlerta(context);
                      } else {
                        descripcionAlerta = resultadoLogin.item2;
                        _mostrarAlerta(context);
                      }
                    }
                  },
                  child: const Text('Entrar'),
                )
              ],
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
                    onPressed: () => {Navigator.pop(context)},
                    child: Text('Ok')),
              ],
            ));
  }
}
