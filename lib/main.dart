import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/car_provider.dart';
import 'models/car_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarProvider()),
      ],
      child: MyApp(),
    ),
  );
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
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    Provider.of<CarProvider>(context, listen: false).fetchCars();
  }

  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CarProvider>(context);
    final filteredCars = carProvider.cars
        .where((car) =>
            car.make.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('Lista de Coches')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Buscar por marca',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: carProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : carProvider.errorMessage != null
                    ? Center(child: Text(carProvider.errorMessage!))
                    : ListView.builder(
                        itemCount: filteredCars.length,
                        itemBuilder: (context, index) {
                          final car = filteredCars[index];
                          return Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: ListTile(
                              leading:
                                  Icon(Icons.directions_car, color: Colors.blue),
                              title: Text('${car.make} ${car.model} (${car.year})'),
                              subtitle: Text('Tipo: ${car.type}'),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
