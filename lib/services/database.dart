
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  /*static const AUTO_ID_ALPHABET = '0123456789';
  static const AUTO_ID_LENGTH = 2;
  String _getAutoId() {
    final buffer = StringBuffer();
    final random = Random.secure();

    final maxRandom = AUTO_ID_ALPHABET.length;

    for (int i = 0; i < AUTO_ID_LENGTH; i++) {
      buffer.write(AUTO_ID_ALPHABET[random.nextInt(maxRandom)]);
    }
    return buffer.toString();
  }*/



  Future<void> addSimuladoData(Map simuladoData, String simuladoId) async {
    await FirebaseFirestore.instance
        .collection("Simulado")
        .doc(simuladoId)
        .set(simuladoData)
        .catchError((e) {
      print(e.toString());
    });
  }
  Future<void> addQuestaoData(Map questaoData, String simuladoId) async{
    await FirebaseFirestore.instance
        .collection("Simulado")
        .doc(simuladoId)
        .collection("QNA")
        .add(questaoData)
        .catchError((e){
          print(e);
    });
  }
  
  getSimuladoData() async {
    return await FirebaseFirestore.instance.collection("Simulado").snapshots();
  }

  getQustoes(String simuladoId) async{
    return await FirebaseFirestore.instance
        .collection("Simulado")
        .doc(simuladoId)
        .collection("QNA")
    //.where('id', isGreaterThanOrEqualTo: autoId)
        .limit(20)
        .get();
  }
}
