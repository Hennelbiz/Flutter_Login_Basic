import 'package:flutter/material.dart';

/*Widget imagenBox(String url) {
  return SizedBox(
      height: 155.0,
      child: Image.network(
        url,
        fit: BoxFit.contain,
      ));
}*/

Widget imagenBox() {
  return SizedBox(
      height: 105.0,
      child: Image.asset(
        'assets/images/ImagenUser.png',
        fit: BoxFit.contain,
      ));
}
