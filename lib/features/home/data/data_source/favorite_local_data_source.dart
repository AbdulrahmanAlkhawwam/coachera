import '../../../../core/constants/strings.dart';
import '../../../../core/helpers/database_helper.dart';
import '../../../../core/helpers/storage_helper.dart';
import '../../../course/data/model/course_model.dart';

abstract class FavoriteLocalDataSource {
  Future<void> emptyDB();

  Future<List<CourseModel>> enterCourses(List<CourseModel> favorite);
}

class FavoriteLocalDataSourceImpl extends FavoriteLocalDataSource {
  final StorageHelper storage;
  final DatabaseHelper database;

  FavoriteLocalDataSourceImpl({
    required this.storage,
    required this.database,
  });

  @override
  Future<void> emptyDB() async {
    await database.delete(favoriteTable);
  }

  @override
  Future<List<CourseModel>> enterCourses(List<CourseModel> favorite) async {
    for (final course in favorite) {
      await database.insert(
        favoriteTable,
        course.toJson(),
      );
    }
    return favorite;
  }
}
