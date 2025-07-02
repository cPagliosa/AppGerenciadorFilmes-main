import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'movie_datail_page.dart';

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
          return GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
            ),
            itemCount: movies.length,
            itemBuilder: (context,index) {
              final movie = movies[index];
              return InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => MovieDetailPage(movie: movie),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                              imageUrl: 'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              placeholder: (context, url) => Container(
                                color: Colors.green[900],
                                child: Center(child: CircularProgressIndicator()),
                              ),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      movie['title'] ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}