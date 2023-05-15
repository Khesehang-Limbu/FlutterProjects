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