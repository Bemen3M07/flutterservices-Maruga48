import 'package:flutter/material.dart';
import 'services/car_service.dart';
import 'models/car_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Coches',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CarListScreen(),
    );
  }
}

class CarListScreen extends StatefulWidget {
  @override
  _CarListScreenState createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  late Future<List<CarsModel>> futureCars;

  @override
  void initState() {
    super.initState();
    futureCars = CarHttpService().getCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Coches')),
      body: FutureBuilder<List<CarsModel>>(
        future: futureCars,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay coches disponibles.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final car = snapshot.data![index];
                return ListTile(
                  leading: Icon(Icons.directions_car, color: Colors.blue),
                  title: Text('${car.make} ${car.model} (${car.year})'),
                  subtitle: Text('Tipo: ${car.type}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
