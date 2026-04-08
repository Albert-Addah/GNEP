enum QuizMode { topic, course, level, mockExam }

class StudentProfile {
  const StudentProfile({
    required this.contact,
    required this.programmeId,
    required this.level,
    required this.institution,
  });

  final String contact;
  final String programmeId;
  final String level;
  final String institution;
}

class Programme {
  const Programme({
    required this.id,
    required this.name,
    required this.description,
    required this.courses,
  });

  final String id;
  final String name;
  final String description;
  final List<Course> courses;
}

class Course {
  const Course({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    required this.topics,
  });

  final String id;
  final String name;
  final String code;
  final String description;
  final List<Topic> topics;
}

class Topic {
  const Topic({
    required this.id,
    required this.title,
    required this.summary,
    required this.videoDuration,
    required this.notesCount,
    required this.questionBank,
  });

  final String id;
  final String title;
  final String summary;
  final String videoDuration;
  final int notesCount;
  final List<QuizQuestion> questionBank;
}

class QuizQuestion {
  const QuizQuestion({
    required this.id,
    required this.prompt,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });

  final String id;
  final String prompt;
  final List<String> options;
  final int correctIndex;
  final String explanation;
}
