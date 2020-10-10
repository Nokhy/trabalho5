import 'package:trabalho5/trabalho_dao.dart';
import 'package:trabalho5/trabalho.dart';

class TrabalhoController{
  TrabalhoDao trabalhoDao = TrabalhoDao();
  Future<String> salvar(Trabalho trabalho){
    if(trabalho.id == null){
      return trabalhoDao.inserir(trabalho);
    }else{
      return trabalhoDao.alterar(trabalho);
    }
  }

  Future<List<Trabalho>> findAll() async{
    return trabalhoDao.findAll();
  }

  Future<String> excluir(String id){
    return trabalhoDao.excluir(id);
  }
}