// ignore_for_file: deprecated_member_use, unused_field

import 'package:anac_simulado/helper/functions.dart';
import 'package:anac_simulado/modules/home/home.dart';
import 'package:anac_simulado/services/auth.dart';
import 'package:anac_simulado/views/signin.dart';
import 'package:anac_simulado/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  late String nome, email, senha;

  AuthService authService = new AuthService();
  bool _isLoading = false;

  signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService.signUpWithEmailAndPassword(email, senha).then((value) {
        if (value != null) {
          setState(() {
            _isLoading = false;
          });
          HelperFunctions.saveUserLoggedInDatails(isLoggedin: true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: appBar(context),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   brightness: Brightness.dark,
      // ),
      body: Form(
        key: _formKey,
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Spacer(),
                appBar(context),
                Spacer(),
                TextFormField(
                  validator: (val) {
                    return val!.isEmpty ? "Digite seu nome!" : null;
                  },
                  decoration: InputDecoration(hintText: "Nome"),
                  onChanged: (val) {
                    nome = val;
                  },
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  validator: (val) {
                    return val!.isEmpty ? "Digite um email valido!" : null;
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
                    return val!.isEmpty ? "Senha" : null;
                  },
                  decoration:
                      InputDecoration(hintText: "Senha (Minimo 8 Caracteres)"),
                  onChanged: (val) {
                    senha = val;
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                ButtonTheme(
                  minWidth: 400,
                  height: 55,
                  // ignore:
                  child: RaisedButton(
                    onPressed: () {
                      signUp();
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: Text(
                      "Criar Conta",
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
                      "Já tenho conta!",
                      style: TextStyle(fontSize: 15.5),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Sing()));
                        },
                        child: Text(
                          " Entrar",
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
      ),
    );
  }
}

class SignIn {}
