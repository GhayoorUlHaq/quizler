import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import './QuestionList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  QuestionList list = QuestionList();

  List<Icon> score = [];

  FlatButton _renderButton(bool s) {
    return FlatButton(
      onPressed: () {
        if (list.getCurrentQuestion().getAnswer() == s) {
          setState(() {
            score.add(Icon(
              Icons.check,
              color: Colors.green,
            ));
          });
        } else {
          score.add(Icon(
            Icons.clear,
            color: Colors.red,
          ));
        }
        bool finished = list.changeQuestionNumber();
        if (finished) {
          Alert(
            context: context,
            type: AlertType.success,
            title: "Finished Quizz",
            desc: "You're quizz is finished.",
            buttons: [
              DialogButton(
                child: Text(
                  "👍",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
          ).show();
          list.resetQuestionNumber();
          this.setState(() {
            score = [];
          });
        }
        this.setState(() {});
      },
      child: Container(
        color: s == true ? Colors.green : Colors.red,
        height: 60.0,
        margin: EdgeInsets.only(bottom: 20.0),
        child: Center(
            child: Text(
          s ? 'True' : 'False',
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    list.getCurrentQuestion().getQuestion(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _renderButton(true),
                  _renderButton(false),
                  Container(
                    height: 20,
                    child: Row(
                      children: score,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
