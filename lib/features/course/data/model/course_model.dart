import 'package:coachera/features/category/domain/entities/category.dart';

import '../../../category/data/model/category_model.dart';
import '../../domain/entities/course.dart';

class CourseModel extends Course {
  CourseModel({
    required super.createdAt,
    required super.updatedAt,
    required super.id,
    required super.title,
    required super.description,
    required super.durationHours,
    required super.price,
    required super.rating,
    required super.orgId,
    required super.categories,
    required super.learningPathIds,
    required super.instructors,
    required super.image,
    required super.modules,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        title: json["title"],
        description: json["description"],
        durationHours: json["durationHours"],
        price: json["price"]?.toDouble(),
        rating: json["rating"]?.toDouble(),
        orgId: json["orgId"],
        categories: json["categories"],
        // List<Category>.from(
        //     json["categories"].map((x) => CategoryModel.fromJson(x))),
        learningPathIds:
            List<dynamic>.from(json["learningPathIds"].map((x) => x)),
        instructors: List<dynamic>.from(json["instructors"].map((x) => x)),
        image: json["image"],
        modules: List<Module>.from(
            json["modules"] ?? [].map((x) => Module.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "title": title,
        "description": description,
        "durationHours": durationHours,
        "price": price,
        "rating": rating,
        "orgId": orgId,
        // todo : fix this when the backend have been fix the bugs
        // "categories": List<dynamic>.from(categories.map((x) => x)),
        "learningPathIds": List<dynamic>.from(learningPathIds.map((x) => x)),
        "instructors": List<dynamic>.from(instructors.map((x) => x)),
        "image": image,
        "modules": List<dynamic>.from(modules.map((x) => x.toJson())),
      };
}

class Module {
  final dynamic createdAt;
  final dynamic updatedAt;
  final int id;
  final String title;
  final int courseId;
  final int orderIndex;
  final List<Section> sections;

  Module({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.title,
    required this.courseId,
    required this.orderIndex,
    required this.sections,
  });

  factory Module.fromJson(Map<String, dynamic> json) => Module(
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        id: json["id"],
        title: json["title"],
        courseId: json["courseId"],
        orderIndex: json["orderIndex"],
        sections: List<Section>.from(
            json["sections"].map((x) => Section.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "id": id,
        "title": title,
        "courseId": courseId,
        "orderIndex": orderIndex,
        "sections": List<dynamic>.from(sections.map((x) => x.toJson())),
      };
}

class Section {
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final String title;
  final int moduleId;
  final int orderIndex;
  final List<Material> materials;

  Section({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.title,
    required this.moduleId,
    required this.orderIndex,
    required this.materials,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        title: json["title"],
        moduleId: json["moduleId"],
        orderIndex: json["orderIndex"],
        materials: List<Material>.from(
            json["materials"].map((x) => Material.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "title": title,
        "moduleId": moduleId,
        "orderIndex": orderIndex,
        "materials": List<dynamic>.from(materials.map((x) => x.toJson())),
      };
}

class Material {
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final String title;
  final int sectionId;
  final int orderIndex;
  final Type type;
  final dynamic videoUrl;
  final String? article;
  final Quiz? quiz;

  Material({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.title,
    required this.sectionId,
    required this.orderIndex,
    required this.type,
    required this.videoUrl,
    required this.article,
    required this.quiz,
  });

  factory Material.fromJson(Map<String, dynamic> json) => Material(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        title: json["title"],
        sectionId: json["sectionId"],
        orderIndex: json["orderIndex"],
        type: typeValues.map[json["type"]]!,
        videoUrl: json["videoUrl"],
        article: json["article"],
        quiz: json["quiz"] == null ? null : Quiz.fromJson(json["quiz"]),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "title": title,
        "sectionId": sectionId,
        "orderIndex": orderIndex,
        "type": typeValues.reverse[type],
        "videoUrl": videoUrl,
        "article": article,
        "quiz": quiz?.toJson(),
      };
}

/*
enum Article {
  ADVANCED_TECHNIQUES_AND_BEST_PRACTICES_COVERED_HERE,
  IN_THIS_ARTICLE_WE_LL_EXPLORE_THE_KEY_CONCEPTS,
  LEARN_THE_FUNDAMENTALS_WITH_THIS_DETAILED_EXPLANATION,
  THIS_IS_A_COMPREHENSIVE_GUIDE_ON_THE_TOPIC
}
*/

/*
final articleValues = EnumValues({
  "Advanced techniques and best practices covered here...":
      Article.ADVANCED_TECHNIQUES_AND_BEST_PRACTICES_COVERED_HERE,
  "In this article, we'll explore the key concepts...":
      Article.IN_THIS_ARTICLE_WE_LL_EXPLORE_THE_KEY_CONCEPTS,
  "Learn the fundamentals with this detailed explanation...":
      Article.LEARN_THE_FUNDAMENTALS_WITH_THIS_DETAILED_EXPLANATION,
  "This is a comprehensive guide on the topic...":
      Article.THIS_IS_A_COMPREHENSIVE_GUIDE_ON_THE_TOPIC
});
*/

class Quiz {
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final int materialId;
  final List<Question> questions;

  Quiz({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.materialId,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        materialId: json["materialId"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "materialId": materialId,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final int quizId;
  final String content;
  final String? answer1;
  final String? answer2;
  final String? answer3;
  final String? answer4;

  Question({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.quizId,
    required this.content,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        quizId: json["quizId"],
        content: json["content"],
        answer1: json["answer1"],
        answer2: json["answer2"],
        answer3: json["answer3"],
        answer4: json["answer4"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "quizId": quizId,
        "content": content,
        "answer1": answer1,
        "answer2": answer2,
        "answer3": answer3,
        "answer4": answer4,
      };
}
/*
enum Answer1 {
  COMMON_MISCONCEPTION_OPTION_1,
  COMPLETELY_INCORRECT_OPTION_1,
  CORRECT_ANSWER_OPTION_1,
  ONLY_TRUE_IN_SPECIFIC_CASES_OPTION_1,
  OPPOSITE_OF_THE_TRUTH_OPTION_1,
  PARTIALLY_CORRECT_BUT_INCOMPLETE_OPTION_1
}*/

/*final answer1Values = EnumValues({
  "Common misconception (Option 1)": Answer1.COMMON_MISCONCEPTION_OPTION_1,
  "Completely incorrect (Option 1)": Answer1.COMPLETELY_INCORRECT_OPTION_1,
  "Correct answer (Option 1)": Answer1.CORRECT_ANSWER_OPTION_1,
  "Only true in specific cases (Option 1)":
      Answer1.ONLY_TRUE_IN_SPECIFIC_CASES_OPTION_1,
  "Opposite of the truth (Option 1)": Answer1.OPPOSITE_OF_THE_TRUTH_OPTION_1,
  "Partially correct but incomplete (Option 1)":
      Answer1.PARTIALLY_CORRECT_BUT_INCOMPLETE_OPTION_1
});*/
/*
enum Answer2 {
  COMMON_MISCONCEPTION_OPTION_2,
  COMPLETELY_INCORRECT_OPTION_2,
  CORRECT_ANSWER_OPTION_2,
  ONLY_TRUE_IN_SPECIFIC_CASES_OPTION_2,
  OPPOSITE_OF_THE_TRUTH_OPTION_2,
  PARTIALLY_CORRECT_BUT_INCOMPLETE_OPTION_2
}*/
/*
final answer2Values = EnumValues({
  "Common misconception (Option 2)": Answer2.COMMON_MISCONCEPTION_OPTION_2,
  "Completely incorrect (Option 2)": Answer2.COMPLETELY_INCORRECT_OPTION_2,
  "Correct answer (Option 2)": Answer2.CORRECT_ANSWER_OPTION_2,
  "Only true in specific cases (Option 2)":
      Answer2.ONLY_TRUE_IN_SPECIFIC_CASES_OPTION_2,
  "Opposite of the truth (Option 2)": Answer2.OPPOSITE_OF_THE_TRUTH_OPTION_2,
  "Partially correct but incomplete (Option 2)":
      Answer2.PARTIALLY_CORRECT_BUT_INCOMPLETE_OPTION_2
});*/
/*
enum Answer3 {
  COMMON_MISCONCEPTION_OPTION_3,
  COMPLETELY_INCORRECT_OPTION_3,
  CORRECT_ANSWER_OPTION_3,
  ONLY_TRUE_IN_SPECIFIC_CASES_OPTION_3,
  OPPOSITE_OF_THE_TRUTH_OPTION_3,
  PARTIALLY_CORRECT_BUT_INCOMPLETE_OPTION_3
}*/

/*final answer3Values = EnumValues({
  "Common misconception (Option 3)": Answer3.COMMON_MISCONCEPTION_OPTION_3,
  "Completely incorrect (Option 3)": Answer3.COMPLETELY_INCORRECT_OPTION_3,
  "Correct answer (Option 3)": Answer3.CORRECT_ANSWER_OPTION_3,
  "Only true in specific cases (Option 3)":
      Answer3.ONLY_TRUE_IN_SPECIFIC_CASES_OPTION_3,
  "Opposite of the truth (Option 3)": Answer3.OPPOSITE_OF_THE_TRUTH_OPTION_3,
  "Partially correct but incomplete (Option 3)":
      Answer3.PARTIALLY_CORRECT_BUT_INCOMPLETE_OPTION_3
});*/
/*
enum Answer4 {
  COMMON_MISCONCEPTION_OPTION_4,
  COMPLETELY_INCORRECT_OPTION_4,
  CORRECT_ANSWER_OPTION_4,
  ONLY_TRUE_IN_SPECIFIC_CASES_OPTION_4,
  OPPOSITE_OF_THE_TRUTH_OPTION_4,
  PARTIALLY_CORRECT_BUT_INCOMPLETE_OPTION_4
}*/

/*
final answer4Values = EnumValues({
  "Common misconception (Option 4)": Answer4.COMMON_MISCONCEPTION_OPTION_4,
  "Completely incorrect (Option 4)": Answer4.COMPLETELY_INCORRECT_OPTION_4,
  "Correct answer (Option 4)": Answer4.CORRECT_ANSWER_OPTION_4,
  "Only true in specific cases (Option 4)":
      Answer4.ONLY_TRUE_IN_SPECIFIC_CASES_OPTION_4,
  "Opposite of the truth (Option 4)": Answer4.OPPOSITE_OF_THE_TRUTH_OPTION_4,
  "Partially correct but incomplete (Option 4)":
      Answer4.PARTIALLY_CORRECT_BUT_INCOMPLETE_OPTION_4
});
*/

enum Type { ARTICLE, QUIZ, VIDEO }

final typeValues = EnumValues(
    {"ARTICLE": Type.ARTICLE, "QUIZ": Type.QUIZ, "VIDEO": Type.VIDEO});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
