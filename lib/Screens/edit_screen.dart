import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myflashcard/Screens/word_list_screen.dart';
import 'package:myflashcard/db/database.dart';
import 'package:myflashcard/main.dart';

enum EditStatus {
  ADD,
  EDIT,
}

class EditScreen extends StatefulWidget {
  final EditStatus status;
  final Word? word;

  EditScreen({required this.status, this.word});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  String _titleText = "";

  bool _isQuestionEnabled = true;

  @override
  void initState() {
    super.initState();
    if(widget.status == EditStatus.ADD){
      _isQuestionEnabled = true;
      _titleText = "新しい単語の追加";
      questionController.text = "";
      answerController.text = "";
    } else {
      _isQuestionEnabled = false;
      _titleText = "単語の編集";
      questionController.text = widget.word!.strQuestion;
      answerController.text = widget.word!.strAnswer;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _backToWordListScreen();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_titleText),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.done),
              tooltip: "登録",
              onPressed: () => _onWordRegistered(),
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
            enabled: _isQuestionEnabled,
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
      Fluttertoast.showToast(
        msg: "問題と答えの両方を入力しないと登録できません",
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }

    showDialog(context: context, builder: (_) => AlertDialog(
      title: Text("登録"),
      content: Text("登録していいですか？"),
      actions: [
        TextButton(
          style: ButtonStyle(
            foregroundColor:
            MaterialStateProperty.all<Color>(Colors.white),
          ),
          child: Text("はい"),
          onPressed: () async{
            var word = Word(
              strQuestion: questionController.text,
              strAnswer: answerController.text,
              isMemorized: false,
            );

          try {
            await database.addWord(word);
            questionController.clear();
            answerController.clear();
          } on SqliteException catch (e) {
              print(e.toString());
            Fluttertoast.showToast(
              msg: "この問題は既に登録されていますので登録できません",
              toastLength: Toast.LENGTH_LONG,
            );
            return;
          } finally {
            Navigator.pop(context);
          }
          //登録完了メッセージ
          Fluttertoast.showToast(
            msg: "登録完了しました",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
          );
          },
        ),
        TextButton(
          style: ButtonStyle(
            foregroundColor:
            MaterialStateProperty.all<Color>(Colors.white),
          ),
          child: Text("いいえ"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ));
    }

  _onWordRegistered() {
    if(widget.status == EditStatus.ADD){
      _addNewWord();
    } else {
      _updateWord();
    }
  }

  void _updateWord() async {
    if (questionController.text.isEmpty || answerController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "問題と答えの両方を入力しないと登録できません",
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }

    showDialog(context: context, builder: (_) => AlertDialog(
      title: Text("${questionController.text}の変更"),
      content: Text("変更していいですか？"),
      actions: [
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          child: Text("はい"),
          onPressed: () async{
            var word = Word(
              strQuestion: questionController.text,
              strAnswer: answerController.text,
              isMemorized: false,
            );

            try {
              await database.updateWord(word);
               Navigator.pop(context);
              _backToWordListScreen();
              Fluttertoast.showToast(
                msg: "更新完了しました",
                toastLength: Toast.LENGTH_LONG,
              );
            } on SqliteException catch (e) {
              Fluttertoast.showToast(
                msg: "何らかの問題が発生して登録できませんでした: $e",
                toastLength: Toast.LENGTH_LONG,
              );
              Navigator.pop(context);
            }
          },
        ),
        TextButton(
          style: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: () =>  Navigator.pop(context),
          child: Text("いいえ"),),
      ],
    ));
  }
}
