import 'package:anac_simulado/ajuda/functions.dart';
import 'package:anac_simulado/services/auth.dart';
import 'package:anac_simulado/views/home.dart';
import 'package:anac_simulado/views/signup.dart';
import 'package:anac_simulado/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Sing extends StatefulWidget {
  @override
  _SingState createState() => _SingState();
}

class _SingState extends State<Sing> {
  final _formKey = GlobalKey<FormState>();
  String email, senha;

  AuthService authService = new AuthService();
  bool _isLoading = false;

  signIn() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService.signInEmailAndPass(email, senha).then((val) {
        if (val != null) {
          setState(() {
            _isLoading = false;
          });
          HelperFunctions.saveUserLoggedInDatails(isLoggedin: true);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        appBar: AppBar(
          centerTitle: true,
          title: appBar(context),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          brightness: Brightness.dark,
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
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Spacer(),
                  TextFormField(
                    validator: (val) {
                      return val.isEmpty
                          ? "Digite seu email valido!"
                          : null;
                    },
                    decoration: InputDecoration(hintText: "Email"),
                    onChanged: (val) {
                      email = val;
                    },
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (val) {
                      return val.isEmpty ? "Digite sua senha!" : null;
                    },
                    decoration: InputDecoration(hintText: "Senha"),
                    onChanged: (val) {
                      email = val;
                    },
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  ButtonTheme(
                    minWidth: 400,
                    height: 55,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      onPressed: () {
                        signIn();
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      child: Text(
                        "Entrar",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ), //Text
                      color: Colors.blue,
                    ), //RaisedButton
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Não tem conta?",
                        style: TextStyle(fontSize: 15.5),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Text(
                            " Criar conta",
                            style: TextStyle(
                                fontSize: 15.5,
                                decoration: TextDecoration.underline),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              )),
        ));
  }
}