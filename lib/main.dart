import 'services/car_service.dart'; // Importamos el servicio CarService
import 'models/car_model.dart';
void main() async {
  CarService carService = CarService();

  try {
    // Obtener la lista de coches
    List<Car> cars = await carService.getCars();
    print("Número de coches obtenidos: ${cars.length}");

    // Imprimir los detalles de cada coche
    for (var car in cars) {
      print("ID: ${car.id}, Año: ${car.year}, Marca: ${car.make}, Modelo: ${car.model}, Tipo: ${car.type}");
    }
  } catch (e) {
    print("Error: $e");
  }
}