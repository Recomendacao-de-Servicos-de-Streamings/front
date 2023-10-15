import 'dart:math';

import 'package:flutter/material.dart';
import 'selected_movies_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'home_page.dart';

class SelectMovies extends StatefulWidget {
  var movieData;

  SelectMovies(this.movieData);

  @override
  _SelectMovies createState() => _SelectMovies(movieData);
}

class _SelectMovies extends State<SelectMovies> {
  List<Movie> _selectedMovies = [];
  List<Movie> movieData;
  _SelectMovies(this.movieData);

  void _navigateToSelectedMoviesPage() {
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
        final number = Random().nextInt(jsonDecode(response.body).length);
        final movie = jsonDecode(response.body)[number];
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectedMoviesPage(movieData: {
                'genres': movie['genres'],
                'id': movie['id'],
                'original_title': movie['original_title'],
                'poster_url': movie['poster_path'],
                'overview': movie['overview']
              }),
            ));
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

          return ListTile(
            contentPadding: EdgeInsets.all(8.0),
            leading: Image.network(
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
