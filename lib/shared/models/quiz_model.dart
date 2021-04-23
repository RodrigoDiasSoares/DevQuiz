import 'dart:convert';

import 'package:DevQuiz/shared/models/question_model.dart';

enum Level { facil, medio, dificil, perito }

extension LevelStringExt on String {
  Level get parse => {
        "Fácil": Level.facil,
        "Médio": Level.medio,
        "Difícil": Level.dificil,
        "Perito": Level.perito
      }[this]!;
}

extension LevelExt on Level {
  String get parse => {
        Level.facil: "Fácil",
        Level.medio: "Médio",
        Level.dificil: "Difícil",
        Level.perito: "Perito"
      }[this]!;
}

class QuizModel {
  final String title;
  final List<QuestionModel> questions;
  final int questionAnswered;
  final String imagem;
  final Level level;

  QuizModel({
    required this.questions,
    required this.title,
    this.questionAnswered = 0,
    required this.imagem,
    required this.level,
  }) : assert(questions.length > 0);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'questions': questions.map((x) => x.toMap()).toList(),
      'questionAnswered': questionAnswered,
      'imagem': imagem,
      'level': level.parse,
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      title: map['title'],
      questions: List<QuestionModel>.from(
          map['questions']?.map((x) => QuestionModel.fromMap(x))),
      questionAnswered: map['questionAnswered'],
      imagem: map['imagem'],
      level: map['level'].toString().parse,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizModel.fromJson(String source) =>
      QuizModel.fromMap(json.decode(source));
}
