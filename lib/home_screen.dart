import 'package:flutter/material.dart';
import 'package:fluttermlkit/controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                "Reconocimiento de Texto con ML Kit",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  homeController.scanDni();
                },
                child: Text("Iniciar Escaneo"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
