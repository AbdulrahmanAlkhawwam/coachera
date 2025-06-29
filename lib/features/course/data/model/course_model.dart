import '../../domain/entities/course.dart';

class CourseModel extends Course {
  CourseModel({
    required super.id,
    required super.title,
    required super.description,
  });

  factory CourseModel.toMap(Map<String, dynamic> json) => CourseModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
      );
}
