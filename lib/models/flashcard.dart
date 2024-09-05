class Flashcard {
  String question;
  String correctAnswer;
  List<String> options;

  Flashcard(
      {required this.question,
      required this.correctAnswer,
      required this.options});

  Map<String, dynamic> toJson() => {
        'question': question,
        'correctAnswer': correctAnswer,
        'options': options,
      };

  static Flashcard fromJson(Map<String, dynamic> json) => Flashcard(
        question: json['question'],
        correctAnswer: json['correctAnswer'],
        options: List<String>.from(json['options']),
      );
}
