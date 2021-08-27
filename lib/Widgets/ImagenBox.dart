import 'package:flutter/material.dart';

Widget imagenBox(String url) {
  return SizedBox(
      height: 155.0,
      child: Image.network(
        url,
        fit: BoxFit.contain,
      ));
}