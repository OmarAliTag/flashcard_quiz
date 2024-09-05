import 'package:flutter/material.dart';
import '../models/flashcard_set.dart';
import '../widgets/flashcard_widget.dart';
import 'add_edit_flashcard.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QuizScreen extends StatefulWidget {
  final FlashcardSet set;

  QuizScreen({required this.set});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool showResult = false;
  bool isCorrect = false;

  void checkAnswer(String answer) {
    setState(() {
      isCorrect =
          answer == widget.set.flashcards[currentQuestionIndex].correctAnswer;
      if (isCorrect) {
        score++;
      }
      showResult = true;
    });
  }

  void nextQuestion() {
    setState(() {
      currentQuestionIndex++;
      showResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex >= widget.set.flashcards.length) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.blue.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Quiz Complete!',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white),
                ).animate().fadeIn(duration: 600.ms),
                SizedBox(height: 20),
                Text(
                  'Your score: $score/${widget.set.flashcards.length}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white),
                ).animate().slideY(begin: 0.5, duration: 600.ms),
                SizedBox(height: 40),
                ElevatedButton(
                  child: Text('Back to Home'),
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade700,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ).animate().scale(duration: 600.ms),
              ],
            ),
          ),
        ),
      );
    }

    final flashcard = widget.set.flashcards[currentQuestionIndex];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade700, Colors.blue.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.set.title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      'Question ${currentQuestionIndex + 1}/${widget.set.flashcards.length}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white70),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: FlashcardWidget(flashcard: flashcard),
                ),
                SizedBox(height: 20),
                ...flashcard.options.map((option) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: showResult ? null : () => checkAnswer(option),
                      child: Text(option),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue.shade700,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        textStyle: TextStyle(fontSize: 16),
                      ),
                    ).animate().slideX(begin: -1.0, duration: 500.ms),
                  );
                }).toList(),
                if (showResult)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      isCorrect ? 'Correct!' : 'Wrong!',
                      style: TextStyle(
                        color: isCorrect
                            ? Colors.green.shade300
                            : Colors.red.shade300,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(duration: 500.ms),
                  ),
                if (showResult)
                  ElevatedButton(
                    onPressed: nextQuestion,
                    child: Text('Next Question'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade700,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ).animate().slideY(begin: 1.0, duration: 500.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
