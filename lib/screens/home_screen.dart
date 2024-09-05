import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'quiz_screen.dart';
import 'add_edit_flashcard.dart';
import '../models/flashcard_set.dart';
import '../models/flashcard.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FlashcardSet> sets = [];

  @override
  void initState() {
    super.initState();
    loadFlashcardSets();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/flashcard_sets.json');
  }

  Future<void> loadFlashcardSets() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        String contents = await file.readAsString();
        List<dynamic> jsonList = json.decode(contents);
        setState(() {
          sets = jsonList.map((json) => FlashcardSet.fromJson(json)).toList();
        });
      } else {
        // Initialize with some default sets if the file doesn't exist
        sets = [
          FlashcardSet(title: 'Geography', flashcards: []),
          FlashcardSet(title: 'Maths', flashcards: []),
          FlashcardSet(title: 'Science', flashcards: []),
        ];
        await saveFlashcardSets();
      }
    } catch (e) {
      print("Error loading flashcard sets: $e");
    }
  }

  Future<void> saveFlashcardSets() async {
    try {
      final file = await _localFile;
      String jsonString = json.encode(sets.map((set) => set.toJson()).toList());
      await file.writeAsString(jsonString);
    } catch (e) {
      print("Error saving flashcard sets: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flashcard Quiz')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: sets.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: ListTile(
                  title: Text(sets[index].title,
                      style: Theme.of(context).textTheme.headlineMedium),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(set: sets[index]),
                      ),
                    );
                  },
                ),
              ).animate().slideX(begin: -1.0, duration: 500.ms);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddEditFlashcardScreen(sets: sets, flashcard: null),
            ),
          );
          setState(() {}); // Refresh the UI
          saveFlashcardSets(); // Save the updated sets
        },
      ),
    );
  }
}
