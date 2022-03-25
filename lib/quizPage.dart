import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quiz/resultPage.dart';

class getJson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/python.json'),
        builder: (context, snapshot) {
          List myData = json.decode(snapshot.data.toString());
          if (myData == null) {
            return Scaffold(
                body: Center(
              child: Text('Loading'),
            ));
          } else {
            return QuizPage(myData: myData);
          }
        });
  }
}

class QuizPage extends StatefulWidget {
  var myData;
  QuizPage({Key? key, @required this.myData}) : super(key: key);
  @override
  _QuizPageState createState() => _QuizPageState(myData);
}

class _QuizPageState extends State<QuizPage> {
  var myData;
  int marks = 0;
  _QuizPageState(this.myData);
  Color colorToShow = Colors.indigo;
  Color right = Colors.green;
  Color wrong = Colors.red;
  Map<String, Color> btnColor = {
    'a': Colors.indigo,
    'b': Colors.indigo,
    'c': Colors.indigo,
    'd': Colors.indigo,
  };
  int timer = 30;
  String showTimer = '30';
  bool cancelTimer = false;
  @override
  void initState() {
    startTimer();
    // TODO: implement initState
    super.initState();
  }

  void startTimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextQuestion();
        } else if (cancelTimer) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showTimer = timer.toString();
      });
    });
  }

  int i = 1;

  void nextQuestion() {
    cancelTimer = false;
    timer = 30;
    if (i < 5) {
      setState(() {
        i += 1;
      });
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ResultPage(marks: marks)));
    }
    setState(() {
      btnColor['a'] = Colors.indigo;
      btnColor['b'] = Colors.indigo;
      btnColor['c'] = Colors.indigo;
      btnColor['d'] = Colors.indigo;
    });
    startTimer();
  }

  void checkAnswer(String k) {
    if (myData[2][i.toString()] == myData[1][i.toString()][k]) {
      setState(() {
        marks += 5;
        colorToShow = right;
      });
    } else {
      colorToShow = wrong;
    }
    setState(() {
      btnColor[k] = colorToShow;
      cancelTimer = true;
    });
    Timer(Duration(seconds: 1), nextQuestion);
  }

  Widget choiceButton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: MaterialButton(
        onPressed: () {
          return checkAnswer(k);
        },
        splashColor: Colors.indigoAccent[700],
        highlightColor: Colors.indigoAccent[700],
        child: Text(
          '${myData[1][i.toString()][k]}',
          style: TextStyle(
              color: Colors.white, fontFamily: 'Alike', fontSize: 16.0),
          maxLines: 1,
        ),
        color: btnColor[k],
        minWidth: 200.0,
        height: 45.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  Future<bool> willPopCallBack() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('Quizstat'),
              content: Text("You cannot go back"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return WillPopScope(
        onWillPop: willPopCallBack,
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '${myData[0][i.toString()]}',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Quando'),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      choiceButton('a'),
                      choiceButton('b'),
                      choiceButton('c'),
                      choiceButton('d')
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    alignment: Alignment.topCenter,
                    child: Center(
                      child: Text(
                        '$showTimer',
                        style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                    )),
              )
            ],
          ),
        ));
  }
}
