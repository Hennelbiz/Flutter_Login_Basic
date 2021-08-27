import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';
import 'package:flutter_login_basic/Models/Token.dart';
import 'package:flutter_login_basic/Globals/Global.dart';

class Login {
  String formUrlEncoded(Map data) {
    var formArray = [];
    data.forEach((k, v) {
      formArray
          .add('${Uri.encodeQueryComponent(k)}=${Uri.encodeQueryComponent(v)}');
    });
    String form = formArray.join('&');
    return form;
  }

  var headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Cookie':
        'ARRAffinity=ec2b20e7a409657b5f63402c3d381f3af504babeb730535d16c672d2e77a3a47; ARRAffinitySameSite=ec2b20e7a409657b5f63402c3d381f3af504babeb730535d16c672d2e77a3a47'
  };

  Future<String> loginAsync(String usuario, String password) async {
    //
    var request = http.Request(
        'POST', Uri.parse('https://tlaloc-dev.bdscorpnet.mx/token'));
    request.bodyFields = {
      'grant_type': 'password',
      'username': usuario,
      'password': password,
    };
    request.headers.addAll(headers);

    var response = await request.send();

    if (response.statusCode == 200) {
      print("Valor Streamed $response");
      final responseString = await response.stream.bytesToString();
      print("Valor en string $responseString");
      return responseString;
      //return valor;
    } else {
      print('Error llego aqui');
      throw Exception(("Imposible to make the request"));
    }
  }

  Future<Tuple2<bool, String>> loginHttpAsync(
      String usuario, String password) async {
    Map<String, dynamic> formMap = {
      "grant_type": "password",
      "username": usuario,
      "password": password
    };

    try {
      final response = await http.post(
          Uri.parse('https://tlaloc-dev.bdscorpnet.mx/token'),
          body: formUrlEncoded(formMap));

      //var valorEstatus = response.statusCode;
      //var valorBody = response.body;
      //var prueba1 = jsonDecode(response.body);
      //var prueba3 = json.decode(response.body);
      //var prueba4 = valorDecodificado["access_token"];
      if (response.statusCode == 200) {
        var valorDecode = utf8.decode(response.bodyBytes);
        final valorDecodificado = jsonDecode(valorDecode);

        valoresToken = Token(
            valorDecodificado["access_token"],
            valorDecodificado["token_type"],
            valorDecodificado["userName"],
            valorDecodificado["tokenSyglobal"]);
        return Tuple2(true, 'Bienvenido');
      }
    } catch (e) {
      return Tuple2(false, 'Error de conexión');
    }
    //print("Estatus code: $valorEstatus. Body: $valorBody");
    return Tuple2(false, 'Error al verificar el usuario y/o contraseña');
  }
}
