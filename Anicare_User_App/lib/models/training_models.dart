class Course {
  final String id;
  final String title;
  final String duration;
  final String level;
  final String icon;
  final String description;
  final List<String> modules;

  Course({
    required this.id,
    required this.title,
    required this.duration,
    required this.level,
    required this.icon,
    required this.description,
    required this.modules,
  });
}

class Exam {
  final String id;
  final String title;
  final int questionCount;
  final int timeLimit;

  Exam({
    required this.id,
    required this.title,
    required this.questionCount,
    required this.timeLimit,
  });
}

class Question {
  final String question;
  final List<String> options;
  final int correctAnswer;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}

class Certificate {
  final String id;
  final String name;
  final DateTime issueDate;
  final String certificateId;

  Certificate({
    required this.id,
    required this.name,
    required this.issueDate,
    required this.certificateId,
  });
}

class NGORating {
  final String name;
  final double rating;
  final int reviewCount;

  NGORating({
    required this.name,
    required this.rating,
    required this.reviewCount,
  });
}
