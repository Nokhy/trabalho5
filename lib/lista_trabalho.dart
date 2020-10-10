import 'package:trabalho5/trabalho_item.dart';
import 'package:trabalho5/trabalho_controller.dart';
import 'package:trabalho5/trabalho.dart';
import 'package:flutter/material.dart';

import 'cadastro_trabalho.dart';

class ListaTrabalho extends StatefulWidget {
  @override
  _ListaTrabalhoState createState() => _ListaTrabalhoState();
}
class _ListaTrabalhoState extends State<ListaTrabalho> {
  List<Trabalho> _listaTrabalhos = [];
  TrabalhoController _trabalhoController = TrabalhoController();
  @override
  void initState() {
    super.initState();
    _trabalhoController.findAll().then((dados) {
      setState(() {
        _listaTrabalhos = dados;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Lista de trabalhos"),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<Trabalho>>(
        initialData: _listaTrabalhos,
        future: _trabalhoController.findAll(),
        // ignore: missing_return
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("Carregando..."),
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Trabalho> trabalhos = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index){
                  final Trabalho trabalho = trabalhos[index];
                  return TrabalhoItem(trabalho,_listaTrabalhos,index);
                },
                itemCount: trabalhos.length,
              );
              break;
          }
          return Text("Erro");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CadastroTrabalho(),
              ),
            );
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple[800],
      ),
    );
  }
}