import 'package:flutter/material.dart';
import 'selected_movies_page.dart';

class Movie {
  final String original_title;
  final String name;
  final String imageAsset;
  final int id;

  Movie(
      {required this.name,
      required this.imageAsset,
      required this.id,
      required this.original_title});
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie> _selectedMovies = [];

  List<Movie> _movies = [
    Movie(
        name: 'O Senhor dos Anéis: A Sociedade do Anel',
        original_title: 'The Lord of the Rings: The Fellowship of the Ring',
        imageAsset:
            'https://image.tmdb.org/t/p/original/omoMXT3Z7XrQwRZ2OGJGNWbdeEl.jpg',
        id: 120),
    Movie(
        name: "Piratas do Caribe: A Maldição do Pérola Negra",
        original_title:
            'Pirates of the Caribbean: The Curse of the Black Pearl',
        imageAsset:
            'https://image.tmdb.org/t/p/original/9Xcg7Ar4ketv4rl8yeK32yp9zQA.jpg',
        id: 22),
    Movie(
        name: 'O Chamado 2',
        original_title: 'The Ring Two',
        imageAsset:
            'https://image.tmdb.org/t/p/original/tRAMi4baz87h6k4o9EgAmi3dOw9.jpg',
        id: 10320),
    Movie(
        name: "Vingadores: The Avengers",
        original_title: 'The Avengers',
        imageAsset:
            'https://image.tmdb.org/t/p/original/vGIIl89vglo66yUfbuTxzNAs4y5.jpg',
        id: 99861),
    Movie(
        name: "As Branquelas",
        original_title: 'White Chicks',
        imageAsset:
            'https://image.tmdb.org/t/p/original/aJZOcorpgloDLkPP6ED0t9sXjNu.jpg',
        id: 12153),
    Movie(
        name: "Duro de Matar",
        original_title: 'Die Hard',
        imageAsset:
            'https://image.tmdb.org/t/p/original/rauTKnFle1sp4aXjtYgx4tCWNiK.jpg',
        id: 562),
    Movie(
        name: 'Avatar',
        original_title: "Avatar",
        imageAsset:
            'https://image.tmdb.org/t/p/original/iNMP8uzV2Ing6ZCw0IICgEFVNfC.jpg',
        id: 19995),
    Movie(
        name: "Um espião e Meio",
        original_title: 'Central Intelligence',
        imageAsset:
            'https://image.tmdb.org/t/p/original/j24zrqp8RdDKsuvNDqrAkbBjCxC.jpg',
        id: 302699),
    Movie(
        name: "Donnie Darko",
        original_title: 'Donnie Darko',
        imageAsset:
            'https://image.tmdb.org/t/p/original/j73zf3TjWR9j8pHLndaHWh0YWvN.jpg',
        id: 141),
    Movie(
        name: "Star Wars: Episódio III - A Vingança dos Sith",
        original_title: 'Star Wars: Episode III - Revenge of the Sith',
        imageAsset:
            'https://image.tmdb.org/t/p/original/nuF5yWtTJEEAd4Qa6cVkYz1XCST.jpg',
        id: 1895),
    Movie(
        name: "Harry Potter e a Pedra Filosofal",
        original_title: "Harry Potter and the Philosopher's Stone",
        imageAsset:
            'https://image.tmdb.org/t/p/original/l1FfRmKRNXRSqXT5GlMo16MX2LX.jpg',
        id: 671),
    Movie(
        name: 'Clube da Luta',
        original_title: "Fight Club",
        imageAsset:
            "https://image.tmdb.org/t/p/original/r3pPehX4ik8NLYPpbDRAh0YRtMb.jpg",
        id: 550),
    // Adicione mais filmes aqui
  ];

  void _navigateToSelectedMoviesPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectedMoviesPage(movieData: {
          'genres': ['Crime', 'Drama'],
          'id': 240,
          'original_title': 'The Social Network',
          'poster_url':
              'https://image.tmdb.org/t/p/original/o8Y4YbPiV7TCNCEPJKv8AKTe2Gl.jpg',
          'overview':
              'Uma história surpreendente sobre uma nova raça de rebeldes culturais: um gênio que deflagrou uma revolução e mudou a cara da interação humana de toda uma geração, uma mudança que talvez perdure para sempre. Filmado com brutalidade emocional e humor inesperado, este filme soberbamente elaborado faz uma crônica sobre a criação do Facebook e sobre as batalhas relativas à sua propriedade após o imenso sucesso do site.'
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recomend.AI | Recomendador de Filmes'),
        backgroundColor: Color(0xFF222222), // Cor de fundo da AppBar
      ),
      backgroundColor: Color(0xFF222222), // Um tom mais claro de preto
      body: ListView.builder(
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          Movie movie = _movies[index];
          bool isSelected = _selectedMovies.contains(movie);

          return ListTile(
            contentPadding: EdgeInsets.all(8.0),
            leading: Image.asset(
              movie.imageAsset,
              width: 80,
              height: 80,
            ),
            title: Text(
              movie.name,
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            trailing: Checkbox(
              value: isSelected,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    _selectedMovies.add(movie);
                  } else {
                    _selectedMovies.remove(movie);
                  }
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              side: BorderSide(color: Colors.orange),
              activeColor: Colors.orange,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToSelectedMoviesPage,
        tooltip: 'Gerar um filme recomendado',
        child: Icon(Icons.check),
        backgroundColor: Colors.orange,
      ),
    );
  }
}