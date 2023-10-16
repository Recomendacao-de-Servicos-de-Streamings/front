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

  SelectMovies(this.movieData, this._counter);

  @override
  _SelectMovies createState() => _SelectMovies(movieData, _counter);
}

class _SelectMovies extends State<SelectMovies> {
  List<Movie> _selectedMovies = [];
  List<Movie> movieData;
  int _counter;
  _SelectMovies(this.movieData, this._counter);

  void _navigateToSelectedMoviesPage() {
    _counter = _counter + 1;
    List<String> movies = [];
    _selectedMovies.forEach((element) {
      movies.add(element.original_title);
    });
    final data = {'movies': movies};
    Future<http.Response> getRecommendation(List<String> movies) {
      return http.post(
        Uri.parse("http://127.0.0.1:8000/recommendation"),
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

    getRecommendation(movies).then((response) {
      if (response.statusCode == 200) {
        if (_counter < 2) {
          List<Movie> listMovies1 = [];
          var movie = jsonDecode(response.body);

          movie.forEach((element) {
            listMovies1.add(Movie.fromJson(element));
          });
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SelectMovies(listMovies1, _counter)),
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
                      'original_title': utf8.decode(movie['titulo'].codeUnits),
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
        backgroundColor: Color(0xFF222222), // Cor de fundo da AppBar
      ),
      backgroundColor: Color(0xFF222222), // Um tom mais claro de preto
      body: ListView.builder(
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
