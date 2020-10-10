import 'package:flutter/material.dart';
Widget criaTextField(
    String label,
    TextEditingController controle,
    TextInputType textInputType,
    ) {
  return TextField(
    controller: controle,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.deepPurple[800]),
      border: OutlineInputBorder(),
    ),
    style: TextStyle(color: Colors.deepPurple[800], fontSize: 15.0),
    keyboardType: textInputType,
  );
}