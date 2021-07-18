import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';
import 'quizscreen.dart';
import 'result_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;


    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark
      )
    );
    return Scaffold(
      backgroundColor: kPrimaryBackgroundColor,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height/3,
              ),
              Center(
                child: Image(
                  image: AssetImage('assets/quiz.png'),
                  width: 300,
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
                      'PLAY',
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
              )

            ],
          ),
        ),
      ),
    );
  }
}


