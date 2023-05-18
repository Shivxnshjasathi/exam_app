import 'package:flutter/material.dart';

void main() {
  runApp(ExamApp());
}

class ExamApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exam Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExamScreen(),
    );
  }
}

class ExamScreen extends StatefulWidget {
  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  int _score = 0;
  int _currentQuestionIndex = 0;

  List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is the capital of France?',
      'choices': ['Paris', 'London', 'Berlin', 'Rome'],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'Who painted the Mona Lisa?',
      'choices': [
        'Leonardo da Vinci',
        'Pablo Picasso',
        'Vincent van Gogh',
        'Michelangelo'
      ],
      'correctAnswerIndex': 0,
    },
  ];

  void _submitAnswer(int selectedAnswerIndex) {
    if (selectedAnswerIndex ==
        _questions[_currentQuestionIndex]['correctAnswerIndex']) {
      setState(() {
        _score++;
      });
    }
    setState(() {
      _currentQuestionIndex++;
    });
  }

  void _restartQuiz() {
    setState(() {
      _score = 0;
      _currentQuestionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam'),
      ),
      body: _currentQuestionIndex < _questions.length
          ? Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    _questions[_currentQuestionIndex]['question'],
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: (_questions[_currentQuestionIndex]['choices']
                              as List<dynamic>)
                          .map<Widget>((choice) => Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: ElevatedButton(
                                  onPressed: () => _submitAnswer(
                                      _questions[_currentQuestionIndex]
                                              ['choices']
                                          .indexOf(choice)),
                                  child: Text(choice),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Quiz Completed!',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Score: $_score out of ${_questions.length}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _restartQuiz,
                  child: Text('Restart Quiz'),
                ),
              ],
            ),
    );
  }
}
