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
            _numberOfQuestionsPart(),
            _questionCardPart(),
            _answerCardPart(),
            _isMemorizedCheckPart(),
          ],
        )
      ),
    );
  }

  Widget _numberOfQuestionsPart() {
    return Container(); //TODO
  }

  Widget _questionCardPart() {
    return Container(); //TODO
  }

  Widget _answerCardPart() {
    return Container(); //TODO
  }

  Widget _isMemorizedCheckPart() {
    return Container(); //TODO
  }
}
