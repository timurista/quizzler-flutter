import 'question.dart';

class QuizBrain {
  List<Question> _questions = [
    Question(
      question: 'You can lead a cow down stairs but not up stairs.',
      answer: false,
    ),
    Question(
      question:
          "The letter 'e' is the most common letter in the English language.",
      answer: true,
    ),
    Question(
      question: "Approximately one quarter of human bones are in the feet.",
      answer: true,
    ),
    Question(
      question:
          "The primary colors of pigment (sometimes called the subtractive primary colors) are red, yellow, and blue.",
      answer: false,
    ),
    Question(
      question: "Zero is both an even number and an odd number.",
      answer: false,
    ),
    Question(
      question:
          "There exist three directions such that, by moving in those three directions, it is possible to go anywhere on a two-dimensional surface.",
      answer: true,
    ),
    Question(
      question: 'A slug\'s blood is green.',
      answer: true,
    )
  ];
  QuizBrain() {}

  Question getLast() {
    return _questions.last;
  }

  Question getQuestion(int questionIndex) {
    return _questions[questionIndex];
  }

  int qSize() {
    return _questions.length;
  }
}
