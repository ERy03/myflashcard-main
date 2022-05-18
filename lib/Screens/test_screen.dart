import 'package:flutter/material.dart';

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
      body: Center(
        child: Text("TestScreen: $isIncludedMemorizedWords"),
      ),
    );
  }
}
