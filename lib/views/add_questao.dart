// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../services/database.dart';
import '../widgets/widgets.dart';

class AddQuestao extends StatefulWidget {
  final String simuladoId;

  AddQuestao(this.simuladoId);

  @override
  _AddQuestaoState createState() => _AddQuestaoState();
}

class _AddQuestaoState extends State<AddQuestao> {
  final _formKey = GlobalKey<FormState>();
  late String questao, opcao1, opcao2, opcao3, opcao4;
  bool _isLoading = false;

  DatabaseService databaseService = new DatabaseService();

  atulaizarQuestaoDta() async {
    if (_formKey.currentState!.validate()) {

      setState(() {
        _isLoading = true;
      });

      Map<String, String> questaoMap = {
        "questao": questao,
        "opcao1": opcao1,
        "opcao2": opcao2,
        "opcao3": opcao3,
        "opcao4": opcao4
      };

      await databaseService.addQuestaoData(questaoMap, widget.simuladoId)
      .then((value){
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,

        brightness: Brightness.dark, //barra superior de notificação
      ),
      body: _isLoading ? Container(
        child: Container(child: CircularProgressIndicator(),),
      ) : Form(
        key: _formKey,
        child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) => val!.isEmpty ? "Questão" : null,
                      decoration: InputDecoration(hintText: "Questão"),
                      onChanged: (val) {
                        questao = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? "Opção" : null,
                      decoration:
                          InputDecoration(hintText: "Opcção1 (Opção Correta)"),
                      onChanged: (val) {
                        opcao1 = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? "Opção" : null,
                      decoration: InputDecoration(hintText: "Opcção2"),
                      onChanged: (val) {
                        opcao2 = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? "Opção" : null,
                      decoration: InputDecoration(hintText: "Opcção3"),
                      onChanged: (val) {
                        opcao3 = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? "Opção" : null,
                      decoration: InputDecoration(hintText: "Opcção4"),
                      onChanged: (val) {
                        opcao4 = val;
                      },
                    ),
                    Spacer(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: btnBlue(
                              context: context,
                              label: "Enviar",
                              btnWidth: MediaQuery.of(context).size.width / 2 - (36)),
                        ),
                        SizedBox(width: 24),
                        GestureDetector(
                          onTap: () {
                            atulaizarQuestaoDta();
                          },
                          child: btnBlue(
                              context: context,
                              label: "Add Questão",
                              btnWidth:
                                  MediaQuery.of(context).size.width / 2 - 36),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
