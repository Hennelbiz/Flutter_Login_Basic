import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenido"),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: 
              [
                _imagenBox("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMzIkbensg1c8hPloLD7sWL62Yrg2zVSQHi6kDD180hAyETcUF1bLLt1UvwSLbTEQyFga9ckVdxqniUQ&usqp=CAU"),
                SizedBox(height: 45.0,),
                _campoEntrada(false, "Usuario"),
                SizedBox(height: 25.0,),
                _campoEntrada(true, "Contraseña"),
                SizedBox(height: 35.0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _campoEntrada(bool isPassword, String textoBoton)
{
  return TextField(
    obscureText: isPassword,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      hintText: textoBoton,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
    ),
  );
}

Widget _imagenBox(String url)
{
  return SizedBox(
    height: 155.0,
    child: Image.network(url, fit: BoxFit.contain,)
  );
}