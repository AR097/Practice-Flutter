//Quiz app
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PageQuiz(),
    );
  }
}

class PageQuiz extends StatefulWidget {
  @override
  _PageQuizState createState() => _PageQuizState();
}

class _PageQuizState extends State<PageQuiz> {
  final PageController _pageController = PageController(); //Permite que as perguntas apareçam cada uma de uma vez
  int _currentPageIndex = 0; // declara que a pagina começa no valor 0 "PageView"

  List<String> _questions = [  // List<string> Lista de Strings 
    'What is the capital of Japan?',//pergunta 1
    'What is the capital of Brasil?',//pergunta 2
    'What is the capital of Mexico?',//pergunta 3
   
  ];

  List<List<String>> _options = [ // List<string> Lista de Strings aqui cada uma se refere em ordem
    ['Tokyo', 'Kyoto', 'Osaka', 'Hiroshima'], // Opçoes de resposta para a pergunta 1
    ['Amapá', 'Brasilia', 'Rio de Janeiro', 'São Paulo'], // Opçoes de resposta para a pergunta 2
    ['Monterrey', 'Guadalajara', 'Mexico City', 'Cancun'] // Opçoes de resposta para a pergunta 3
  ];

  List<String> _correctAnswers = [// List<string> Lista de Strings aqui cada uma se refere em ordem
      'Tokyo',  //respostas corretas, se referem em ordem tambem
      'Brasilia',   
      'Mexico City'
  ]; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      backgroundColor: const Color.fromARGB(255, 41, 40, 41),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _questions.length + 1, // Adiciona uma pagina no fim das perguntas
        itemBuilder: (BuildContext context, int index) {
          if (index < _questions.length) {
            return _buildQuestionPage(index);
          } else {
            return _buildCompletionPage();
          }
        },
        onPageChanged: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildQuestionPage(int index) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(//configuraçoes das perguntas
            _questions[index],
            style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 165, 164, 164)),
          ),
          SizedBox(height: 30),

          Column(//Configuraçoes das opçoes
            children: _options[index].map((option) {
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _checkAnswer(option, index);
                    },
                    child: Text(option),
                  ),
                  SizedBox(height: 20), // Espaço entre as opçoes
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionPage() {//final do quiz
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Congratulations!',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          SizedBox(height: 20),
          Text(
            'You have completed the quiz.',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Return to Home'),
          ),
        ],
      ),
    );
  }

  void _checkAnswer(String selectedAnswer, int pageIndex) {
    String correctAnswer = _correctAnswers[pageIndex];
    String message;

    if (selectedAnswer == correctAnswer) {
      message = 'Correct answer!';
      if (_currentPageIndex < _questions.length) {
        _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
      }
    } else {
      message = 'Incorrect answer.';
    }

    _showMessage(message, selectedAnswer == correctAnswer);
  }

  void _showMessage(String message, bool isCorrect) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Result'),
          content: Text(message),
          actions: [
            if (isCorrect && _currentPageIndex >= _questions.length) // Check if it is the last question
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
                },
                child: Text('Finish'),
              ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
