import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _apiKey = '5bec04789a366fa0865d913ae3b6dda5';
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  Future<List<dynamic>> getPopularMovies() async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey&language=pt-BR'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Erro ao carregar filmes');
    }
  }

  Future<List<dynamic>> getMovies() async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey&language=pt-BR'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Erro ao carregar filmes');
    }
  }
}
