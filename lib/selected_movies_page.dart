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
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Color(0xFF222222),
              border: Border.all(
                color: Colors.orange,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  posterUrl,
                  width: 200,
                  height: 300,
                ),
                SizedBox(height: 16),
                Text(
                  originalTitle,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF222222),
                    border: Border.all(
                      color: Colors.orange,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
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
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 80),  // Add an empty space of 16 logical pixels below the last Container
              ],
            ),
          ),
        ),
      ),
    );
  }
}