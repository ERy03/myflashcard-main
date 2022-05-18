import 'package:flutter/material.dart';
import 'package:myflashcard/components/button_with_icon.dart';

import '../screens/test_screen.dart';
import '../screens/word_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isIncludedMemorizedWords = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image.asset("assets/images/image_title.png"),
            ),
            _titleText(),
            // Divider
            const Divider(
              height: 30.0,
              thickness: 1.0,
              indent: 8.0,
              endIndent: 8.0,
              color: Colors.white,
            ),
            // かくにんテストをするボタン
            ButtonWithIcon(
              icon: const Icon(Icons.play_arrow),
              label: "かくにんテストをする",
              onPressed: () => _startTestScreen(context),
              color: Colors.brown,
            ),
            const SizedBox(
              height: 10.0,
            ),
            // radio button
            _radioButton(),
            const SizedBox(
              height: 30.0,
            ),
            // 単語一覧を表示するボタン、
            ButtonWithIcon(
              icon: const Icon(Icons.list),
              label: "単語一覧を見る",
              onPressed: () => _startWordListScreen(context),
              color: Colors.grey,
            ),
            const SizedBox(
              height: 60.0,
            ),
            const Text(
              "Powered by Ryota @ Dreamly 2022",
              style: TextStyle(fontFamily: "Mont"),
            ),
            const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleText() {
    return Column(
      children: const <Widget>[
        Text(
          "私だけの単語帳",
          style: TextStyle(fontSize: 40.0),
        ),
        Text(
          "My Own Flashcard",
          style: TextStyle(fontSize: 24.0, fontFamily: "Mont"),
        ),
      ],
    );
  }

  Widget _radioButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0),
      child: Column(
        children: <Widget>[
          RadioListTile(
              title: const Text(
                "暗記済みの単語を除外する",
                style: TextStyle(fontSize: 16.0),
              ),
              value: false,
              groupValue: isIncludedMemorizedWords,
              onChanged: (bool? value) => _onRadioSelected(value!)),
          RadioListTile(
            title: const Text(
              "暗記済みの単語を含む",
              style: TextStyle(fontSize: 16.0),
            ),
            value: true,
            groupValue: isIncludedMemorizedWords,
            onChanged: (bool? value) => _onRadioSelected(value!),
          ),
        ],
      ),
    );
  }

  _onRadioSelected(bool value) {
    setState(
      () {
        isIncludedMemorizedWords = value;
        // ignore: avoid_print
        print("$value selected");
      },
    );
  }

  _startWordListScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => WordListScreen()),
      ),
    );
  }

  _startTestScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => TestScreen(
              isIncludedMemorizedWords: isIncludedMemorizedWords,
            )),
      ),
    );
  }
}
