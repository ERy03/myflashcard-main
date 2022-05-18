import 'dart:io';

import 'package:flutter/material.dart';

enum TestStatus {
  BEFORE_START,
  SHOW_QUESTION,
  SHOW_ANSWER,
  FINISHED,
}

class TestScreen extends StatefulWidget {
  final bool isIncludedMemorizedWords;

  TestScreen({required this.isIncludedMemorizedWords});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int _numberofQuestion = 0; //TODO

  String _txtQuestion = "問題"; //TODO

  String _txtAnswer = "答え";

  bool _isMemorized = false; //TODO

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("かくにんテスト"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print("You pressed me"), //TODO
        child: Icon(Icons.skip_next),
        tooltip: "次に進む",
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10.0,),
            _numberOfQuestionsPart(),
            SizedBox(height: 20.0,),
            _questionCardPart(),
            SizedBox(height: 10.0,),
            _answerCardPart(),
            SizedBox(height: 10.0,),
            _isMemorizedCheckPart(),
          ],
        )
      ),
    );
  }

  Widget _numberOfQuestionsPart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("のこり問題数", style: TextStyle(fontSize: 14.0),),
        SizedBox(width: 28.0,),
        Text(_numberofQuestion.toString(), style: TextStyle(fontSize: 24.0),),
      ],
    );
  }

  Widget _questionCardPart() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget> [
        Image.asset("assets/images/image_flash_question.png"),
        Text(_txtQuestion, style: TextStyle(fontSize: 20.0, color: Colors.grey[800]),)
      ]
    );
  }

  Widget _answerCardPart() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget> [
        Image.asset("assets/images/image_flash_answer.png"),
        Text(_txtAnswer, style: TextStyle(fontSize: 20.0,),)
      ]
    );
  }

  Widget _isMemorizedCheckPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: CheckboxListTile(
        title: Text("暗記済みにする場合はチェックを入れて下さい", style: TextStyle(fontSize: 12.0),),
        value: _isMemorized,
        onChanged: (value) {
          setState(() {
            _isMemorized = value!;
            print(_isMemorized);
          });
        },
      ),
    );
  }
}
