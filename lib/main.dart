import 'package:trabalho5/lista_trabalho.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TrabalhoApp());
}
class TrabalhoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepPurple[800],
        accentColor: Colors.deepPurple[800],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.deepPurple[800],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: ListaTrabalho(),
    );
  }
}