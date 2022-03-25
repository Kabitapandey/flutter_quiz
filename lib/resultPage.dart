import 'package:flutter/material.dart';
import 'package:quiz/home.dart';

class ResultPage extends StatefulWidget {
  int marks;
  ResultPage({Key? key, required this.marks}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<String> images = [
    'images/good.png',
    'images/bad.png',
    'images/success.png'
  ];
  String msg = '';
  String image = '';
  @override
  void initState() {
    if (widget.marks <= 20) {
      image = images[1];
      msg = 'You should try hard!!\n' + 'You scroed ${widget.marks}';
    } else if (widget.marks <= 40) {
      image = images[0];
      msg = 'You can do better!!\n' + 'You scroed ${widget.marks}';
    } else {
      image = images[2];
      msg = 'You did very well!!\n' + 'You scroed ${widget.marks}';
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Material(
              elevation: 10.0,
              child: Container(
                  child: Column(children: [
                Material(
                  child: Container(
                    width: 300.0,
                    height: 300.0,
                    child: ClipRect(
                      child: Image(
                        image: AssetImage(image),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 15.0),
                  child: Center(
                      child: Text(
                    '$msg',
                    style: TextStyle(fontSize: 20.0, fontFamily: 'Quando'),
                  )),
                )
              ])),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlineButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  splashColor: Colors.indigoAccent,
                  child: Text(
                    "Continue",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  borderSide: BorderSide(color: Colors.indigo, width: 3.0),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
