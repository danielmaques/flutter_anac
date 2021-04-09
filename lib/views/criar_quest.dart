import 'package:anac_simulado/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import '../services/database.dart';
import 'add_questao.dart';

class CriarQuestao extends StatefulWidget {
  @override
  _CriarQuestaoState createState() => _CriarQuestaoState();
}

class _CriarQuestaoState extends State<CriarQuestao> {
  final _formKey = GlobalKey<FormState>();
  String simuladoImgUrl, simuladoTitulo, simuladoDescricao, simuladoId;
  DatabaseService databaseService = new DatabaseService();

  bool _isLoading = false;

  creteSimuladoOnLine() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      simuladoId = randomAlphaNumeric(20);
      Map<String, String> simuladoMap = {
        "simuladoId": simuladoId,
        "simuladoImgUrl": simuladoImgUrl,
        "simuladoTitulo": simuladoTitulo,
        "simuladoDescricao": simuladoDescricao,
      };

      await databaseService
          .addSimuladoData(simuladoMap, simuladoId)
          .then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AddQuestao(
            simuladoId
          )));
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
        iconTheme: IconThemeData(color: Colors.black45),
        brightness: Brightness.dark, //barra superior de notificação
      ),
      body: _isLoading
          ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
          : Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextFormField(
                validator: (val) =>
                val.isEmpty ? "Coloque a Url da imagem" : null,
                decoration: InputDecoration(hintText: "Imagem Url"),
                onChanged: (val) {
                  simuladoImgUrl = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) =>
                val.isEmpty ? "Coloque um título" : null,
                decoration: InputDecoration(hintText: "Título"),
                onChanged: (val) {
                  simuladoTitulo = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) =>
                val.isEmpty ? "Coloque uma descrição" : null,
                decoration: InputDecoration(hintText: "Descrição"),
                onChanged: (val) {
                  simuladoDescricao = val;
                },
              ),
              Spacer(),
              GestureDetector(
                  onTap: () {
                    creteSimuladoOnLine();
                  },
                  child: btnBlue(
                      context: context, label: "Criar Simulado")),
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