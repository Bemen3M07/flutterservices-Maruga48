import 'package:flutter/material.dart';
import '../services/joke_service.dart';
import '../models/joke_model.dart';

class JokeProvider with ChangeNotifier {
  final JokeService _jokeService = JokeService();
  Joke? _joke;
  bool _isLoading = false;

  Joke? get joke => _joke;
  bool get isLoading => _isLoading;

  Future<void> fetchJoke() async {
    _isLoading = true;
    notifyListeners();

    try {
      _joke = await _jokeService.fetchJoke();
    } catch (e) {
      _joke = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}
