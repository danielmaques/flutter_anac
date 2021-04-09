import 'package:anac_simulado/models/questao_model.dart';
import 'package:anac_simulado/services/database.dart';
import 'package:anac_simulado/views/resultados.dart';
import 'package:anac_simulado/widgets/simulado_play.dart';
import 'package:anac_simulado/widgets/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Simulado extends StatefulWidget {
  final String simuladoId;

  Simulado(
      this.simuladoId,
      );

  @override
  _SimuladoState createState() => _SimuladoState();
}

int total = 0;
int _corretas = 0;
int _incorretas = 0;
int _naoRespondidas = 0;

class _SimuladoState extends State<Simulado> {
  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questaoSnapshot;

  QuestaoModel getQuestaoModelDatasnapshot(DocumentSnapshot questaoSnapshot) {
    QuestaoModel questaoModel = new QuestaoModel();
    questaoModel.questao = questaoSnapshot.data()["questao"];
    List<String> opcao = [
      questaoSnapshot.data()["opcao1"],
      questaoSnapshot.data()["opcao2"],
      questaoSnapshot.data()["opcao3"],
      questaoSnapshot.data()["opcao4"],
    ];
    opcao.shuffle();
    questaoModel.opcao1 = opcao[0];
    questaoModel.opcao2 = opcao[1];
    questaoModel.opcao3 = opcao[2];
    questaoModel.opcao4 = opcao[3];
    questaoModel.opcaoCorreta = questaoSnapshot.data()["opcao1"];
    questaoModel.respondidas = false;

    return questaoModel;
  }

  @override
  void initState() {
    print("${widget.simuladoId}");
    databaseService.getQustoes(widget.simuladoId).then((value) {
      questaoSnapshot = value;

      _naoRespondidas = 0;
      _corretas = 0;
      _incorretas = 0;
      total = questaoSnapshot.docs.length;

      print("$total total");

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black54),
        brightness: Brightness.dark, //barra superior de notificação
      ),
      body: Container(
        child: ListView(
          children: [
            questaoSnapshot == null
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: questaoSnapshot.docs.length,
                    itemBuilder: (context, index) {
                      return SimuladoPlayTile(
                        questaoModel: getQuestaoModelDatasnapshot(
                            questaoSnapshot.docs[index]),
                        index: index,
                      );
                    },
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Resultados(
            correta: _corretas,
            incorreta: _incorretas,
            total: total,
            faltou: _corretas + _incorretas - total,
          )
          ));
        },
      ),
    );
  }
}

class SimuladoPlayTile extends StatefulWidget {
  final QuestaoModel questaoModel;
  final int index;

  SimuladoPlayTile({this.questaoModel, this.index});

  @override
  _SimuladoPlayTileState createState() => _SimuladoPlayTileState();
}

class _SimuladoPlayTileState extends State<SimuladoPlayTile> {
  String opcaoSelecionada = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "Q${widget.index + 1} - ${widget.questaoModel.questao}",
            style: TextStyle(fontSize: 17, color: Colors.black87),
          ),
          SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              if (!widget.questaoModel.respondidas) {
                ///CORRETAS
                if (widget.questaoModel.opcao1 ==
                    widget.questaoModel.opcaoCorreta) {
                  opcaoSelecionada = widget.questaoModel.opcao1;
                  widget.questaoModel.respondidas = true;
                  _corretas = _corretas + 1;
                  _naoRespondidas = _naoRespondidas - 1;
                  print("${widget.questaoModel.opcaoCorreta}");
                  setState(() {});
                } else {
                  opcaoSelecionada = widget.questaoModel.opcao1;
                  widget.questaoModel.respondidas = true;
                  _incorretas = _incorretas + 1;
                  _naoRespondidas = _naoRespondidas - 1;
                  setState(() {});
                }
              }
            },
            child: SimuladoWidgets(
              opcoes: "A",
              descricao: widget.questaoModel.opcao1,
              opcaoCorreta: widget.questaoModel.opcaoCorreta,
              opcaoSelecionada: opcaoSelecionada,
            ),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (!widget.questaoModel.respondidas) {
                ///CORRETAS
                if (widget.questaoModel.opcao2 ==
                    widget.questaoModel.opcaoCorreta) {
                  opcaoSelecionada = widget.questaoModel.opcao2;
                  widget.questaoModel.respondidas = true;
                  _corretas = _corretas + 1;
                  _naoRespondidas = _naoRespondidas - 1;
                  setState(() {});
                } else {
                  opcaoSelecionada = widget.questaoModel.opcao2;
                  widget.questaoModel.respondidas = true;
                  _incorretas = _incorretas + 1;
                  _naoRespondidas = _naoRespondidas - 1;
                  setState(() {});
                }
              }
            },
            child: SimuladoWidgets(
              opcoes: "B",
              descricao: widget.questaoModel.opcao2,
              opcaoCorreta: widget.questaoModel.opcaoCorreta,
              opcaoSelecionada: opcaoSelecionada,
            ),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (!widget.questaoModel.respondidas) {
                ///CORRETAS
                if (widget.questaoModel.opcao3 ==
                    widget.questaoModel.opcaoCorreta) {
                  opcaoSelecionada = widget.questaoModel.opcao3;
                  widget.questaoModel.respondidas = true;
                  _corretas = _corretas + 1;
                  _naoRespondidas = _naoRespondidas - 1;
                  setState(() {});
                } else {
                  opcaoSelecionada = widget.questaoModel.opcao3;
                  widget.questaoModel.respondidas = true;
                  _incorretas = _incorretas + 1;
                  _naoRespondidas = _naoRespondidas - 1;
                  setState(() {});
                }
              }
            },
            child: SimuladoWidgets(
              opcoes: "C",
              descricao: widget.questaoModel.opcao3,
              opcaoCorreta: widget.questaoModel.opcaoCorreta,
              opcaoSelecionada: opcaoSelecionada,
            ),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (!widget.questaoModel.respondidas) {
                ///CORRETAS
                if (widget.questaoModel.opcao4 ==
                    widget.questaoModel.opcaoCorreta) {
                  opcaoSelecionada = widget.questaoModel.opcao4;
                  widget.questaoModel.respondidas = true;
                  _corretas = _corretas + 1;
                  _naoRespondidas = _naoRespondidas - 1;
                  setState(() {});
                } else {
                  opcaoSelecionada = widget.questaoModel.opcao4;
                  widget.questaoModel.respondidas = true;
                  _incorretas = _incorretas + 1;
                  _naoRespondidas = _naoRespondidas - 1;
                  setState(() {});
                }
              }
            },
            child: SimuladoWidgets(
              opcoes: "D",
              descricao: widget.questaoModel.opcao4,
              opcaoCorreta: widget.questaoModel.opcaoCorreta,
              opcaoSelecionada: opcaoSelecionada,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
