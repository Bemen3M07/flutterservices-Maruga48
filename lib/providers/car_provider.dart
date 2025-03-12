import 'package:flutter/material.dart';
import '../services/car_service.dart';
import '../models/car_model.dart';

class CarProvider with ChangeNotifier {
  final CarHttpService _carService = CarHttpService();
  List<CarsModel> _cars = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<CarsModel> get cars => _cars;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCars() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _cars = await _carService.getCars();
    } catch (e) {
      _errorMessage = "Error al obtener los coches: $e";
    }

    _isLoading = false;
    notifyListeners();
  }
}
