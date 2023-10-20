import 'package:flutter/material.dart';

class SelectedMoviesPage extends StatelessWidget {
  final Map<String, dynamic> movieData;

  SelectedMoviesPage({required this.movieData});

  @override
  Widget build(BuildContext context) {
    String originalTitle = movieData['original_title'];
    String posterUrl = movieData['poster_url'];
    String overview = movieData['overview'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Filme Recomendado'),
        backgroundColor: Color(0xFF222222),
      ),
      backgroundColor: Color(0xFF222222),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8, // Largura do quadrado
          decoration: BoxDecoration(
            color: Color(0xFF222222), // Cor de fundo preta
            border: Border.all(
              color: Colors.orange, // Cor do contorno laranja
              width: 2.0, // Espessura do contorno
            ),
            borderRadius: BorderRadius.circular(16.0), // Borda arredondada
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Alinhar ao centro horizontalmente
            crossAxisAlignment:
                CrossAxisAlignment.center, // Alinhar ao centro verticalmente
            children: [
              // Exibe a imagem do filme à esquerda
              Image.network(
                posterUrl,
                width: 200,
                height: 300,
              ),
              SizedBox(height: 16), // Espaço entre a imagem e o texto

              // Exibe o nome do filme à direita
              Text(
                originalTitle,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 16), // Espaço entre o título e a descrição

              // Container para a descrição do filme
              Container(
  decoration: BoxDecoration(
    color: Color(0xFF222222), // Cor de fundo preto
    border: Border.all(
      color: Colors.orange, // Cor do contorno laranja
      width: 2.0, // Espessura do contorno
    ),
    borderRadius: BorderRadius.circular(16.0), // Borda arredondada
  ),
  padding: EdgeInsets.all(16.0),
  child: Column(
    children: [
      Text(
        overview,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        maxLines: 16, // Número máximo de linhas
        overflow: TextOverflow.ellipsis, // Adicionar reticências no final
      ),
    ],
  ),
),
            ],
          ),
        ),
      ),
    );
  }
}
