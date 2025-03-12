import 'package:http/http.dart' as http;
import '../models/joke_model.dart';

class JokeService {
  final String _apiUrl = "https://api.sampleapis.com/jokes/goodJokes";

  Future<Joke> fetchJoke() async {
    final response = await http.get(Uri.parse(_apiUrl));

    if (response.statusCode == 200) {
      return getRandomJoke(response.body);
    } else {
      throw Exception("Error al obtener el chiste");
    }
  }
}
