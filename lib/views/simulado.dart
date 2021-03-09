import 'package:flutter/material.dart';

class Simulado extends StatefulWidget {

  final String simuladoId;
  Simulado(this.simuladoId);

  @override
  _SimuladoState createState() => _SimuladoState();
}

class _SimuladoState extends State<Simulado> {

  @override
  void initState() {
    print("${widget.simuladoId}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
