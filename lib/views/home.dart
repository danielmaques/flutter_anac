import 'package:anac_simulado/services/database.dart';
import 'package:anac_simulado/views/simulado.dart';
import 'package:anac_simulado/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream simuladoStream;
  DatabaseService databaseService = new DatabaseService();

  Widget simuladoList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: StreamBuilder(
        stream: simuladoStream,
        builder: (context, snapshot) {
          return snapshot.data == null
              ? Container()
              : ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return SimuladoTile(
                      imgUrl:
                          snapshot.data.docs[index].data()["simuladoImgUrl"],
                      descsricao:
                          snapshot.data.docs[index].data()["simuladoDescricao"],
                      titulo:
                          snapshot.data.docs[index].data()["simuladoTitulo"],
                      simuladoId:
                          snapshot.data.docs[index].data()["simuladoId"],
                    );
                  });
        },
      ),
    );
  }

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
        brightness: Brightness.dark, //barra superior de notificação
      ),
      body: simuladoList(),
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

class SimuladoTile extends StatelessWidget {
  final String imgUrl;
  final String titulo;
  final String descsricao;
  final String simuladoId;

  SimuladoTile(
      {@required this.imgUrl,
      @required this.titulo,
      @required this.descsricao,
      @required this.simuladoId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Simulado(simuladoId)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Image.network(
                imgUrl,
                width: MediaQuery.of(context).size.width - 10,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: Colors.black26,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    titulo,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(descsricao,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
