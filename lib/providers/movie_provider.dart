import 'package:flutter/material.dart';
import '../services/api_service.dart';

class MovieProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<dynamic> movies = [];
  int _currentPage = 1;
  bool _isLoading = false;

  Future<void> fetchMovies() async {
    if (_isLoading) return;

    _isLoading = true;
    final newMovies = await _apiService.getPopularMovies(page: _currentPage);
    movies.addAll(newMovies);
    _currentPage++;
    _isLoading = false;
    notifyListeners();
  }

  void reset(){
    movies.clear();
    _currentPage = 1;
    notifyListeners();
    fetchMovies();
  }
}