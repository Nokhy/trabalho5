import 'package:trabalho5/cadastro_trabalho.dart';
import 'package:trabalho5/lista_trabalho.dart';
import 'package:flutter/material.dart';
import 'package:trabalho5/trabalho_controller.dart';
import 'package:trabalho5/trabalho.dart';


class TrabalhoItem extends StatefulWidget {
  Trabalho _trabalho;
  List<Trabalho> _listaTrabalhos;
  int _index;
  TrabalhoItem(this._trabalho, this._listaTrabalhos, this._index);
  @override
  _TrabalhoItemState createState() => _TrabalhoItemState();
}

class _TrabalhoItemState extends State<TrabalhoItem> {
  Trabalho _ultimoRemovido;
  TrabalhoController _trabalhoController = TrabalhoController();
  _atualizarLista() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListaTrabalho(),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: Card(
        color: Colors.deepPurple[800],
        child: ListTile(
          title: Text(
            widget._trabalho.descricao,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white
            ),
          ),
          subtitle: Text("Restando apenas: " +
            widget._trabalho.cargaHoraria.toString() + " Dia(s)"
            ,
            style: TextStyle(
              fontSize: 16.0, color: Colors.white
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CadastroTrabalho(
                  trabalho: widget._listaTrabalhos[widget._index],
                ),
              ),
            );
          },
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          mostrarAlerta(context);
        });
      },
    );
  }
  mostrarAlerta(BuildContext context) {
    Widget botaoNao = FlatButton(
      child: Text(
        "Não",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        _atualizarLista();
      },
    );
    Widget botaoSim = FlatButton(
      child: Text(
        "Sim",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () {
        _ultimoRemovido = widget._listaTrabalhos[widget._index];
        widget._listaTrabalhos.removeAt(widget._index);
        _trabalhoController.excluir(_ultimoRemovido.id);
        _atualizarLista();
      },
    );
    AlertDialog alerta = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: Colors.deepPurple[800],
      title: Text(
        "Aviso",
        style: TextStyle(color: Colors.black),
      ),
      content: Text(
        "Deseja apagar o registro?",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        botaoNao,
        botaoSim,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
}