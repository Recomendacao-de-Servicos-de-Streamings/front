import 'package:flutter/material.dart';
import 'home_page.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Aguarde 5 segundos antes de navegar para a tela principal
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF222222), // Cor de fundo branca
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo-app3.jpg', // Substitua pelo caminho da sua imagem
              width: 200, // Ajuste a largura conforme necessário
              height: 200, // Ajuste a altura conforme necessário
            ),
            SizedBox(height: 20),
            Text(
              'O seu Recomendador de Filmes',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(), // Mini gif de carregando
          ],
        ),
      ),
    );
  }
}