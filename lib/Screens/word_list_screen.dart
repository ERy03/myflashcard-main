import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myflashcard/main.dart';
import 'package:myflashcard/db/database.dart';


import 'edit_screen.dart';

class WordListScreen extends StatefulWidget {
  const WordListScreen({Key? key}) : super(key: key);

  @override
  State<WordListScreen> createState() => _WordListScreenState();
}

class _WordListScreenState extends State<WordListScreen> {

List<Word> _wordList = [];

@override
  void initState() {
    super.initState();
    _getAllWords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("単語一覧"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _wordListWidget(),
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
        context, MaterialPageRoute(builder: (context) => EditScreen(
          status: EditStatus.ADD,
        )));
  }

  void _getAllWords() async {
    _wordList = await database.allWords;
    setState(() {});
  }

  Widget _wordListWidget() {
    return ListView.builder(
      itemCount: _wordList.length,
      itemBuilder: (context, int position) => _wordListItem(position),
    );
  }

  _wordListItem(int position) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.grey[600],
      child: ListTile(
        title: Text(_wordList[position].strQuestion),
        subtitle: Text(_wordList[position].strAnswer, style: TextStyle(fontFamily: "Mont")),
        onTap: () => _editWord(_wordList[position]),
        onLongPress: () => _deleteWord(_wordList[position]),
      ),
    );
  }

  _deleteWord(Word selectedWord) async{
    await database.deleteWord(selectedWord);
    Fluttertoast.showToast(
      msg: "単語を削除しました",
      toastLength: Toast.LENGTH_LONG,
    );
    _getAllWords();
  }

  _editWord(Word selectedWord) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => EditScreen(
          status: EditStatus.EDIT,
          word: selectedWord,
        )));
  }
}
