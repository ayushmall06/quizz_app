

import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:quizz_app/constants.dart';
import 'package:quizz_app/result_screen.dart';
import 'quiz_helper.dart';
import 'package:http/http.dart' as http;

class QuizScreen extends StatefulWidget {


  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  var apiURL = Uri.parse("https://opentdb.com/api.php?amount=10&category=18&type=multiple");

   QuizHelper quizHelper;

  int currentQuestion = 0;

  int totalSeconds = 5;

  int elapsedSeconds;

  int score = 0;

  Timer timer;

  initTimer() {
    timer = Timer.periodic(
      Duration(seconds: 1),
        (t) {
          if (t.tick == totalSeconds) {
            print("Time completed");
            t.cancel();
            changeQuestion();
          }
          else {
            setState(() {
              elapsedSeconds = t.tick;
            });
          }
        }
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }


  @override
  void initState() {
    // TODO: implement initState
    //fetch question here
    // init state will initialize the variables
    fetchAllQuiz();
    super.initState();

  }

  fetchAllQuiz() async
  {
    var response = await http.get(apiURL);
    var body = response.body;

    print(body);

    var json = jsonDecode(body);
    setState(() {
      quizHelper = QuizHelper.fromJson(json);
      quizHelper.results[currentQuestion].incorrectAnswers
          .add(quizHelper.results[currentQuestion].correctAnswer);
      quizHelper.results[currentQuestion].incorrectAnswers.shuffle();
      initTimer();

    });

  }

  changeQuestion() {
    timer.cancel();

    //check if it the last question
    if(currentQuestion == quizHelper.results.length - 1)
      {
        print("Quize completed $score");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(score: score,),
          )
        );
      }
    else {
      setState(() {
        currentQuestion++;
      });
    }
    quizHelper.results[currentQuestion].incorrectAnswers
        .add(quizHelper.results[currentQuestion].correctAnswer);
    quizHelper.results[currentQuestion].incorrectAnswers.shuffle();

    initTimer();
  }

  checkAnswer(answer) {
    String correctAnswer = quizHelper.results[currentQuestion].correctAnswer;
    if(correctAnswer == answer)
      {
        print("Correct");
        score++;
      }
    else {
      print("Wrong");
    }
    changeQuestion();
  }

  @override
  Widget build(BuildContext context) {

    if(quizHelper != null)
      {
        return Scaffold(
          backgroundColor: kPrimaryBackgroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        image: AssetImage(
                          'assets/quiz.png',
                        ),
                        width: 100,
                      ),

                      Text(
                        '$elapsedSeconds',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),


                //Questions

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Q. ${quizHelper.results[currentQuestion].question}',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),


                //options

                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 40,
                  ),
                  child: Column(
                      children: quizHelper.results[currentQuestion].incorrectAnswers.map((e)
                      => new Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          colorBrightness: Brightness.dark,
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          color: kOptionColor,
                          onPressed: () {
                            checkAnswer(e);
                          },
                          child: Text(
                            e,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      ).toList()
                  ),
                )
              ],
            ),
          ),
        );
      }
    else
      {
        return Scaffold(
          backgroundColor: kPrimaryBackgroundColor,
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
  }
}
