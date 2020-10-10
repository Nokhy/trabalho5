import 'package:trabalho5/cria_deopdown.dart';
import 'package:trabalho5/cria_textfield.dart';
import 'package:trabalho5/trabalho_controller.dart';
import 'package:trabalho5/trabalho.dart';
import 'package:flutter/material.dart';

import 'lista_trabalho.dart';

class CadastroTrabalho extends StatefulWidget {
  final Trabalho trabalho;
  CadastroTrabalho({this.trabalho});
  @override
  _CadastroTrabalhoState createState() => _CadastroTrabalhoState();
}
class _CadastroTrabalhoState extends State<CadastroTrabalho> {
  TrabalhoController _trabalhoController = TrabalhoController();
  String _id;
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _cargaHorariaController = TextEditingController();
  TextEditingController _materiaController = TextEditingController();
  var _materia = ["Optativa II", "Compiladores", "Arquitetura II", "Engenharia de Software", "Cálculo III", "Estrutura de Dados"];
  var _materiaSelecionada = "Optativa II";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _alterarMateria(String novaMateriaSelecionada) {
    _dropDownMateriaSelected(novaMateriaSelecionada);
    setState(() {
      this._materiaSelecionada = novaMateriaSelecionada;
      _materiaController.text = this._materiaSelecionada;
    });
  }
  _dropDownMateriaSelected(String novaMateria) {
    setState(() {
      this._materiaSelecionada = novaMateria;
    });
  }
  _displaySnackBar(BuildContext context, String mensagem) {
    final snackBar = SnackBar(
      content: Text(mensagem),
      backgroundColor: Colors.green[900],
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
  _salvar(BuildContext context) {
    Trabalho trabalho = Trabalho(_descricaoController.text,
        int.parse(_cargaHorariaController.text), _materiaSelecionada,
        id: _id);
    setState(() {
      _trabalhoController.salvar(trabalho).then((res) {
        setState(() {
          _displaySnackBar(context, res.toString());
          /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListaTrabalho()),
          );*/
        });
      });
    });
  }
  @override
  void initState() {
    if(widget.trabalho != null){
      _id = widget.trabalho.id;
      _descricaoController.text = widget.trabalho.descricao;
      _cargaHorariaController.text = widget.trabalho.cargaHoraria.toString();
      _materiaSelecionada = widget.trabalho.materia;
    }else{
      _id = null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Cadastro de trabalho"),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListaTrabalho()),
              );
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: criaTextField("Descrição Tarefa", _descricaoController, TextInputType.text),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: criaTextField("Dias restantes", _cargaHorariaController,
                  TextInputType.number),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Materia:",
                    style: TextStyle(color: Colors.deepPurple[800]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: criaDropDownButton(_materia, _alterarMateria,
                        _materiaSelecionada),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton.icon(
                  onPressed: () {
                    _salvar(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  label: Text(
                    'Salvar',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  textColor: Colors.white,
                  splashColor: Colors.green,
                  color: Colors.deepPurple[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}