import 'package:anac_simulado/views/simulado.dart';
import 'package:flutter/material.dart';

class CategoryCustom extends StatelessWidget {
  final String imgUrl;
  final String titulo;
  final String descsricao;
  final String simuladoId;

  CategoryCustom({
    required this.imgUrl,
    required this.titulo,
    required this.descsricao,
    required this.simuladoId,
  });

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
                  /*Text(
                    descsricao,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),*/
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
