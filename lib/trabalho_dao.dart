import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trabalho5/trabalho.dart';

class TrabalhoDao {
  final databaseReference = FirebaseFirestore.instance;
  final String COLECAO = "trabalhos";

  Future<String> inserir(Trabalho trabalho) async {
    try {
      DocumentReference ref =
          await databaseReference.collection(COLECAO).add(trabalho.toMap());
      return ref.id;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> alterar(Trabalho trabalho) async{
    try {
      await databaseReference.collection(COLECAO).doc(trabalho.id).update(trabalho.toMap());
      return "Registro atualizado";
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Trabalho>> findAll() async {
    QuerySnapshot trabalhos = await databaseReference.collection(COLECAO).get();
    List<Trabalho> listaTrabalhos = List();
    trabalhos.docs.forEach((elemento) {
      listaTrabalhos.add(Trabalho.fromJson(elemento.data(), elemento.id));
    });
    return listaTrabalhos;
  }

  Future<String> excluir(String id) async{
    try {
      await databaseReference
          .collection(COLECAO)
          .doc(id)
          .delete();
      return "Registro excluído com projeto";
    } catch (e) {
      return e.toString();
    }
  }
}
