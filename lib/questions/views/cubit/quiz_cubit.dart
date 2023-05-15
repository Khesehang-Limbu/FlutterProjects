import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/question_model.dart';
import '../../data/repository/api_repo.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  ApiRepo repo;
  QuizCubit(this.repo) : super(QuizInitial());
  void fetchQuestions() async {
    try {
      final questions = await repo.fetchQuestions();
      emit(QuizSuccess(questions));
    } catch (e) {
      emit(QuizFailure(e.toString()));
    }
  }
}
