// import 'package:coachera/features/category/domain/entities/organization.dart';
// import 'package:dartz/dartz.dart';
//
// import '../../../../core/error/failures.dart';
// import '../../../../core/utils/app_util.dart';
// import '../../domain/repositories/organization_repository.dart';
// import '../data_source/lesson_remote_data_source.dart';
//
// class CategoryRepositoryImpl extends CategoryRepository {
//   final CategoryRemoteDataSource dataSource;
//
//   CategoryRepositoryImpl({
//     required this.dataSource,
//   });
//
//   @override
//   Future<Either<Failure, List<Category>>> getCategories({int? page}) async =>
//       await AppUtils.safeCall(
//           () async => await dataSource.getCategories(page: page));
// }
