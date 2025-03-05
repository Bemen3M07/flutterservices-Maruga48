import 'dart:convert';

class Car {
  final int id;
  final int year;
  final String make;
  final String model;
  final String type;

  Car({
    required this.id,
    required this.year,
    required this.make,
    required this.model,
    required this.type,
  });

  // Método para crear un objeto Car a partir de un mapa (JSON)
  factory Car.fromMap(Map<String, dynamic> json) {
    return Car(
      id: json["id"],
      year: json["year"],
      make: json["make"],
      model: json["model"],
      type: json["type"],
    );
  }

  // Método para convertir un objeto Car en un mapa (JSON)
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "year": year,
      "make": make,
      "model": model,
      "type": type,
    };
  }
}

// Función para convertir un JSON string en una lista de objetos Car
List<Car> carsFromJson(String jsonString) {
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList.map((json) => Car.fromMap(json)).toList();
}

// Función para convertir una lista de objetos Car en un JSON string
String carsToJson(List<Car> cars) {
  final List<Map<String, dynamic>> carMaps = cars.map((car) => car.toMap()).toList();
  return json.encode(carMaps);
}