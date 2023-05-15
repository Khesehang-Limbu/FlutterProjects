
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/question_model.dart';

class ApiRepo{
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
}
