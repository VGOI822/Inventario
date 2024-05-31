import 'package:flutter/material.dart';
import 'package:inventar/inventario_view.dart';
import 'package:inventar/publicacao_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int navCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: IndexedStack(
        index: navCurrentIndex,
        children: const [
          PublicacaoView(),
          InventarioView()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              navCurrentIndex = index;
            });
          },
          currentIndex: navCurrentIndex,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Publicacao"),
            BottomNavigationBarItem(icon: Icon(Icons.inventory), label: "Inventario"),
            ]),
    );
  }
}
