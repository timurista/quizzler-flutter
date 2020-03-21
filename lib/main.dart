import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class Question {
  bool answer;
  String question;

  Question({answer, question}) {
    this.answer = answer;
    this.question = question;
  }
}

List<Widget> initialScoreKeeper = [
  SizedBox(
    height: 40,
    width: 1,
  )
];

class _QuizPageState extends State<QuizPage> {
  Random r = Random();
  List<Widget> scoreKeeper = initialScoreKeeper;

  List<Question> questions = [
    new Question(
      question: 'You can lead a cow down stairs but not up stairs.',
      answer: false,
    ),
    new Question(
      question:
          "The letter 'e' is the most common letter in the English language.",
      answer: true,
    ),
    new Question(
      question: "Approximately one quarter of human bones are in the feet.",
      answer: true,
    ),
    new Question(
      question:
          "The primary colors of pigment (sometimes called the subtractive primary colors) are red, yellow, and blue.",
      answer: false,
    ),
    new Question(
      question: "Zero is both an even number and an odd number.",
      answer: false,
    ),
    new Question(
      question:
          "There exist three directions such that, by moving in those three directions, it is possible to go anywhere on a two-dimensional surface.",
      answer: true,
    ),
    new Question(
      question: 'A slug\'s blood is green.',
      answer: true,
    )
  ];
  int currentQuestionIndex = 0;

  Widget getNextValue(isTrue, question) {
    return isTrue
        ? Icon(Icons.check, color: Colors.green)
        : Icon(Icons.close, color: Colors.red);
  }

  void handleCheck(value, question) {
    if (scoreKeeper.length >= questions.length) {
      return;
    }
    Widget nextValue = getNextValue(value == question.answer, question);
    setState(() {
      scoreKeeper.add(nextValue);
      currentQuestionIndex++;
    });
  }

  void handleReset() {
    setState(() {
      currentQuestionIndex = 0;
      scoreKeeper.clear();
      scoreKeeper = initialScoreKeeper;
    });
  }

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = questions[currentQuestionIndex];
    bool _gameOver = (currentQuestionIndex == questions.length - 1);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                currentQuestion.question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              disabledColor: Colors.grey,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed:
                  _gameOver ? null : () => handleCheck(true, currentQuestion),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              disabledColor: Colors.grey,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed:
                  _gameOver ? null : () => handleCheck(false, currentQuestion),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
        _gameOver
            ? Expanded(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: FlatButton(
                    color: Colors.blueAccent,
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: handleReset,
                  ),
                ),
              )
            : SizedBox(
                height: 0,
              ),
      ],
    );
  }
}
