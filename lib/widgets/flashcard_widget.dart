import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/flashcard.dart';

class FlashcardWidget extends StatelessWidget {
  final Flashcard flashcard;

  FlashcardWidget({required this.flashcard});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(flashcard.question,
                style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 8.0),
            ...flashcard.options
                .map((option) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(option,
                  style: Theme.of(context).textTheme.bodyMedium),
            ))
                .toList(),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 500.ms);
  }
}
