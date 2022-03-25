import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz/quizPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> images = [
    'images/py.png',
    'images/java.png',
    'images/js.png',
    'images/cpp.png',
    'images/linux.png'
  ];

  Widget customCard(String langName, String image) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => getJson()));
          },
          child: Material(
            color: Colors.indigoAccent,
            elevation: 10.0,
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(100.0),
                      child: Container(
                        height: 200.0,
                        width: 200.0,
                        child: ClipOval(
                            child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage('$image'),
                        )),
                      ),
                    ),
                  ),
                  Center(
                      child: Text(
                    '$langName',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontFamily: 'Quando',
                        fontWeight: FontWeight.w700),
                  )),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Text('This is some random description',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontFamily: 'Alike',
                        ),
                        maxLines: 5,
                        textAlign: TextAlign.justify),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizstar', style: TextStyle(fontFamily: 'Quando')),
      ),
      body: ListView(
        children: [
          customCard('Python', images[0]),
          customCard('Java', images[1]),
          customCard('Javascript', images[2]),
          customCard('C++', images[3]),
          customCard('Linux', images[4])
        ],
      ),
    );
  }
}
