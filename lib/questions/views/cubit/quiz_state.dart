part of 'quiz_cubit.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizSuccess extends QuizState {
  List<Questions> questions;
  QuizSuccess(this.questions);
}

class QuizFailure extends QuizState {
  String error;
  QuizFailure(this.error);
}
