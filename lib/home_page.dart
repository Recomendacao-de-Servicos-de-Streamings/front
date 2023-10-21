import 'package:flutter/material.dart';
import 'select_movies.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Movie {
  final String original_title;
  final String name;
  final String imageAsset;
  final int id;

  Movie(
      {required this.original_title,
      required this.name,
      required this.imageAsset,
      required this.id});

  factory Movie.fromJson(Map json) {
    return Movie(
        name: json['titulo'],
        imageAsset: json['poster_path'],
        id: json['id'],
        original_title: json['original_title']);
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie> _selectedMovies = [];
  bool isLoading = false;

  final List<Movie> _movies = [
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
        name: 'Alien o Oitavo Passageiro',
        original_title: 'Alien',
        imageAsset:
            'https://image.tmdb.org/t/p/original/t0VpOjqwobTpQK2SEZpXlqt5cqY.jpg',
        id: 348),
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
        name: "O Silêncio dos Inocentes",
        original_title: 'Silence of the Lambs',
        imageAsset:
            'https://image.tmdb.org/t/p/original/paGUSTwcFrAxpGV1hSQ2wsI28id.jpg',
        id: 274),
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
  ];

  void _navigateToSelectedMoviesPage() {
    setState(() {
      isLoading = true;
    });

    List<int> movies = [];
    List<int> moviesAlredyShow = [];
    for (var element in _selectedMovies) {
      movies.add(element.id);
      moviesAlredyShow.add(element.id);
    }

    final data = {'movies': movies};
    Future<http.Response> getRecommendation(
        List<int> movies, List<int> moviesAlredySeen) {
      return http.post(
        Uri.parse("https://parckcgwso3qcy4dl2aateij7a0nsgxl.lambda-url.us-east-1.on.aws/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'POST, OPTIONS, GET, PUT, DELETE',
          'Access-Control-Allow-Headers':
              'Origin, X-Requested-With, Content-Type, Accept'
        },
        body: jsonEncode(data),
      );
    }

    getRecommendation(movies, moviesAlredyShow).then((response) {
      setState(() {
        isLoading = false;
      });
      print(movies);
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print(moviesAlredyShow);
        int _counter = 0;
        List<Movie> listMovies1 = [];
        var movie = jsonDecode(response.body);
        movie.forEach((element) {
          // print("Element: " + element);
          if (!moviesAlredyShow.contains(element['id'])) {
            listMovies1.add(Movie.fromJson(element));
          }
        });

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SelectMovies(listMovies1, _counter, moviesAlredyShow)),
        );
      } else {
        print('Failed to load movies');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recomend.AI | Recomendador de Filmes'),
        backgroundColor: const Color(0xFF222222),
      ),
      backgroundColor: const Color(0xFF222222),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(), // Indicador de carregamento
                  )
                : ListView.builder(
                    itemCount: _movies.length,
                    itemBuilder: (context, index) {
                      Movie movie = _movies[index];
                      bool isSelected = _selectedMovies.contains(movie);

                      return ListTile(
                        contentPadding: const EdgeInsets.all(8.0),
                        leading: Image.network(
                          movie.imageAsset,
                          width: 80,
                          height: 80,
                        ),
                        title: Text(
                          movie.name,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 24),
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
                          side: const BorderSide(color: Colors.orange),
                          activeColor: Colors.orange,
                        ),
                      );
                    },
                  ),
          ),
          SizedBox(height: 80.0),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToSelectedMoviesPage,
        tooltip: 'Gerar um filme recomendado',
        backgroundColor: Colors.orange,
        child: const Icon(Icons.check),
      ),
    );
  }
}