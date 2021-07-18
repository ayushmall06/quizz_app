import 'package:flutter/material.dart';
import 'constants.dart';
import 'quizscreen.dart';

class ResultScreen extends StatelessWidget {

  ResultScreen({this.score});

  final int score;

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kPrimaryBackgroundColor,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height/4,
              ),
              Center(
                child: Image(
                  image: AssetImage('assets/quiz.png'),
                  width: 300,
                ),
              ),
              Text(
                "Result",
                style: TextStyle(
                  color: Color(0xFFA20CBE),
                  fontSize: 35,

                ),

              ),
              Text(
                "$score/10",
                style: TextStyle(
                  color: Color(0xFFFFBA00),
                  fontSize: 60,

                ),

              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 40,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: RaisedButton(
                    child: Text(
                      'REPLAY',
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ),
                    color: Color(0xFFFFBA00),
                    onPressed: () {

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizScreen(),
                          )
                      );
                    },
                    textColor: Colors.white,

                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 40,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: RaisedButton(
                    child: Text(
                      'EXIT',
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ),
                    color: Color(0xFF511AA8),
                    onPressed: () {

                      Navigator.pop(context);
                    },
                    textColor: Colors.white,

                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );

  }
}
