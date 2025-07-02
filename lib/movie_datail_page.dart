import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieDetailPage extends StatelessWidget{
  final Map<String, dynamic> movie;

  const MovieDetailPage({required this.movie});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(movie['title'])),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 300,
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url , error) => Icon(Icons.error),
                ),
        Padding(
            padding: const EdgeInsets.all(16.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie['title'], style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: 10),
                Text(
                  'Lançamento: ${movie['release_date'] ?? 'Desconhecido'}',
                  style: TextStyle(color: Colors.lightBlueAccent),
                ),
                SizedBox(height: 10),
                Text(
                  'Nota: ${movie['vote_average'].toString()}',
                  style: TextStyle(color: Colors.amberAccent),
                ),
                SizedBox(height: 20),
                Text(
                  movie['overview'] ?? 'Sem descrição disponivel.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}