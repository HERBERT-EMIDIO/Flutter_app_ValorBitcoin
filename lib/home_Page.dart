import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

//====================================== service =======
class _HomePageState extends State<HomePage> {
  dynamic _preco = '0';
  void _recuperarPreco() async {
    dynamic url = "https://blockchain.info/ticker";

    http.Response response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);
    setState(() {
      _preco = retorno["BRL"]["buy"].toString();
    });

    print("Resultado : ${retorno["BRL"]['buy'].toString()}");
  }

//===========================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(35),
        child: Center(
          //================================
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/bitcoin.png'),
              //=====================
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  'R\$ ${_preco}',
                  style: TextStyle(fontSize: 35),
                ),
              ),
              //====================== botão
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                  backgroundColor: Colors.orange[700],
                ),
                onPressed: _recuperarPreco,
                child: Text(
                  'Atualizar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
