import 'package:flutter/material.dart';
import 'package:myflashcard/db/database.dart';
import 'package:myflashcard/main.dart';


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
  int _numberofQuestion = 0;

  String _txtQuestion = "";

  String _txtAnswer = "";

  bool _isMemorized = false;

  bool _isQuestionCardVisible = false;
  bool _isAnswerCardVisible = false;
  bool _isCheckBoxVisible = false;
  bool _isFabVisible = true;

  List<Word> _testDataList = [];

  TestStatus _testStatus = TestStatus.BEFORE_START;

  int _index = 0;

  late Word _currentWord;

@override
  void initState() {
    super.initState();
    _getTestData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _finishTestScreen(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("かくにんテスト"),
          centerTitle: true,
        ),
        floatingActionButton: (_isFabVisible && _testDataList.isNotEmpty) ? FloatingActionButton(
          onPressed: () => _goNextStatus(),
          child: Icon(Icons.skip_next),
          tooltip: "次に進む",
        ): null,
        body: Stack(
          children:
            [Column(
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
            ),
            _endMessage(),
          ]
        ),
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
    if(_isQuestionCardVisible){
      return Stack(
        alignment: Alignment.center,
        children: <Widget> [
          Image.asset("assets/images/image_flash_question.png"),
          Text(_txtQuestion, style: TextStyle(fontSize: 20.0, color: Colors.grey[800]),)
        ]
      );
    }else{
      return Container();
    }
  }

  Widget _answerCardPart() {
    if(_isAnswerCardVisible){
      return Stack(
        alignment: Alignment.center,
        children: <Widget> [
          Image.asset("assets/images/image_flash_answer.png"),
          Text(_txtAnswer, style: TextStyle(fontSize: 20.0,),)
        ]
      );
    }else {
      return Container();
    }
  }

  Widget _isMemorizedCheckPart() {
    if(_isCheckBoxVisible){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: CheckboxListTile(
          title: Text("暗記済みにする場合はチェックを入れて下さい", style: TextStyle(fontSize: 12.0),),
          value: _isMemorized,
          onChanged: (value) {
            setState(() {
              _isMemorized = value!;
            });
          },
        ),
      );
    }else{
      return Container();
    }
  }

  void _getTestData() async{
     if(widget.isIncludedMemorizedWords){
       _testDataList = await database.allWords;
     }else{
       _testDataList = await database.allWordsExcludeMemorized;
     }

    _testDataList.shuffle();
    _testStatus = TestStatus.BEFORE_START;
    _index = 0;

    setState(() {
      _isQuestionCardVisible = false;
      _isAnswerCardVisible = false;
      _isCheckBoxVisible = false;
      _isFabVisible = true;
      _numberofQuestion = _testDataList.length;
    });
  }

  _goNextStatus() {
    switch (_testStatus) {
      case TestStatus.BEFORE_START:
        _testStatus = TestStatus.SHOW_QUESTION;
        _showQuestion();
        break;
      case TestStatus.SHOW_QUESTION:
        _testStatus = TestStatus.SHOW_ANSWER;
        _showAnswer();
        break;
      case TestStatus.SHOW_ANSWER:
      _updateMemorizedFlag();
      if(_numberofQuestion <= 0){
        setState(() {
          _isFabVisible = false;
          _testStatus = TestStatus.FINISHED;
        });
      }else{
        _testStatus = TestStatus.SHOW_QUESTION;
        _showQuestion();
      }
        break;
      case TestStatus.FINISHED:
        break;
    }
  }

  void _showQuestion() {
    _currentWord = _testDataList[_index];
    setState(() {
      _isQuestionCardVisible = true;
      _isAnswerCardVisible = false;
      _isCheckBoxVisible = false;
      _isFabVisible = true;
      _txtQuestion = _currentWord.strQuestion;
    });
    _numberofQuestion --;
    _index ++;
  }

  void _showAnswer() {
    setState(() {
      _isQuestionCardVisible = true;
      _isAnswerCardVisible = true;
      _isCheckBoxVisible = true;
      _isFabVisible = true;
      _txtAnswer = _currentWord.strAnswer;
      _isMemorized = _currentWord.isMemorized;
    });
  }

  Future<void> _updateMemorizedFlag() async{
    var updateWord = Word(
      strQuestion: _currentWord.strQuestion,
      strAnswer: _currentWord.strAnswer,
      isMemorized: _isMemorized
    );
    await database.updateWord(updateWord);
  }

  Widget _endMessage() {
    if(_testStatus == TestStatus.FINISHED){
      return Center(
        child: Text(
          "テスト終了",
          style: TextStyle(fontSize: 50.0,),
        ),
      );
    } else {
      return Container();
    }
  }

  Future<bool> _finishTestScreen() async {
    return await showDialog(context: context, builder: (_) => AlertDialog(
      title: Text("テスト終了"),
      content: Text("テストを終了してもいいですか？"),
      actions: [
        TextButton(
          child: Text("はい"),
          onPressed: (){
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("いいえ"),
        ),
      ]
    )) ?? false;
  }
}
