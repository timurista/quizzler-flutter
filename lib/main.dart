import 'dart:math';

import 'package:flutter/material.dart';
import 'question.dart';
import 'quiz_brain.dart';

void main() => runApp(Quizzler());

QuizBrain quizBrain = QuizBrain();

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

List<Widget> initialScoreKeeper = [
  SizedBox(
    height: 40,
    width: 1,
  )
];

class _QuizPageState extends State<QuizPage> {
  Random r = Random();
  List<Widget> scoreKeeper = initialScoreKeeper;
  int currentQuestionIndex = 0;
  int scoreCount = 0;

  Widget getScoreIcon(isCorrect, question) {
    return isCorrect
        ? Icon(Icons.check, color: Colors.green, semanticLabel: "correct")
        : Icon(Icons.close, color: Colors.red, semanticLabel: "wrong");
  }

  void handleCheck(value, question) {
    if (currentQuestionIndex > quizBrain.qSize() - 1) {
      return;
    }
    bool isCorrect = value == question.answer;
    setState(() {
      scoreKeeper.add(getScoreIcon(isCorrect, question));
      currentQuestionIndex++;
      scoreCount += isCorrect ? 1 : 0;
    });
  }

  void handleReset() {
    setState(() {
      currentQuestionIndex = 0;
      scoreCount = 0;
      scoreKeeper.clear();
      scoreKeeper.add(
        SizedBox(
          height: 40,
          width: 1,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _gameOver = (currentQuestionIndex == quizBrain.qSize());
    Question currentQuestion = _gameOver
        ? quizBrain.getLast()
        : quizBrain.getQuestion(currentQuestionIndex);

    double percent = (scoreCount / quizBrain.qSize() * 1.0) * 100;

    Widget gameOverStatement = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Final Score: ${percent.truncateToDouble()}%',
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
            )),
        Text('$scoreCount out of ${quizBrain.qSize()}',
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
            )),
      ],
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: _gameOver
                  ? gameOverStatement
                  : Text(
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
      ],
    );
  }
}
