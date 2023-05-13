import 'dart:async';
import 'dart:convert';
// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'package:quizzler/score.dart';

import 'btn.dart';
// import 'package:dart_random_choice/dart_random_choice.dart';

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  late int correctAnswer;
  late int questionNumber;
  late Color backgroundColor;
  String question = "";
  late Future<List<Questions>> futureQuestions;

  @override
  void initState() {
    super.initState();
    futureQuestions = fetchQuestions();
    questionNumber = 0;
    correctAnswer = 0;
    backgroundColor = Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    List<String> questions = [];
    List<String> correctAnswers = [];
    return Column(
      children: [
        Score(score: correctAnswer),
        FutureBuilder<List<Questions>>(
            future: futureQuestions,
            builder: (context, data) {
              if (data.hasData) {
                data.data?.forEach((question) {
                  final newQuestion = HtmlUnescape().convert(question.question);
                  questions.add(newQuestion);
                  correctAnswers.add(question.correctAnswer);
                });
              }
              
              if (questionNumber == 10) {
                return Container(
                  width: 300,
                  height: 250,
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Text(
                        style: TextStyle(color: Colors.black, fontSize: 25),
                        "Game Over \nYou scored ${correctAnswer} | ${questions.length}",
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: backgroundColor),
                );
              } else {
                return Container(
                  width: 300,
                  height: 250,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Q${questionNumber + 1}) ${
                        questions[questionNumber]
                        }}',
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  ),
                  decoration: BoxDecoration(color: backgroundColor),
                );
              }
            }),
        SizedBox(
          height: 20,
          width: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Btn(Colors.green, "True", () {
            if (questionNumber <= 9) {
              setState(() {
                if (correctAnswers[questionNumber] == "True") {
                  setState(() {
                    correctAnswer++;
                    backgroundColor = Colors.green;
                  });
                  Timer(const Duration(milliseconds: 300), () {
                    setState(() {
                      backgroundColor = Colors.white;
                    });
                  });
                } else {
                  backgroundColor = Colors.red;
                  Timer(const Duration(milliseconds: 300), () {
                    setState(() {
                      backgroundColor = Colors.white;
                    });
                  });
                }
                if (questionNumber <= 9) {
                  questionNumber++;
                } 
              });
            }
          }),
          Btn(Colors.red, "False", () {
            if (questionNumber <= 9) {
              setState(() {
                if (correctAnswers[questionNumber] == "False") {
                  correctAnswer++;
                  backgroundColor = Colors.green;
                  Timer(const Duration(milliseconds: 300), () {
                    setState(() {
                      backgroundColor = Colors.white;
                    });
                  });
                } else {
                  backgroundColor = Colors.red;
                  Timer(const Duration(milliseconds: 300), () {
                    setState(() {
                      backgroundColor = Colors.white;
                    });
                  });
                }
                if (questionNumber <= 9) {
                  questionNumber++;
                }
              });
            } else {
              print("Game Over");
            }
          }),
        ]),
      ],
    );
  }
}

//Question model for mapping the output from the API
class Questions {
  final String question;
  final String correctAnswer;

  Questions({required this.question, required this.correctAnswer});

  factory Questions.fromJson(Map<String, dynamic> json) {
    return Questions(
      question: json['question'] as String,
      correctAnswer: json['correct_answer'] as String,
    );
  }
}

Future<List<Questions>> fetchQuestions() async {
  final response = await http
      .get(Uri.parse("https://opentdb.com/api.php?amount=10&type=boolean"));

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    final responseDataList = (responseData["results"] as List)
        .map((data) => Questions.fromJson(data))
        .toList();
    return responseDataList;
  } else {
    throw Exception("Failed to load questions");
  }
}
