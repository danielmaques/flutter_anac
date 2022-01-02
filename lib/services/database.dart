// ignore_for_file: import_of_legacy_library_into_null_safe, await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addSimuladoData(Map simuladoData, String simuladoId) async {
    await FirebaseFirestore.instance
        .collection("Simulado")
        .doc(simuladoId)
        .set({"simuladoData": simuladoData}).catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuestaoData(Map questaoData, String simuladoId) async {
    await FirebaseFirestore.instance
        .collection("Simulado")
        .doc(simuladoId)
        .collection("QNA")
        .add({"questaoData": questaoData}).catchError((e) {
      print(e);
    });
  }

  getSimuladoData() async {
    return await FirebaseFirestore.instance.collection("Simulado").snapshots();
  }

  getQustoes(String simuladoId) async {
    return await FirebaseFirestore.instance
        .collection("Simulado")
        .doc(simuladoId)
        .collection("QNA")
        .limit(20)
        .get();
  }
}
