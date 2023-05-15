import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  const Score({super.key, required this.score});

  final int score;
  
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.all(50),
        child: Text(
          'Score $score',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }
}
