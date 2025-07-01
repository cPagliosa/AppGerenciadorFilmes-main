import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatelessWidget {
  final ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Filmes Populares')),
      body: FutureBuilder(
        future: api.getPopularMovies(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(child : CircularProgressIndicator());
          if(snapshot.hasError)
            return Center(child: Text('Erro: ${snapshot.error}'));

          final movies = snapshot.data as List;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context,index) {
              final movie = movies[index];
              return ListTile(
                leading: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w92${movie['poster_path']}',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                title : Text(movie['title']),
                subtitle: Text('Nota: ${movie['vote_average']}'),
              );
            },
          );
        },
      ),
    );
  }
}