import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../models/flashcard_set.dart';

class AddEditFlashcardScreen extends StatefulWidget {
  final List<FlashcardSet> sets;
  final Flashcard? flashcard;

  AddEditFlashcardScreen({required this.sets, this.flashcard});

  @override
  _AddEditFlashcardScreenState createState() => _AddEditFlashcardScreenState();
}

class _AddEditFlashcardScreenState extends State<AddEditFlashcardScreen> {
  final questionController = TextEditingController();
  final answerController = TextEditingController();
  final option1Controller = TextEditingController();
  final option2Controller = TextEditingController();
  final option3Controller = TextEditingController();
  FlashcardSet? selectedSet;

  @override
  void initState() {
    super.initState();
    if (widget.flashcard != null) {
      questionController.text = widget.flashcard!.question;
      answerController.text = widget.flashcard!.correctAnswer;
      option1Controller.text = widget.flashcard!.options[0];
      option2Controller.text = widget.flashcard!.options[1];
      option3Controller.text = widget.flashcard!.options[2];
      selectedSet = widget.sets
          .firstWhere((set) => set.flashcards.contains(widget.flashcard));
    } else {
      selectedSet = widget.sets.isNotEmpty ? widget.sets[0] : null;
    }
  }

  @override
  void dispose() {
    questionController.dispose();
    answerController.dispose();
    option1Controller.dispose();
    option2Controller.dispose();
    option3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              widget.flashcard == null ? 'Add Flashcard' : 'Edit Flashcard')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DropdownButton<FlashcardSet>(
                value: selectedSet,
                onChanged: (FlashcardSet? newValue) {
                  setState(() {
                    selectedSet = newValue;
                  });
                },
                items: widget.sets
                    .map<DropdownMenuItem<FlashcardSet>>((FlashcardSet set) {
                  return DropdownMenuItem<FlashcardSet>(
                    value: set,
                    child: Text(set.title),
                  );
                }).toList(),
              ),
              TextField(
                  controller: questionController,
                  decoration: InputDecoration(labelText: 'Question')),
              TextField(
                  controller: answerController,
                  decoration: InputDecoration(labelText: 'Correct Answer')),
              TextField(
                  controller: option1Controller,
                  decoration: InputDecoration(labelText: 'Option 1')),
              TextField(
                  controller: option2Controller,
                  decoration: InputDecoration(labelText: 'Option 2')),
              TextField(
                  controller: option3Controller,
                  decoration: InputDecoration(labelText: 'Option 3')),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(widget.flashcard == null ? 'Add' : 'Save'),
                onPressed: () {
                  if (questionController.text.isEmpty ||
                      answerController.text.isEmpty ||
                      option1Controller.text.isEmpty ||
                      option2Controller.text.isEmpty ||
                      option3Controller.text.isEmpty ||
                      selectedSet == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields')),
                    );
                    return;
                  }

                  final newFlashcard = Flashcard(
                    question: questionController.text,
                    correctAnswer: answerController.text,
                    options: [
                      option1Controller.text,
                      option2Controller.text,
                      option3Controller.text
                    ],
                  );

                  if (widget.flashcard == null) {
                    selectedSet!.flashcards.add(newFlashcard);
                  } else {
                    final index =
                    selectedSet!.flashcards.indexOf(widget.flashcard!);
                    if (index != -1) {
                      selectedSet!.flashcards[index] = newFlashcard;
                    }
                  }

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
