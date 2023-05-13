import "package:flutter/material.dart";
import 'package:quizzler/question_body.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.teal,
          body: Question(),
        ),
      ),
    ),
  );
}
