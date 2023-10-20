import 'dart:math';

import 'package:flutter/material.dart';
import 'selected_movies_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert' show utf8;
import 'home_page.dart';

// ignore: must_be_immutable
class SelectMovies extends StatefulWidget {
  var movieData;
  int _counter;
  List<int> moviesAlredyShow;
  SelectMovies(this.movieData, this._counter, this.moviesAlredyShow);

  @override
  _SelectMovies createState() =>
      _SelectMovies(movieData, _counter, moviesAlredyShow);
}

class _SelectMovies extends State<SelectMovies> {
  List<Movie> _selectedMovies = [];
  List<Movie> movieData;
  int _counter;
  List<int> moviesAlredyShow;
  bool isLoading = false;

  _SelectMovies(this.movieData, this._counter, this.moviesAlredyShow);

  void _navigateToSelectedMoviesPage() {
    setState(() {
      isLoading = true;
    });

    _counter = _counter + 1;
    List<int> movies = [];
    _selectedMovies.forEach((element) {
      movies.add(element.id);
      moviesAlredyShow.add(element.id);
    });
    final data = {'movies': movies};
    Future<http.Response> getRecommendation(
        List<int> movies, List<int> moviesAlredyShow) {
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

      if (response.statusCode == 200) {
        if (_counter < 2) {
          List<Movie> listMovies1 = [];
          var movie = jsonDecode(response.body);

          movie.forEach((element) {
            if (!moviesAlredyShow.contains(element['original_title'])) {
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
          final number = Random().nextInt(jsonDecode(response.body).length);
          final movie = jsonDecode(response.body)[number];
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SelectedMoviesPage(movieData: {
                      'genres': movie['genres'],
                      'id': movie['id'],
                      'original_title': utf8.decode(movie['original_title'].codeUnits),
                      'poster_url': movie['poster_path'],
                      'overview': utf8.decode(movie['overview'].codeUnits)
                    })),
          );
        }
      } else {
        print('Failed to load movies');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recomend.AI | Recomendador de Filmes'),
        backgroundColor: Color(0xFF222222),
      ),
      backgroundColor: Color(0xFF222222),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(), // Indicador de carregamento
                  )
                : ListView.builder(
                    itemCount: movieData.length,
                    itemBuilder: (context, index) {
                      Movie movie = movieData[index];
                      bool isSelected = _selectedMovies.contains(movie);
                      String name = utf8.decode(movie.name.codeUnits);
                      return ListTile(
                        contentPadding: EdgeInsets.all(8.0),
                        leading: Image.network(
                          movie.imageAsset,
                          width: 80,
                          height: 80,
                        ),
                        title: Text(
                          name,
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