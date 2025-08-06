import '../../../category/domain/entities/category.dart';
import '../../data/model/course_model.dart';

class Course {
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final String title;
  final String description;
  final String durationHours;
  final double price;
  final double rating;
  final int orgId;

  // todo : fix this when the backend change this
  final List<dynamic> /*List<Category>*/ categories;

  final List<dynamic> learningPathIds;
  final List<dynamic> instructors;
  final dynamic image;
  final List<Module> modules;

  Course({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.title,
    required this.description,
    required this.durationHours,
    required this.price,
    required this.rating,
    required this.orgId,
    required this.categories,
    required this.learningPathIds,
    required this.instructors,
    required this.image,
    required this.modules,
  });
}
