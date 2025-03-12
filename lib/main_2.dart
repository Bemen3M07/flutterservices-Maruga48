import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/joke_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JokeProvider()),
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
      title: 'Acudits App',
      home: JokeScreen(),
    );
  }
}

class JokeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final jokeProvider = Provider.of<JokeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Acudit Aleatori')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              jokeProvider.isLoading
                  ? CircularProgressIndicator()
                  : jokeProvider.joke != null
                      ? Column(
                          children: [
                            Text(jokeProvider.joke!.setup,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            Text(jokeProvider.joke!.punchline,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18)),
                          ],
                        )
                      : Text("Presiona el botón para obtener un chiste."),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: jokeProvider.fetchJoke,
                child: Text("Mostrar otro acudit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
