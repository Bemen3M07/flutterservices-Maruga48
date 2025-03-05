import 'package:http/http.dart' as http;
import '../models/car_model.dart'; // Importamos el modelo Car

class CarService {
  final String _serverUrl = "https://car-data.p.rapidapi.com";
  final String _apiKey = "9d719da7bemsh56ce2dca37c54e6p1e60f0jsnd23970653948"; // Reemplaza con tu clave de API
  final String _headerHost = "car-data.p.rapidapi.com";

  // Método para obtener la lista de coches
  Future<List<Car>> getCars() async {
    final uri = Uri.parse("$_serverUrl/cars");
    final response = await http.get(uri, headers: {
      "x-rapidapi-key": _apiKey,
      "x-rapidapi-host": _headerHost,
    });

    if (response.statusCode == 200) {
      // Si la solicitud es exitosa, convertimos el JSON en una lista de objetos Car
      return carsFromJson(response.body);
    } else {
      // Si hay un error, lanzamos una excepción
      throw Exception("Error al obtener los coches: ${response.statusCode}");
    }
  }
}