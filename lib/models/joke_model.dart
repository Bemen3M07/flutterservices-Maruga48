import 'dart:convert';

class Joke {
  final String setup;
  final String punchline;

  Joke({required this.setup, required this.punchline});

  // Método para convertir JSON a objeto
  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      setup: json["setup"],
      punchline: json["punchline"],
    );
  }

  // Método para convertir objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "setup": setup,
      "punchline": punchline,
    };
  }
}

// Función para obtener un chiste aleatorio de la lista JSON
Joke getRandomJoke(String jsonString) {
  final List<dynamic> jokes = json.decode(jsonString);
  jokes.shuffle(); // Mezclar los chistes para obtener uno aleatorio
  return Joke.fromJson(jokes.first);
}
