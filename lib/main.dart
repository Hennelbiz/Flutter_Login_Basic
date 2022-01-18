import 'package:flutter/material.dart';
import 'package:flutter_login_basic/Screens/login_screen.dart';
import 'package:flutter_login_basic/Screens/usuario_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login app",
      debugShowCheckedModeBanner: false,
      home: Login(),
      //home: UsuarioScreen(),
    );
  }
} 
