import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:html_unescape/html_unescape.dart';

import 'package:quizzler/questions/views/cubit/quiz_cubit.dart';

import '../../data/models/question_model.dart';

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  PageController controller = PageController();
  int score = 0;
  void checkandUpdateScore(Questions ques, String selctedAns, String value) {
    bool update = selctedAns.toLowerCase() == value.toLowerCase();
    if (update) {
      setState(() {
        score++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizCubit, QuizState>(builder: (context, state) {
      if (state is QuizFailure) {
        return const Text('Something went wrong');
      } else if (state is QuizSuccess) {
        if (state.questions.isEmpty) {
          return const Text('Empty Questions');
        } else {
          return PageView.builder(
            controller: controller,
            itemCount: state.questions.length,
            itemBuilder: (ctx, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(50),
                      child: Text(
                        'Score $score',
                        style: const TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 250,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        HtmlUnescape().convert(state.questions[index].question),
                        style: const TextStyle(color: Colors.black, fontSize: 25),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.green),
                              foregroundColor:
                                  MaterialStatePropertyAll(Colors.white)),
                          onPressed: () {
                            controller.nextPage(
                                duration: Duration(microseconds: 200),
                                curve: Curves.ease);
                            final reseult = checkandUpdateScore(
                                state.questions[index],
                                'true',
                                state.questions[index].correctAnswer);
                          },
                          child: const Padding(
                            padding:  EdgeInsets.all(10),
                            child:  Text(
                              "True",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 30),
                            ),
                          )),
                      TextButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.red),
                              foregroundColor:
                                  MaterialStatePropertyAll(Colors.white)),
                          onPressed: () {
                            controller.nextPage(
                                duration: const Duration(microseconds: 200),
                                curve: Curves.ease);
                            final result = checkandUpdateScore(
                                state.questions[index],
                                'false',
                                state.questions[index].correctAnswer);
                          },
                          child: const Padding(
                            padding:  EdgeInsets.all(10),
                            child: Text(
                              "False",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 30),
                            ),
                          )),
                    ],
                  )
                ],
              );
            },
          );
        }
      } else {
        return const CircularProgressIndicator();
      }
      // return Column(children: []);
    });
  }
}
