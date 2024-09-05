import 'flashcard.dart';

class FlashcardSet {
  String title;
  List<Flashcard> flashcards;

  FlashcardSet({required this.title, required this.flashcards});

  Map<String, dynamic> toJson() => {
        'title': title,
        'flashcards': flashcards.map((f) => f.toJson()).toList(),
      };

  static FlashcardSet fromJson(Map<String, dynamic> json) => FlashcardSet(
        title: json['title'],
        flashcards: (json['flashcards'] as List)
            .map((f) => Flashcard.fromJson(f))
            .toList(),
      );
}
