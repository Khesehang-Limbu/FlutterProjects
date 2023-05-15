import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzler/questions/data/repository/api_repo.dart';
import 'package:quizzler/questions/views/cubit/quiz_cubit.dart';
import 'package:quizzler/questions/views/pages/question_body.dart';
// import 'package:quizzler/question_body.dart';

void main() {
  runApp(
    BlocProvider<QuizCubit>(
      create: (BuildContext context) => QuizCubit(ApiRepo())..fetchQuestions(),
      child: Builder(builder: (context) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.teal,
              body: Question(),
            ),
          ),
        );
      }),
    ),
  );
}
