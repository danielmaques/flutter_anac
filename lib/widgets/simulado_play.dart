import 'package:flutter/material.dart';

class SimuladoWidgets extends StatefulWidget {
  final String opcoes, descricao, opcaoCorreta, opcaoSelecionada;

  SimuladoWidgets(
      {@required this.opcoes,
      @required this.descricao,
      @required this.opcaoCorreta,
      @required this.opcaoSelecionada});

  @override
  _SimuladoWidgetsState createState() => _SimuladoWidgetsState();
}

class _SimuladoWidgetsState extends State<SimuladoWidgets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: widget.descricao == widget.opcaoSelecionada
                        ? widget.opcaoSelecionada == widget.opcaoCorreta
                            ? Colors.green.withOpacity(0.7)
                            : Colors.red.withOpacity(0.7)
                        : Colors.grey)),
            child: Text(
              "${widget.opcoes}",
              style: TextStyle(
                  color: widget.opcaoSelecionada == widget.descricao
                      ? widget.opcaoCorreta == widget.opcaoSelecionada
                          ? Colors.green.withOpacity(0.7)
                          : Colors.red
                      : Colors.black54),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            widget.descricao,
            style: TextStyle(fontSize: 17, color: Colors.black54),
          )
        ],
      ),
    );
  }
}
