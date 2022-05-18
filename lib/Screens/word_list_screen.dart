import 'package:flutter/material.dart';

import 'edit_screen.dart';

class WordListScreen extends StatefulWidget {
  const WordListScreen({Key? key}) : super(key: key);

  @override
  State<WordListScreen> createState() => _WordListScreenState();
}

class _WordListScreenState extends State<WordListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("単語一覧"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("WordListScreen"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: "新しい単語の追加",
        onPressed: () => _addNewWord(),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _addNewWord() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => EditScreen()));
  }
}
