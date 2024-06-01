import 'package:flutter/material.dart';
import 'PageQuiz.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Game', style: TextStyle(fontSize: 25, color: Colors.white)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 41, 40, 41),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Welcome to Game Quiz',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PageQuiz()),
                    );
                  },
                  child: const Text('Go!', style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 0, 0, 0))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
