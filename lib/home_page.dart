import 'package:flutter/material.dart';
import 'selected_movies_page.dart';

class Movie {
  final String name;
  final String imageAsset;

  Movie({required this.name, required this.imageAsset});
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie> _selectedMovies = [];

  List<Movie> _movies = [
    Movie(name: 'Gente Grande', imageAsset: 'assets/images/gente_grande2.jpg'),
    Movie(name: 'Piratas do Caribe', imageAsset: 'assets/images/piratas-do-caribe.jpg'),
    Movie(name: 'O Chamado', imageAsset: 'assets/images/chamado.jpg'),
    Movie(name: 'Vingadores', imageAsset: 'assets/images/vingadores2.jpeg'),
    Movie(name: 'As Branquelas', imageAsset: 'assets/images/branquelas2.jpg'),
    Movie(name: 'Tropa de Elite', imageAsset: 'assets/images/tropa2.jpeg'),
    Movie(name: 'Duro de Matar 4.0', imageAsset: 'assets/images/duromatar.jpg'),
    Movie(name: 'Avatar', imageAsset: 'assets/images/avatar.jpeg'),
    Movie(name: 'Um espião e meio', imageAsset: 'assets/images/espiao.jpg'),
    Movie(name: 'Jumanji - Próxima fase', imageAsset: 'assets/images/jumanji.jpg'),
    Movie(name: 'Star Wars - Vingança dos Sith', imageAsset: 'assets/images/starwars.jpg'),
    Movie(name: 'Harry Potter e a Pedra Filosofal', imageAsset: 'assets/images/harry.jpeg'),
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
        'poster_url':'https://image.tmdb.org/t/p/original/o8Y4YbPiV7TCNCEPJKv8AKTe2Gl.jpg'
            ,'overview': 'Uma história surpreendente sobre uma nova raça de rebeldes culturais: um gênio que deflagrou uma revolução e mudou a cara da interação humana de toda uma geração, uma mudança que talvez perdure para sempre. Filmado com brutalidade emocional e humor inesperado, este filme soberbamente elaborado faz uma crônica sobre a criação do Facebook e sobre as batalhas relativas à sua propriedade após o imenso sucesso do site.'
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
              style: TextStyle(color: Colors.white,
              fontSize: 24
              ),
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