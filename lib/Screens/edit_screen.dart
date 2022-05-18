import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myflashcard/Screens/word_list_screen.dart';
import 'package:myflashcard/db/database.dart';
import 'package:myflashcard/main.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _backToWordListScreen();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("新しい単語の追加"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.done),
              tooltip: "登録",
              onPressed: () => _addNewWord(),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              Center(
                child: Text(
                  "問題と答えを入力して「登録」ボタンを押して下さい",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              SizedBox(height: 30.0),
              //問題入力部分
              _questionInputPart(),
              SizedBox(height: 30.0),
              //答え入力部分
              _answerInputPart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _questionInputPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: <Widget>[
          Text(
            "問題",
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(height: 10.0),
          TextField(
            controller: questionController,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30.0),
          )
        ],
      ),
    );
  }

  Widget _answerInputPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: <Widget>[
          Text(
            "答え",
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(height: 10.0),
          TextField(
            controller: answerController,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30.0),
          )
        ],
      ),
    );
  }

  Future<bool> _backToWordListScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WordListScreen()),
    );
    return Future.value(false);
  }

  _addNewWord() async {
    if (questionController.text.isEmpty || answerController.text.isEmpty) {
      return;
    }
    var word = Word(
      strQuestion: questionController.text,
      strAnswer: answerController.text,
    );
    await database.addWord(word);
    questionController.clear();
    answerController.clear();

    //登録完了メッセージ
    FlutterToast.showToast(
      msg: "登録完了しました",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
