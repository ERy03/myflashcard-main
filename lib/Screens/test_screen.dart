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
    var isIncludedMemorizedWords = widget.isIncludedMemorizedWords;
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
        child: Text("TestScreen: $isIncludedMemorizedWords"),
      ),
    );
  }
}
