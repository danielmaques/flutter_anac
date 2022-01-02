import 'package:anac_simulado/services/database.dart';
import 'package:anac_simulado/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'widgets/category.widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream<QuerySnapshot<Object?>>? simuladoStream;
  DatabaseService databaseService = new DatabaseService();

  @override
  void initState() {
    databaseService.getSimuladoData().then((val) {
      setState(() {
        simuladoStream = val;
      });
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
        //brightness: Brightness.dark, //barra superior de notificação
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: StreamBuilder<QuerySnapshot>(
          stream: simuladoStream,
          builder: (context, AsyncSnapshot snapshot) {
            return snapshot.data == null
                ? Container()
                : ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return CategoryCustom(
                        imgUrl:
                            snapshot.data.docs[index].data()["simuladoImgUrl"],
                        descsricao: snapshot.data.docs[index]
                            .data()["simuladoDescricao"],
                        titulo:
                            snapshot.data.docs[index].data()["simuladoTitulo"],
                        simuladoId:
                            snapshot.data.docs[index].data()["simuladoId"],
                      );
                    });
          },
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MaisSimulados()));
        },
      ),*/
    );
  }
}
