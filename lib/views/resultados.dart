import 'package:anac_simulado/widgets/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Resultados extends StatefulWidget {
  final int correta, incorreta, total, faltou;

  Resultados(
      {@required this.correta,
      @required this.incorreta,
      @required this.total,
      @required this.faltou});

  @override
  _ResultadosState createState() => _ResultadosState();
}

class _ResultadosState extends State<Resultados> {
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                "${widget.correta}/${widget.correta + widget.incorreta}",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 8),
              AutoSizeText(
                "Você acertou ${widget.correta} questões e errou ${widget.incorreta}",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: 25),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: btnBlue(
                      context: context,
                      label: "Finalizar Simulado",
                      btnWidth: MediaQuery.of(context).size.width / 2)),
            ],
          ),
        ),
      ),
    );
  }
}
